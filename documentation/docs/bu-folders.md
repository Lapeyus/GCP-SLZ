# Terraform Google Folder Structure

This project provides a flexible and scalable folder structure for organizing resources within the Google Cloud Platform.

## Modules

### Ingest Folders
The `ingest_folders` module is responsible for managing the folder hierarchy related to data ingestion.
Example usage:
```hcl
module "ingest_folders" {
  source = "../modules/google_folder"
  // configuration details
}
```

### Curated Folders
The `curated_folders` module is responsible for managing the folder hierarchy for curated datasets.
Example usage:
```hcl
module "curated_folders" {
  source = "../modules/google_folder"
  // configuration details
}
```

### Transformation Folders
The `trans_folders` module is responsible for managing the folder hierarchy for data transformation.
Example usage:
```hcl
module "trans_folders" {
  source = "../modules/google_folder"
  // configuration details
}
```

## Resources

The resources provided in this code create a multi-layer folder structure within Google Cloud Platform.

## Dependencies

- Terraform v0.12 or higher
- Google Cloud Platform account with necessary permissions
