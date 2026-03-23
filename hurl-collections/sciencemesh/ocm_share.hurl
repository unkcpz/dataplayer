# sciencemesh/ocm_share.hurl
#
# Source: app/vres/sciencemesh.py  VREScienceMesh.post()
#
# One outbound HTTP call is made by VREScienceMesh:
#
#   POST {svc_url}/ocm/shares
#
# The body is built by create_ocm_share_request() reading these named
# entities from the RO-Crate:
#   #receiver    → shareWith (userid)
#   #owner       → owner    (userid)
#   #sender      → senderDisplayName (name) + sender (userid, domain-rewritten)
#   #destination → fallback: {url: svc_url}
#   mainEntity   → name, description
#
# Sender userid rewriting (_generate_userid()):
#   "rasmus.oscar.welander@egi.eu"
#   becomes "rasmus.oscar.welander@{settings.host}"  (Dispatcher public FQDN)
#
# Headers:
#   Content-Type: application/json
#   Accept: application/json
#
# No auth header is forwarded to the ScienceMesh node.
#
# Variables:
#   sciencemesh_url       Base URL of the ScienceMesh node, e.g. https://sciencemesh.example.org
#   share_with            receiver's userid, e.g. bob@cernbox.cern.ch
#   crate_name            mainEntity name from RO-Crate
#   crate_description     mainEntity description from RO-Crate
#   owner_userid          #owner entity userid
#   sender_display_name   #sender entity name
#   sender_userid         #sender userid with Dispatcher FQDN appended
#                         e.g. alice@dispatcher.example.org
#   rocrate_metadata      inline JSON string of the full ro-crate-metadata.json
#                         (produced by crate.metadata.generate())

POST {{sciencemesh_url}}/ocm/shares
Content-Type: application/json
Accept: application/json
{
  "shareWith": "{{share_with}}",
  "name": "{{crate_name}}",
  "description": "{{crate_description}}",
  "providerId": "n/a",
  "resourceId": "n/a",
  "owner": "{{owner_userid}}",
  "senderDisplayName": "{{sender_display_name}}",
  "sender": "{{sender_userid}}",
  "resourceType": "ro-crate",
  "shareType": "user",
  "protocols": {
    "name": "multi",
    "rocrate": {{rocrate_metadata}}
  }
}

HTTP 200
