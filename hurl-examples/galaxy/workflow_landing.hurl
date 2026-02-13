# galaxy/workflow_landing.hurl
#
# Source: app/vres/galaxy.py  VREGalaxy._send_workflow_request()
#
# One outbound HTTP call is made by VREGalaxy:
#
#   POST {svc_url}/api/workflow_landings
#
# The body is built by _prepare_workflow_data():
#   - "public"               GALAXY_PUBLIC_DEFAULT constant (bool)
#   - "workflow_id"          crate.mainEntity["url"]  (URL of the .ga workflow file)
#   - "workflow_target_type" GALAXY_WORKFLOW_TARGET_TYPE constant (string)
#   - "request_state"        dict keyed by File entity "name", built by
#                            _modify_for_api_data_input():
#       Each File entity becomes:
#         {
#           "class":    "File",
#           "filetype": <last segment of encodingFormat>,  e.g. "txt"
#           "location": <url>   — either entity["url"]
#                               — or Onedata:
#                                  https://{onedata:onezoneDomain}/api/v3/onezone/shares/data/{onedata:fileId}/content
#         }
#
# Headers set by _get_headers():
#   Content-Type: application/json
#   Accept: application/json
#
# On success the response JSON must contain "uuid" (_extract_landing_id()).
# No auth header is sent to Galaxy — the token is only used inside the
# Dispatcher itself, not forwarded.
#
# Variables:
#   galaxy_url    Base URL, e.g. https://usegalaxy.eu
#   workflow_url  URL of the .ga workflow (crate.mainEntity["url"])

# ── Variant A: direct-URL input file ────────────────────────────────────────
# File entity has a plain "url" property (no onedata:fileId).

POST {{galaxy_url}}/api/workflow_landings
Content-Type: application/json
Accept: application/json
{
  "public": true,
  "workflow_id": "{{workflow_url}}",
  "workflow_target_type": "url",
  "request_state": {
    "input_file": {
      "class": "File",
      "filetype": "txt",
      "location": "{{input_file_url}}"
    }
  }
}

HTTP 200
[Asserts]
jsonpath "$.uuid" exists
[Captures]
landing_uuid: jsonpath "$.uuid"

# Resulting redirect (built by _build_final_url(), no HTTP call):
# {{galaxy_url}}/workflow_landings/{{landing_uuid}}?public=true


# ── Variant B: Onedata-backed input file ─────────────────────────────────────
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
#
# HTTP 200
# [Asserts]
# jsonpath "$.uuid" exists
# [Captures]
# landing_uuid: jsonpath "$.uuid"
