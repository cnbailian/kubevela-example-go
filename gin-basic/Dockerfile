# Build the manager binary
FROM --platform=${BUILDPLATFORM:-linux/amd64} golang:1.16-alpine as builder

WORKDIR /workspace
# Copy the Go Modules manifests
COPY go.mod go.mod
COPY go.sum go.sum
# cache deps before building and copying source so that we don't need to re-download as much
# and so that source changes don't invalidate our downloaded layer
RUN go mod download

# Copy the go source
COPY gin-basic/main.go main.go

# Build
ARG TARGETARCH
ARG GITVERSION
RUN GO111MODULE=on CGO_ENABLED=0 GOOS=linux GOARCH=${TARGETARCH} \
    go build -a -ldflags "-s -w -X 'main.GoVersion=$(go version)' -X main.GitRevision=${GITVERSION:-undefined}" \
    -o main-${TARGETARCH} main.go

ARG BASE_IMAGE
FROM ${BASE_IMAGE:-alpine:latest}

WORKDIR /

ARG TARGETARCH
COPY --from=builder /workspace/main-${TARGETARCH} /usr/local/bin/main

CMD ["main"]
