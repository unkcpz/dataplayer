# requests to create a project in RRP
# Run:
# `hurl --very-verbose --secret OIDC_AGENT_TOKEN=(oidc-token egi) 001-create-project-token.hurl`

# The lifecycle of this use case is
# 1. create the project (no interval needed, the project name should available in the next call)
# 2. start the project (start takes some time)
# 3. check the state of the jupyter container until it is running
# 4. return the jupyter notebook url to user to open in their browser.

# create a rrp project
POST https://rrp-eosc.ethz.ch/api/projects
Authorization: Bearer {{OIDC_AGENT_TOKEN}}
```json
{
  "type": "createFromExternalCatalog",
  "image": "reproducibleresearchplatform/rrp-tst:q75v54b-cunya",
  "environmentType": "jupyterlab"
}
```
HTTP 201
[Captures]
project_url: header "Location"

# TODO: -> RRP can the project-id returned in the respond as a field I can use?
# start the project
POST {{project_url}}
Authorization: Bearer {{OIDC_AGENT_TOKEN}}
[Options]
retry: 10
retry-interval: 2000ms
```json
{
  "type": "start",
  "remote": false
}
```
HTTP 201

# check the status
GET {{project_url}}
# GET https://rrp-eosc.ethz.ch/api/projects/dpncq5be
Authorization: Bearer {{OIDC_AGENT_TOKEN}}
HTTP 200
[Asserts]
jsonpath "$.userAppStatus.type" == "Running"
[Captures]
app_url: jsonpath "$.userAppStatus.location"

# make sure the app_url is accessable jupyter notebook
GET {{app_url}}
Authorization: Bearer {{OIDC_AGENT_TOKEN}}
HTTP 200

