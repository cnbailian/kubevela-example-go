outputs: run: {
	apiVersion: "tekton.dev/v1beta1"
	kind:       "TaskRun"
	metadata:
		name: parameter.name
	spec: {
		if parameter.saname != _|_ {
			serviceAccountName: parameter.saname
		}
		taskRef: {
			name: context.name
		}
		resources: {
			inputs: [{
				name: "repo"
				resourceRef: {
					name: context.name
				}
			}]
		}
	}
}

parameter: {
	// +usage=Specify the taskrun name
	name: string

	// +usage=Specify the taskrun ServiceAccountName
	saname: string
}
