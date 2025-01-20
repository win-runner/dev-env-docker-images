# Stage 1: Build Terraform, Go, Lazygit, tflint and terraform-docs
FROM golang:1.22 AS builder

# Install dependencies for building
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    git \
    gcc \
    make \
    python3 \
    python3-pip \
    python3-venv \
    libffi-dev \
    libssl-dev \
    bash \
    unzip \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Version variables
ENV TERRAFORM_VERSION=1.10.4
ENV TFLINT_VERSION=v0.54.0
ENV LAZYGIT_VERSION=0.44.1
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
RUN GOBIN=/usr/local/bin go install github.com/jesseduffield/lazygit@v${LAZYGIT_VERSION}

# Install terraform-docs
RUN curl -fsSL https://github.com/terraform-docs/terraform-docs/releases/download/${TERRAFORM_DOCS_VERSION}/terraform-docs-${TERRAFORM_DOCS_VERSION}-linux-amd64.tar.gz -o terraform-docs.tar.gz \
    && tar -xzf terraform-docs.tar.gz \
    && mv terraform-docs /usr/local/bin/terraform-docs \
    && rm terraform-docs.tar.gz

# Stage 2: Create final minimal image
FROM ubuntu:24.10

# Install only necessary runtime dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    curl \
    ca-certificates \
    bash \
    vim \
    python3 \
    python3-pip \
    python3.12-venv \
    unzip \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Create virtual environment and install Azure CLI
RUN python3 -m venv /opt/azcli \
    && /opt/azcli/bin/pip install --upgrade pip \
    && /opt/azcli/bin/pip install --no-cache-dir azure-cli

# Install pre-commit in its own virtual environment at /opt/pre-commit
RUN python3 -m venv /opt/pre-commit \
    && /opt/pre-commit/bin/pip install --upgrade pip \
    && /opt/pre-commit/bin/pip install --no-cache-dir pre-commit

# Copy binaries from builder stage
COPY --from=builder /usr/local/bin/terraform /usr/local/bin/terraform
COPY --from=builder /usr/local/bin/tflint /usr/local/bin/tflint
COPY --from=builder /usr/local/bin/lazygit /usr/local/bin/lazygit
COPY --from=builder /usr/local/bin/terraform-docs /usr/local/bin/terraform-docs

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
