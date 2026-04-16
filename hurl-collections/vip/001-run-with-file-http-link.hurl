POST https://vip.creatis.insa-lyon.fr/test/rest/executions
apikey: {{VIP_API_KEY}}
```json
{
	"name" : "test-http-with-api",
	"pipelineIdentifier":"CQUEST/0.6",
	"resultsLocation" : "/vip/Home",
	"inputValues" : {
		"parameter_file": "https://www.creatis.insa-lyon.fr/~abonnet/quest_param_117T_A.txt",
		"data_file": "https://www.creatis.insa-lyon.fr/~abonnet/Rec003_Vox1.mrui",
		"zipped_folder": "https://www.creatis.insa-lyon.fr/~abonnet/basis_11_7.zip"
	}
}
```

