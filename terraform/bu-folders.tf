module "projecta_folders" {
  source = "../modules/google_folder"

  folders = {
    "owner-projecta" = { external_parent_id = module.folders.id["owner"] },
    "owner-projecta-dev" = {
      name             = "dev"
      parent_entry_key = "owner-projecta"
    },
    "owner-projecta-stage" = {
      name             = "stage",
      parent_entry_key = "owner-projecta"
    },
    "owner-projecta-qa" = {
      name             = "qa"
      parent_entry_key = "owner-projecta"
    },
    "owner-projecta-prodfix" = {
      name             = "prodfix"
      parent_entry_key = "owner-projecta"
    },
    "owner-projecta-prod" = {
      name             = "prod"
      parent_entry_key = "owner-projecta"
    },
    "owner-projecta-dr" = {
      name             = "dr"
      parent_entry_key = "owner-projecta"
    },
  }
}

module "projectb_folders" {
  source = "../modules/google_folder"

  folders = {
    "owner-projectb" = { external_parent_id = module.folders.id["owner"] },
    "owner-projectb-dev" = {
      name             = "dev"
      parent_entry_key = "owner-projectb"
    },
    "owner-projectb-stage" = {
      name             = "stage",
      parent_entry_key = "owner-projectb"
    },
    "owner-projectb-qa" = {
      name             = "qa"
      parent_entry_key = "owner-projectb"
    },
    "owner-projectb-prodfix" = {
      name             = "prodfix"
      parent_entry_key = "owner-projectb"
    },
    "owner-projectb-prod" = {
      name             = "prod"
      parent_entry_key = "owner-projectb"
    },
    "owner-projectb-dr" = {
      name             = "dr"
      parent_entry_key = "owner-projectb"
    },
  }
}

module "projectc_folders" {
  source = "../modules/google_folder"

  folders = {
    "owner-projectc" = { external_parent_id = module.folders.id["owner"] },
    "owner-projectc-dev" = {
      name             = "dev"
      parent_entry_key = "owner-projectc"
    },
    "owner-projectc-stage" = {
      name             = "stage",
      parent_entry_key = "owner-projectc"
    },
    "owner-projectc-qa" = {
      name             = "qa"
      parent_entry_key = "owner-projectc"
    },
    "owner-projectc-prodfix" = {
      name             = "prodfix"
      parent_entry_key = "owner-projectc"
    },
    "owner-projectc-prod" = {
      name             = "prod"
      parent_entry_key = "owner-projectc"
    },
    "owner-projectc-dr" = {
      name             = "dr"
      parent_entry_key = "owner-projectc"
    },
  }
}
