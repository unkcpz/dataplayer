POST https://vip.creatis.insa-lyon.fr/rest/user/executions
apikey: {{VIP_API_KEY}}
```json
{
  "name" : "test-girder-with-api",
  "pipelineIdentifier":"FreeSurfer-Recon-all/7.3.1",
  "resultsLocation" : "/vip/Home",
  "inputValues" : {
    "license": "magicsGirder:69ce4ec84a2f40d5530303d5",
    "subjid": "test-brain",
    "nifti": "magicsGirder:69ce4ced4a2f40d5530303d2"
  }
}
```
