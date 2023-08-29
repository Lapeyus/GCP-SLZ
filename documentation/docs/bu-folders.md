# Terraform Google Folder Structure

This project provides a flexible and scalable folder structure for organizing resources within the Google Cloud Platform.


## Modules

### Folders
The `proj_folders` module is responsible for managing the folder hierarchy related to data projion.
Example usage:
```hcl
module "proj_folders" {
  source = "../modules/google_folder"
  // configuration details
}
```

## Resources

The resources provided in this code create a multi-layer folder structure within Google Cloud Platform.

## Dependencies

- Terraform v0.12 or higher
- Google Cloud Platform account with necessary permissions


# Code

{% include 'bu-folders.code' %}
