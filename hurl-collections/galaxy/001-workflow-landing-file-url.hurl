# galaxy/workflow_landing.hurl
#
# Source: app/vres/galaxy.py  VREGalaxy._send_workflow_request()
#

# Variant A: direct-URL input file 
# File entity has a plain "url" property (no onedata:fileId).

POST https://usegalaxy.eu/api/workflow_landings
```json
{
  "public": false,
  "workflow_id": "https://dockstore.org/api/ga4gh/trs/v2/tools/%23workflow%2Fgithub.com%2Flaitanawe%2Fismb2024%2Fgalaxy_example/versions/main/PLAIN_GALAXY/descriptor/Galaxy-Workflow-reverse_file_galaxy_workflow.ga",
  "workflow_target_type": "trs_url",
  "request_state": {
    "simpletext_input": {
      "class": "File",
      "filetype": "txt",
      "location": "https://example-files.online-convert.com/document/txt/example.txt"
    }
  }
}
```
HTTP 200
[Asserts]
jsonpath "$.uuid" exists
[Captures]
landing_uuid: jsonpath "$.uuid"

# Resulting redirect (built by _build_final_url(), no HTTP call):
# NOTE: the ?public=false the false is same as the json payload above
#
# GET https://usegalaxy.eu/workflow_landings/{{landing_uuid}}?public=false
# HTTP 200
