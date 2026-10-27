# GCP-SLZ architecture

This document describes how the Terraform in `terraform/` is put together. All of it is one root module with a
single state. The `slz-*` files build the organization-wide foundation, and the `bu-*` files add business units on
top of it.

## 1. Layers and apply order

Terraform works out the order from references. The logical layers are:

```mermaid
flowchart TD
    A["tf-conf-*.tf<br/>providers · variables · org data source · random suffix"] --> B
    B["seed.tf<br/>seed project · tf-seed SA · org/project IAM · WIF pool + GitHub provider"] --> C
    B --> S["bu-tfstate-buckets.tf<br/>SLZ, CICD and per-environment state buckets (in seed project)"]
    C["slz-folders-core.tf<br/>Core · Shared · BusinessUnits"] --> D & E & F & G & H
    D["slz-groups.tf + slz-groups-iam.tf<br/>5 admin groups + role bindings"]
    E["slz-org-policy.tf<br/>15 org constraints"]
    F["slz-projects-network.tf<br/>Shared VPC host · 2 VPCs · PSA · NAT · connectors · FW policy"]
    G["slz-projects-billing.tf<br/>billing project · budgets · Pub/Sub"]
    H["slz-projects-log-monitor.tf<br/>monitoring project · org log sink · dashboards"]
    F --> I["slz-projects-cicd.tf<br/>CI/CD service project"]
    C --> J["bu-folders.tf<br/>per-project folder + 6 env folders"]
    J --> K["bu-projects.tf<br/>one service project per env folder"]
    F --> K
    J --> S
    J --> L["bu-groups.tf<br/>developers/devops/admins per BU folder"]
```

Bootstrap sequence on a new organization:

1. Run as a human org admin with local state. `terraform apply` creates the seed project, the `tf-seed` SA, the
   state buckets, and everything else.
2. Uncomment the `gcs` backend in `tf-conf-backend.tf` (bucket `<owner>-tf-seed-state`) and run
   `terraform init -migrate-state`.
3. Run a second apply. `bu-groups.tf` reads the `BusinessUnits` children through a data source, so the BU groups
   only appear once those folders exist.
4. Optional: turn on the commented `google-github-actions/auth` and `plan`/`apply` steps in
   `.github/workflows/terraform-slz.yml` so CI deploys through Workload Identity Federation instead of keys.

## 2. Resource hierarchy

```text
organizations/<org_id>
├── <owner>-seed                       (project, at org root)
├── Core/
│   ├── Billing/            → <owner>-cor-billing
│   ├── Logging-Monitoring/ → <owner>-logging-monitoring
│   ├── Security/
│   └── Network/            → <owner>-network   (Shared VPC host)
├── Shared/                 → <owner>-cicd      (Shared VPC service project)
│   ├── Shared-Prod/
│   └── Shared-NonProd/
└── BusinessUnits/
    ├── <owner>-projecta/
    │   ├── dev/ stage/ qa/ prodfix/ prod/ dr/   → one project each (Shared VPC service project)
    ├── <owner>-projectb/  (same)
    └── <owner>-projectc/  (same)
```

Projects are created with `terraform-google-modules/project-factory` 14.3.0, with random ID suffixes and the default
service account disabled or deleted. APIs come from `var.activate_apis[<type>]`. The seed project turns on the
**union** of every list so the `tf-seed` SA can manage them in child projects.

The local module `modules/google_folder` takes a map of folders that point to their parent either by
`external_parent_id` or by `parent_entry_key`. It resolves them in up to 10 layers of `google_folder` resources. The
same map can also carry folder IAM (`iam`, `iam_mode`), audit log configs, and legacy folder org policies.

## 3. Identity and access

| Principal | Scope | Roles (summary) |
|-----------|-------|-----------------|
| `tf-seed` SA | organization | organizationAdmin, projectCreator, folderAdmin, compute.xpnAdmin, serviceUsageAdmin, billing.user, iam.serviceAccountAdmin |
| `tf-seed` SA | seed project | service usage, SA key/admin/token creator, workload identity user and pool admin, storage admin/object roles |
| GitHub Actions (WIF) | `tf-seed` SA | `roles/iam.workloadIdentityUser` for `attribute.repository/<owner>/<repo>`. The provider's `attribute_condition` allows only `repository_owner == owner` |
| `admins@` | organization | organizationAdmin, iam.securityAdmin, orgpolicy.policyAdmin, billing.admin |
| `security-admins@` | organization | iam.securityAdmin, orgpolicy.policyAdmin, iam.serviceAccountAdmin, folderAdmin, logging.configWriter, compute.securityAdmin |
| `network-admins@` | organization | compute.networkAdmin, vpcaccess.admin, dns.admin, compute.loadBalancerAdmin, compute.securityAdmin |
| `audit-admins@` | organization | iam.securityReviewer, logging.viewer, audit.configViewer, errorreporting.viewer, serviceUsageConsumer |
| `project-admins@` | `BusinessUnits` and `Shared` folders | editor, SA admin and token creator, Artifact Registry admin, projectIamAdmin, storage.admin, compute.admin |
| `<bu>-developers/devops/admins@` | (groups only) | Created with empty `members` maps. No role bindings are defined yet |

The security, network, and audit groups have a commented `folders = [...]` line, so they can be narrowed from org
level to their `Core` subfolder.

## 4. Organization policies

All 15 are set at the organization with `org_policy_v2` 5.2.2, and every module declares `policy_type = "boolean"`:

