# Define the binary name and output directory
BINARY_NAME=myapp
OUT_DIR=./bin

# Define the Go compiler to use
GO=go

# Default target executed when no arguments are given to make.
default: run

tidy:
	$(GO) mod tidy

# Builds the binary
build:
	mkdir -p $(OUT_DIR)
	$(GO) build -o $(OUT_DIR)/$(BINARY_NAME) .

# Runs the binary
run:
	$(GO) run .

# Cleans our project: deletes binaries and the output directory
clean:
	$(GO) clean
	rm -rf $(OUT_DIR)

# Installs our project: copies binaries to GOPATH/bin
install:
	$(GO) install

# Cross-compilation including ARMv7 for Android
cross:
	CGO_ENABLED=0 GOOS=linux GOARCH=amd64 $(GO) build -o $(OUT_DIR)/$(BINARY_NAME)-linux-amd64 .
	CGO_ENABLED=1 GOOS=linux GOARCH=arm GOARM=7 $(GO) build -o $(OUT_DIR)/$(BINARY_NAME)-linux-armv7 .
	# CGO_ENABLED=0 GOOS=windows GOARCH=amd64 $(GO) build -o $(OUT_DIR)/$(BINARY_NAME)-windows-amd64.exe .
	# CGO_ENABLED=0 GOOS=darwin GOARCH=amd64 $(GO) build -o $(OUT_DIR)/$(BINARY_NAME)-darwin-amd64 .

.PHONY: default tidy build run clean install cross
