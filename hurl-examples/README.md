# Dispatcher VRE API calls — hurl collection

Translated from `app/vres/` and `app/services/im.py`.
Each `.hurl` file contains only the HTTP calls that are actually made by
the Python source using `requests.*`. SDK-wrapped calls and pure in-process
operations are documented in comments but not expressed as hurl entries.

---

## Directory layout

```
dispatcher-hurl/
├── galaxy/
│   └── workflow_landing.hurl      POST /api/workflow_landings
├── sciencemesh/
│   └── ocm_share.hurl             POST /ocm/shares
├── im/
│   └── fetch_tosca_template.hurl  GET  <tosca_template_url>
└── binder/
    └── README.md                  No outbound HTTP calls — see explanation
```

---

## Target summary

| Target | File | Method | Endpoint | Source |
|---|---|---|---|---|
| Galaxy | `galaxy/workflow_landing.hurl` | POST | `{galaxy_url}/api/workflow_landings` | `VREGalaxy._send_workflow_request()` |
| ScienceMesh | `sciencemesh/ocm_share.hurl` | POST | `{sciencemesh_url}/ocm/shares` | `VREScienceMesh.post()` |
| IM (TOSCA) | `im/fetch_tosca_template.hurl` | GET | `{tosca_template_url}` | `IM._get_tosca_template()` |
| Binder | `binder/README.md` | — | — | No outbound HTTP calls |

---

## Running

### Galaxy

```bash
hurl --variable galaxy_url=https://usegalaxy.eu \
     --variable workflow_url=https://example.com/my-workflow.ga \
     --variable input_file_url=https://example.com/input.txt \
     galaxy/workflow_landing.hurl
```

### ScienceMesh

```bash
hurl --variable sciencemesh_url=https://sciencemesh.example.org \
     --variable share_with=bob@cernbox.cern.ch \
     --variable crate_name="My dataset" \
     --variable crate_description="A test RO-Crate" \
     --variable owner_userid=alice@example.org \
     --variable sender_display_name="Alice Smith" \
     --variable sender_userid=alice@dispatcher.example.org \
     --variable rocrate_metadata='{"@context":"...","@graph":[...]}' \
     sciencemesh/ocm_share.hurl
```

### IM — fetch TOSCA template

```bash
hurl --variable tosca_template_url=https://raw.githubusercontent.com/grycap/tosca/main/templates/galaxy.yaml \
     im/fetch_tosca_template.hurl
```

---

## Notes on IM (Infrastructure Manager)

`im.py` uses the `imclient` SDK for all infrastructure lifecycle calls
(create, get state, get outputs, destroy). Those calls speak to the IM
REST API at `settings.im_endpoint` but are fully encapsulated by the SDK —
no raw `requests.*` calls are made for them in the Python source.

The only raw `requests` call in `im.py` is `IM._get_tosca_template()`:
a plain unauthenticated `GET` to fetch a public TOSCA YAML file before
passing it to the SDK.

## Notes on Binder

`VREBinder` performs only local operations (mkdir, unzip, git init/commit).
The redirect URL it returns points back to the Dispatcher's own git daemon —
not to an external API. See `binder/README.md` for details.
