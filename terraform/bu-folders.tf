/*
### Project A
 Creates the required folders for a project: a parent with 6 nested folder environments
*/
module "projecta_folders" {
  source = "../modules/google_folder"

  folders = {
    "${var.owner}-projecta" = { external_parent_id = module.folders.id["BussinesUnits"] },
    "${var.owner}-projecta-dev" = {
      name             = "dev"
      parent_entry_key = "${var.owner}-projecta"
    },
    "${var.owner}-projecta-stage" = {
      name             = "stage",
      parent_entry_key = "${var.owner}-projecta"
    },
    "${var.owner}-projecta-qa" = {
      name             = "qa"
      parent_entry_key = "${var.owner}-projecta"
    },
    "${var.owner}-projecta-prodfix" = {
      name             = "prodfix"
      parent_entry_key = "${var.owner}-projecta"
    },
    "${var.owner}-projecta-prod" = {
      name             = "prod"
      parent_entry_key = "${var.owner}-projecta"
    },
    "${var.owner}-projecta-dr" = {
      name             = "dr"
      parent_entry_key = "${var.owner}-projecta"
    },
  }
}
/*
### Project B
 Creates the required folders for a project: a parent with 6 nested folder environments
*/
module "projectb_folders" {
  source = "../modules/google_folder"

  folders = {
    "${var.owner}-projectb" = { external_parent_id = module.folders.id["BussinesUnits"] },
    "${var.owner}-projectb-dev" = {
      name             = "dev"
      parent_entry_key = "${var.owner}-projectb"
    },
    "${var.owner}-projectb-stage" = {
      name             = "stage",
      parent_entry_key = "${var.owner}-projectb"
    },
    "${var.owner}-projectb-qa" = {
      name             = "qa"
      parent_entry_key = "${var.owner}-projectb"
    },
    "${var.owner}-projectb-prodfix" = {
      name             = "prodfix"
      parent_entry_key = "${var.owner}-projectb"
    },
    "${var.owner}-projectb-prod" = {
      name             = "prod"
      parent_entry_key = "${var.owner}-projectb"
    },
    "${var.owner}-projectb-dr" = {
      name             = "dr"
      parent_entry_key = "${var.owner}-projectb"
    },
  }
}
/*
### Project C
 Creates the required folders for a project: a parent with 6 nested folder environments.
*/
module "projectc_folders" {
  source = "../modules/google_folder"

  folders = {
    "${var.owner}-projectc" = { external_parent_id = module.folders.id["BussinesUnits"] },
    "${var.owner}-projectc-dev" = {
      name             = "dev"
      parent_entry_key = "${var.owner}-projectc"
    },
    "${var.owner}-projectc-stage" = {
      name             = "stage",
      parent_entry_key = "${var.owner}-projectc"
    },
    "${var.owner}-projectc-qa" = {
      name             = "qa"
      parent_entry_key = "${var.owner}-projectc"
    },
    "${var.owner}-projectc-prodfix" = {
      name             = "prodfix"
      parent_entry_key = "${var.owner}-projectc"
    },
    "${var.owner}-projectc-prod" = {
      name             = "prod"
      parent_entry_key = "${var.owner}-projectc"
    },
    "${var.owner}-projectc-dr" = {
      name             = "dr"
      parent_entry_key = "${var.owner}-projectc"
    },
  }
}
