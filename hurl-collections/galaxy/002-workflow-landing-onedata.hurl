# galaxy/workflow_landing.hurl
#
# Source: app/vres/galaxy.py  VREGalaxy._send_workflow_request()
#
# Variant B: Onedata-backed input file
# File entity has "onedata:fileId" and "onedata:onezoneDomain" properties.
# _modify_for_api_data_input() builds the location as:
#   https://{oz_domain}/api/v3/onezone/shares/data/{file_id}/content

# POST {{galaxy_url}}/api/workflow_landings
# Content-Type: application/json
# Accept: application/json
# {
#   "public": true,
#   "workflow_id": "{{workflow_url}}",
#   "workflow_target_type": "url",
#   "request_state": {
#     "input_file": {
#       "class": "File",
#       "filetype": "txt",
#       "location": "https://{{onedata_oz_domain}}/api/v3/onezone/shares/data/{{onedata_file_id}}/content"
#     }
#   }
# }

POST https://usegalaxy.eu/api/workflow_landings
```json
{
  "public": false,
  "workflow_id": "https://dockstore.org/api/ga4gh/trs/v2/tools/%23workflow%2Fgithub.com%2Fbwalkowi%2Fgalaxy-workflow-ocr-test%2Fmain/versions/main/PLAIN_GALAXY/descriptor/galaxy-workflow-ocr-test-DaSCH.ga",
  "workflow_target_type": "trs_url",
  "request_state": {
    "image-to-process": {
      "class": "File",
      "filetype": "tiff",
      "location": "https://demo.onedata.org/api/v3/onezone/shares/data/00000000007EADF3736861726547756964233964613065396530393037303130393062356433623965356632643832353138636830386464233665366232326436663332623633646233346663666163353365353265323333636864386261233437656434633633333638393264396361626239316435636430623161663436636830343438/content"
    },
    "stopwords": {
      "class": "File",
      "filetype": "txt",
      "location": "https://demo.onedata.org/api/v3/onezone/shares/data/00000000007E21F3736861726547756964233937316538386630666539393765336430353065386566363536363130376632636830386464233665366232326436663332623633646233346663666163353365353265323333636864386261233437656434633633333638393264396361626239316435636430623161663436636830343438/content"
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
