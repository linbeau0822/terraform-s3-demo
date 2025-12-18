module "static_site" {
    source = "../../static_site"
    bucket_name = "my-unique-bucket-name-28812409-prod"
    environment = "prod"
    root_source_path = "index-prod.html"
}