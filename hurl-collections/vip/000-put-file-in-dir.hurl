# hurl --variable file_path=<path> upload_file=<local-file> --secrets-file .secrets <this-hurl>

# example
# hurl --variable file_path=/vip/Home/ --variable upload_file=dummy.txt --secrets-file .secrets hurl-collections/vip/000-put-file-in-dir.hurl -v

PUT https://vip.creatis.insa-lyon.fr/rest/path{{file_path}}
apikey: {{VIP_API_KEY}}

file,{{upload_file}};
