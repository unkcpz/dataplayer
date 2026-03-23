# im/fetch_tosca_template.hurl
#
# Source: app/services/im.py  IM._get_tosca_template()
#
# This is the only raw requests.* call in im.py.
# All other IM operations (create, get_infra_property, get_infra_property
# "outputs", destroy) go through the imclient SDK (IMClient) which speaks
# to the Infrastructure Manager REST API internally — those are not
# expressed as raw requests calls in the Python source and therefore have
# no direct hurl translation.
#
# The one raw call:
#
#   GET {tosca_template_url}    timeout=10s
#
# This fetches the TOSCA YAML template whose URL is found in the RO-Crate
# service entity:
#   service["hasPart"][0]["url"]
#   where hasPart[0]["encodingFormat"] == "text/yaml"
#
# No auth header is sent — the template is expected to be publicly accessible
# (e.g. hosted on raw.githubusercontent.com).
#
# After fetching, im.py mutates the template in-process (_add_inputs_to_tosca_template,
# _add_files_to_tosca_template) and passes it to IMClient.create() — those
# steps are pure Python/YAML manipulation, not HTTP calls.
#
# Variables:
#   tosca_template_url   Public URL of the TOSCA YAML file, e.g.
#                        https://raw.githubusercontent.com/grycap/tosca/main/templates/galaxy.yaml

GET {{tosca_template_url}}

HTTP 200
[Asserts]
header "Content-Type" contains "yaml"
body exists
[Captures]
tosca_template_body: body
