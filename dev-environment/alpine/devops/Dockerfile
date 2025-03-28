# Stage 1: Build Terraform, Go, Lazygit, Azure CLI, pre-commit, and terraform-docs
FROM alpine:3.21.2 AS builder

# Install dependencies for building
RUN apk --no-cache add \
    curl \
    git \
    go \
    make \
    build-base \
    py3-pip \
    python3-dev \
    libffi-dev \
    openssl-dev \
    gcc \
    musl-dev \
    bash

# Version variables
ENV TERRAFORM_VERSION=1.11.3
ENV TFLINT_VERSION=v0.55.0
ENV LAZYGIT_VERSION=0.48.0
ENV TERRAFORM_DOCS_VERSION=v0.19.0

# Install Terraform
RUN curl -fsSL https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip -o terraform.zip \
    && unzip terraform.zip \
    && mv terraform /usr/local/bin/terraform \
    && rm terraform.zip

# Install TFLint
RUN curl -fsSL https://github.com/terraform-linters/tflint/releases/download/${TFLINT_VERSION}/tflint_linux_amd64.zip -o tflint.zip \
    && unzip tflint.zip \
    && mv tflint /usr/local/bin/tflint \
    && rm tflint.zip

# Install Lazygit
RUN go install github.com/jesseduffield/lazygit@v${LAZYGIT_VERSION} \
    && mv /root/go/bin/lazygit /usr/local/bin/lazygit

# Install terraform-docs
RUN curl -fsSL https://github.com/terraform-docs/terraform-docs/releases/download/${TERRAFORM_DOCS_VERSION}/terraform-docs-${TERRAFORM_DOCS_VERSION}-linux-amd64.tar.gz -o terraform-docs.tar.gz \
    && tar -xzf terraform-docs.tar.gz \
    && mv terraform-docs /usr/local/bin/terraform-docs \
    && rm terraform-docs.tar.gz

# Create virtual environment and install Azure CLI
RUN python3 -m venv /opt/azcli \
    && . /opt/azcli/bin/activate \
    && pip install --no-cache-dir azure-cli \
    && deactivate

# Create virtual environment for pre-commit
RUN python3 -m venv /opt/pre-commit \
    && . /opt/pre-commit/bin/activate \
    && pip install --no-cache-dir pre-commit \
    && deactivate

# Stage 2: Create final minimal image
FROM alpine:3.21.2

# Install only necessary runtime dependencies
RUN apk --no-cache add \
    git \
    curl \
    ca-certificates \
    bash \
    vim \
    python3 \
    py3-pip \
    libc6-compat

# Copy binaries from builder stage
COPY --from=builder /usr/local/bin/terraform /usr/local/bin/terraform
COPY --from=builder /usr/local/bin/tflint /usr/local/bin/tflint
COPY --from=builder /usr/local/bin/lazygit /usr/local/bin/lazygit
COPY --from=builder /usr/local/bin/terraform-docs /usr/local/bin/terraform-docs
COPY --from=builder /opt/azcli /opt/azcli
COPY --from=builder /opt/pre-commit /opt/pre-commit

# Install Go
ARG GO_VERSION=1.23.1
RUN curl -fsSL https://dl.google.com/go/go${GO_VERSION}.linux-amd64.tar.gz | tar -C /usr/local -xz \
    && ln -s /usr/local/go/bin/go /usr/local/bin/go \
    && ln -s /usr/local/go/bin/gofmt /usr/local/bin/gofmt

# Set up Go environment variables
ENV GOPATH=/go
ENV PATH=$GOPATH/bin:/usr/local/go/bin:$PATH

# Copy the entrypoint script
COPY entrypoint.sh /usr/local/bin/entrypoint.sh

# Make the entrypoint script executable
RUN chmod +x /usr/local/bin/entrypoint.sh

# Set environment variables for both Azure CLI and pre-commit
ENV PATH="/opt/azcli/bin:/opt/pre-commit/bin:$PATH"

# Use the custom entrypoint to print message and system info
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

# Set entrypoint to bash for an interactive shell
CMD ["/bin/bash"]
