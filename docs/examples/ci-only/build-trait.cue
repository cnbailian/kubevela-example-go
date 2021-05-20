patch: {
	// +patchKey=name
	spec: steps: [{
		name:  "build"
		image: "gcr.io/kaniko-project/executor:latest"
		command: [
			"/kaniko/executor",
			"--dockerfile=\(parameter.dockerfile)",
			"--context=/workspace/repo",
			"--destination=\(parameter.image)",
			"--insecure",
		]
		env: [{
			name:  "DOCKER_CONFIG"
			value: "/tekton/home/.docker"
		}]
	}]
}

parameter: {
	// +usage=Specify the image repourl
	image: string

	// +usage=Specify the Dockerfile path
	dockerfile: *"Dcokerfile" | string
}
