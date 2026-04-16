# hurl --variable file_path=<path> --secrets-file .secrets <this-hurl>
GET https://vip.creatis.insa-lyon.fr/rest/path/{{file_path}}?action=list
apikey: {{VIP_API_KEY}}
