POST https://rrp-eosc.ethz.ch/api/projects
Authorization: Bearer {{OIDC_AGENT_TOKEN}}
```json
{
  "type": "createFromExternalCatalog",
  "image": "reproducibleresearchplatform/rrp-tst:q75v54b-cunya",
  "environmentType": "jupyterlab"
}
```

