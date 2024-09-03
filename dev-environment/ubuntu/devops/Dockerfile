# Stage 1: Build Terraform, Go, Lazygit, and Azure CLI
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
ENV TERRAFORM_VERSION=1.9.5
ENV TFLINT_VERSION=v0.53.0
ENV LAZYGIT_VERSION=0.43.1

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

# Create virtual environment and install Azure CLI
RUN python3 -m venv /opt/azcli \
    && /opt/azcli/bin/pip install --upgrade pip \
    && /opt/azcli/bin/pip install --no-cache-dir azure-cli

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
    unzip \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Copy binaries from builder stage
COPY --from=builder /usr/local/bin/terraform /usr/local/bin/terraform
COPY --from=builder /usr/local/bin/tflint /usr/local/bin/tflint
COPY --from=builder /usr/local/bin/lazygit /usr/local/bin/lazygit
COPY --from=builder /opt/azcli /opt/azcli

# Set the environment variable for Azure CLI
ENV PATH="/opt/azcli/bin:$PATH"

# Set entrypoint to bash for an interactive shell
ENTRYPOINT ["/bin/bash"]
