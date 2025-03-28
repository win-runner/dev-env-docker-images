# Stage 1: Build Terraform, Go, tflint and terraform-docs
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
ENV TERRAFORM_VERSION=1.11.3
ENV TFLINT_VERSION=v0.56.0
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

# Install terraform-docs
RUN curl -fsSL https://github.com/terraform-docs/terraform-docs/releases/download/${TERRAFORM_DOCS_VERSION}/terraform-docs-${TERRAFORM_DOCS_VERSION}-linux-amd64.tar.gz -o terraform-docs.tar.gz \
    && tar -xzf terraform-docs.tar.gz \
    && mv terraform-docs /usr/local/bin/terraform-docs \
    && rm terraform-docs.tar.gz

# Stage 2: Create final minimal image
FROM redhat/ubi8:8.10-1161

# Install runtime dependencies + build tools (temporarily)
RUN yum install -y \
    git \
    curl \
    ca-certificates \
    bash \
    vim \
    python3 \
    python3-pip \
    unzip \
    gcc \
    python3-devel \
    procps \
    hostname \
    && yum clean all

# Install Azure CLI in its own virtual environment at /opt/azcli
RUN python3 -m venv /opt/azcli \
    && /opt/azcli/bin/pip install --upgrade pip \
    && /opt/azcli/bin/pip install --no-cache-dir azure-cli

# Install pre-commit in its own virtual environment at /opt/pre-commit
RUN python3 -m venv /opt/pre-commit \
    && /opt/pre-commit/bin/pip install --upgrade pip \
    && /opt/pre-commit/bin/pip install --no-cache-dir pre-commit

# Remove build tools to keep the image minimal
RUN yum remove -y gcc python3-devel && yum clean all

# Copy binaries from builder stage
COPY --from=builder /usr/local/bin/terraform /usr/local/bin/terraform
COPY --from=builder /usr/local/bin/tflint /usr/local/bin/tflint
COPY --from=builder /usr/local/bin/terraform-docs /usr/local/bin/terraform-docs

# Copy the entrypoint script
COPY entrypoint.sh /usr/local/bin/entrypoint.sh

# Make the entrypoint script executable
RUN chmod +x /usr/local/bin/entrypoint.sh

# Set environment variables for both Azure CLI and pre-commit
ENV PATH="/opt/azcli/bin:/opt/pre-commit/bin:$PATH"

# Use the custom entrypoint to print message and system info
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

# Default to bash shell for interactivity
CMD ["/bin/bash"]