`compute.skipDefaultNetworkCreation`, `storage.uniformBucketLevelAccess`, `storage.publicAccessPrevention`,
`compute.disableGlobalSerialPortAccess`, `compute.restrictXpnProjectLienRemoval`, `sql.restrictPublicIp`,
`compute.disableNestedVirtualization`, `compute.disableGuestAttributesAccess`, `compute.requireOsLogin`,
`iam.allowedPolicyMemberDomains`, `compute.vmExternalIpAccess`, `compute.restrictVpcPeering`,
`compute.restrictSharedVpcHostProjects`, `iam.disableServiceAccountKeyCreation`,
`iam.disableServiceAccountKeyUpload`.

Caveats in the current code:

- `compute.requireOsLogin` has `rules = []`, so it sets no enforcement rule. The other 14 have
  `enforcement = true`.
- `iam.allowedPolicyMemberDomains`, `compute.vmExternalIpAccess`, `compute.restrictVpcPeering`, and
  `compute.restrictSharedVpcHostProjects` are **list** constraints in Google Cloud but are declared here as boolean
  with no allowed values. Expect them to fail at apply, or to need `policy_type = "list"` with the allowed customer
  IDs, VMs, networks, or host projects for your organization.

Each module exposes `exclude_folders` / `exclude_projects` for exceptions.

## 5. Network

```mermaid
flowchart LR
    subgraph host["&lt;owner&gt;-network (Shared VPC host)"]
        subgraph pre["VPC preprod · GLOBAL routing · no default internet route"]
            pre_sn["us-east4 subnets 192.168.32-43.0/24<br/>(trans/projecta/cur × dev/qa/staging/prodfix)<br/>GKE secondary ranges 10.0.0.0/20"]
            pre_con["connector subnet 192.168.44.0/28<br/>vpcconn-preprod"]
            pre_nat["Cloud Router + NAT us-east4"]
            pre_psa["PSA range 192.168.88.0/21<br/>servicenetworking peering"]
        end
        subgraph prod["VPC production · GLOBAL routing · no default internet route"]
            prod_sn["us-east5 subnets 192.168.0-3.0/24<br/>us-west1 subnets 192.168.4-6.0/24"]
            prod_con["connector subnet 192.168.2.0/28<br/>vpcconn-prod (us-east5)"]
            prod_nat["Cloud Router + NAT us-east5"]
            prod_psa["PSA range 192.168.88.0/21"]
        end
        fw["Network firewall policy &lt;owner&gt;-main<br/>attached to both VPCs"]
    end
    svc["BU env projects + cicd<br/>(service projects)"] -->|svpc_host_project_id| host
    fw -.-> pre
    fw -.-> prod
```

- Both VPCs drop the default internet gateway routes. Egress goes through Cloud NAT.
- Private Service Access (Cloud SQL, Memorystore, and similar) uses a /21 per VPC, with custom routes imported and
  exported on the peering.
- The firewall policy module (`modules/network-firewall-policy`) builds global or regional network firewall policies,
  VPC associations, and rules. The two sample rules (ingress from owner IPs, egress for Cloud Run jobs) have **empty**
  IP lists and need values.

## 6. Logging, monitoring, billing

- **Org log sink** `<owner>-log-sink` (with children) sends audit activity, system events, access transparency, VPC
  flow logs, and firewall logs to `gs://<owner>-org-logs-<suffix>` in the monitoring project. Logs move to Coldline
  after 180 days and are deleted after 365.
- **Dashboards:** every `terraform/dashboards/*.json` file (BigQuery, Cloud Storage, GCE, GKE, Cloud SQL Postgres,
  registry, VPC flow logs) becomes a `google_monitoring_dashboard` in the monitoring project. The metrics-scope
  attachment (`google_monitoring_monitored_project`) is commented out.
- **Budgets:** the billing project gets a 1000 budget in the billing account's currency. Two budget modules publish
  alerts at 50%, 70%, and 100% to the `prod` / `preprod` Pub/Sub topics. As written, both budgets cover only the
  billing project itself.

## 7. Terraform state

All state buckets live in the seed project in `us-east1`, with public access prevention enforced and
`roles/storage.objectViewer` granted to `gcp-organization-admins@<owner>.com`:

- `<owner>-tf-seed-state`: state for this SLZ.
- `<owner>-tf-cicd-state`: state for CI/CD project workloads.
- One bucket per BU environment folder key (for example `<owner>-projecta-dev`), for the BU teams' own Terraform.

## 8. Documentation pipeline

```mermaid
flowchart LR
    tf[terraform/*.tf<br/>Markdown block comments] -->|doxygen.py| code[documentation/docs/code/*.code]
    tf -->|terraform-docs| tfreadme[terraform/README.md → docs/tfdocs.md]
    diag[docs/scripts/*.diagrams.py] -->|mkdocs-diagrams + Graphviz| img[rendered diagrams]
    code --> mk[MkDocs Material<br/>documentation/mkdocs.yml]
    tfreadme --> mk
    img --> mk
    mk -->|gh-deploy| pages[GitHub Pages]
```

The pages in `documentation/docs/*.md` pull in the generated `code/*.code` snippets through `mkdocs-macros`.

## 9. Known gaps

- A `google_service_account_key` is created in `seed.tf` while `iam.disableServiceAccountKeyCreation` is enforced.
  Delete the key after bootstrap and rely on WIF.
- The `gcp-organization-admins@` group named in the state-bucket IAM is not created by this code. The groups module
  creates `admins@<domain>`.
- The CI apply is turned off (commented out). Only lint, security scans, and `terraform fmt -check` run.
- Four list constraints are declared as boolean (see section 4).
- The seed API list has a typo (`seprojectbitycenter.googleapis.com`).
