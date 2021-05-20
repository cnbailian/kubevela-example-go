output: {
	apiVersion: "tekton.dev/v1beta1"
	kind:       "TaskRun"
	metadata:
		name: context.name
	spec: {
		if parameter.saname != _|_ {
			serviceAccountName: parameter.saname
		}
		taskRef: {
			name: parameter.taskname
		}
		resources: {
			inputs: [{
				name: "repo"
				resourceRef: {
					name: parameter.taskname
				}
			}]
		}
	}
}

parameter: {
	// +usage=Specify the taskrun TaskRef
	taskname: string

	// +usage=Specify the taskrun ServiceAccountName
	saname: string
}
