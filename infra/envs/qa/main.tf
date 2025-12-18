module "static_site" {
    source = "../../static_site"
    bucket_name = "my-unique-bucket-name-28812409-qa"
    environment = "qa"
    root_source_path = "index-qa.html"
}