GOFMT_FILES?=$$(find . -type f -name '*.go')

default: dev

clean:
	@rm -rf "$(CURDIR)/bin"
	@rm -rf "$(CURDIR)/dist"

# dev creates binaries for testing locally.
# These are put into $GOPATH/bin
dev: tidy fmt
	@go build -race -o "$(CURDIR)/bin/scad-render" .

fmt:
	@gofmt -w $(GOFMT_FILES)

tidy:
	@go mod tidy

.NOTPARALLEL:

.PHONY: default dev fmt tidy
