output: {
	apiVersion: "tekton.dev/v1alpha1"
	kind:       "PipelineResource"
	metadata:
		name: context.name
	spec: {
		type: "git"
		params: [
			{
				name:  "url"
				value: parameter.repourl
			},
			{
				name:  "revision"
				value: parameter.revision
			},
		]
	}
}

outputs: task: {
	apiVersion: "tekton.dev/v1beta1"
	kind:       "Task"
	metadata:
		name: context.name
	spec: {
		resources: {
			inputs: [{
				name: "repo"
				type: "git"
			}]
		}
		steps: [
			for k, step in parameter.steps {
				name:  step.name
				image: step.image
				if step.command != _|_ {
					command: step.command
				}
				if step.args != _|_ {
					args: step.args
				}
				workingDir: "/workspace/repo"
				if step.env != _|_ {
					env: [
						for i, e in step.env {
							name:  e.name
							value: e.value
						},
					]
				}
			},
		]
	}
}

#Step: {
	name:  string
	image: string
	command: [...string]
	args: [...string]
	env: [...#Env]
}

#Env: {
	name:  string
	value: string
}

parameter: {
	// +usage=Specify the repository URL you want to pull
	repourl: string

	// +usage=Specify the repo revision
	revision: string

	// +usage=CI steps
	steps: [...#Step]
}
