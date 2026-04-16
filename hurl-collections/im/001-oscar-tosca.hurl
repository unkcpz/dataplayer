# Run:
# `hurl --very-verbose --secret OIDC_AGENT_TOKEN=(oidc-token egi) 001-osca-tosca.hurl`

# talk to IM to get the resource first, need token

# Get the tosca template from url
GET https://raw.githubusercontent.com/grycap/tosca/refs/heads/main/templates/oscar.yaml
HTTP 200

# NOTE: the template is modified with the required resources specified.
# The filled template is stored in the folder as `resource.yaml`
# In the real implementation, this file need to be programmaly prepared

# NOTE: The template requires following fields being filled (check _add_inputs_to_tosca_template)
# ?? (_add_files_to_tosca_template used where, for what??)

# deploy an infrastracture service
POST http://test.endpoint
Content-Type: text/yaml
file,template.yaml;
HTTP 200
[Captures]
inf_id: body

# polling until the infrastructure acquisition ready
# ready flag is the state of GET call to infrastructures/{{inf_id}}/state endpoint return "configured"
GET http://test.endpoint/infrastructures/{{inf_id}}/state
HTTP 200
[Options]
repeat: 10

# then get the output. -> get_infra_property(self.inf_id, "outputs")

