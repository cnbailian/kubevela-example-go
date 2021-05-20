# Repo info
GIT_COMMIT ?= git-$(shell git rev-parse --short HEAD)
TARGETARCH ?= amd64
IMAGE_REPO ?= cnbailian/vela
IMAGE_VERSION ?= latest

all: build-basic

# Run go fmt against code
fmt:
	go fmt ./...

# Run go vet against code
vet:
	go vet ./...

build-basic: fmt vet
	docker build -f gin-basic/Dockerfile --build-arg=GITVERSION=$(GIT_COMMIT) --build-arg=TARGETARCH=$(TARGETARCH) -t $(IMAGE_REPO)-basic:$(IMAGE_VERSION) .
