# This is supposed to be run first

# hurl --variable storageId=magicsGirder --secrets-file .secrets <this-hurl>

PUT https://vip.creatis.insa-lyon.fr/rest/user/externalKeys
apikey: {{VIP_API_KEY}}
```json
{
  "storageIdentifier": "{{storageId}}",
  "apiKey": "{{GIRDER_API_KEY}}"
}
```
