# Dev Environment Docker Images

This repository contains a collection of Docker images tailored for various development environments. \
Each image is built on a specific base image like `UBI8`, `UBI9`, `Alpine`, or `Ubuntu` and is designed to provide a consistent and reproducible environment for developers.

## Directory Structure

The repository is organized by base image and further categorized by the programming language, tool or purpose the image is built for. \
Versioning is also applied where necessary.

### Naming Conventions

- **Base Image**: Organized under directories named after the base image, such as `ubi8`, `ubi9`, `alpine`, and `ubuntu`.
- **Tool/Language**: Each base image directory contains subdirectories named after the language, tool or purpose (e.g., `nodejs`, `python`, `java`, `devops`).
- **Versioning**: For languages or tools that have multiple versions, an additional subdirectory is used (e.g., `ubuntu/java/11`).

## Usage

To build a specific development environment, navigate to the desired directory and use Docker or Podman to build the image:

### Docker

```sh
cd dev-environments/ubuntu/nodejs/14
docker build -t my-nodejs-dev-env .
```

### Podman

```sh
cd dev-environments/ubuntu/nodejs/14
podman build -t my-nodejs-dev-env .
```

### VSCode

If you're using Visual Studio Code and want to utilize the .devcontainer configuration, you can directly open the project folder in VSCode:

Open VSCode. \
Navigate to the desired environment, e.g., dev-environments/ubuntu/nodejs/14. \
VSCode will automatically detect the .devcontainer configuration and prompt you to reopen in the container.

## Images

### Ubuntu

Ubuntu-based Development Environment with Terraform, Go, Lazygit, TFLint and Terraform-Docs. \
This container is based on Ubuntu 24.10 and is designed to provide a comprehensive development environment for Terraform, Go, and other related tools. It includes:

- **Terraform:** Infrastructure as Code (IaC) tool.
- **TFLint:** Linter for Terraform files.
- **Lazygit:** Simple terminal UI for Git.
- **Terraform-Docs:** Generates documentation for Terraform modules.
- **Azure CLI:** Installed in a Python virtual environment for managing Azure resources.
- **Pre-commit:** Installed in a separate Python virtual environment to run Git hooks.

This image is suited for developers working on Terraform configurations with a focus on automation, Git integration, and cloud infrastructure management.

### UBI 8

Red Hat UBI8-based Development Environment with Terraform, TFLint, and Azure CLI. \
This container uses Red Hat Universal Base Image 8 (UBI8) and focuses on providing a robust environment for enterprise-level infrastructure development:

- **Terraform:** For provisioning and managing infrastructure.
- **TFLint:** To ensure high-quality Terraform code.
- **Terraform-Docs:** For generating Terraform documentation.
- **Azure CLI:** Pre-installed to manage Azure resources directly from the container.
- **Pre-commit:** Installed for enforcing code quality through pre-configured Git hooks.

This image is best suited for developers working in Red Hat environments or those familiar with Red Hat's package management tools.

### UBI 9

Red Hat UBI9-based Development Environment with Terraform, Go, Lazygit, and TFLint. \
This image is based on Red Hat UBI9 and provides an environment geared towards infrastructure development with Terraform and Go:

- **Terraform:** For managing infrastructure.
- **TFLint:** To catch common issues in Terraform files.
- **Lazygit:** A terminal-based Git interface.
- **Terraform-Docs:** For generating documentation for Terraform projects.
- **Azure CLI:** Installed in a Python virtual environment to manage Azure services.
- **Pre-commit:** For enforcing Git pre-commit hooks, installed in its own virtual environment.

This image is intended for users working in Red Hat ecosystems who require a fully configured Terraform development environment along with cloud management tools.

### Alpine

Alpine-based Development Environment with Terraform, Go, Lazygit, TFLint and Azure CLI. \
This container uses Alpine Linux (v3.20.3) as a lightweight base and includes several tools for IaC development:

- **Terraform:** Core tool for infrastructure automation.
- **TFLint:** Helps enforce best practices and catch errors in Terraform files.
- **Lazygit:** Simplifies Git operations in the terminal.
- **Terraform-Docs:** Helps generate documentation for Terraform modules.
- **Azure CLI:** Available through a Python virtual environment to interact with Azure resources.
- **Pre-commit:** For managing Git hooks, installed in its own virtual environment.

This Alpine-based image is optimized for those who prefer a minimal footprint while still needing a full-featured Terraform and cloud development environment.

## Contributing

Contributions are welcome! Please follow these guidelines:

- Fork the repository.
- Create a new branch (git checkout -b feature/your-feature-name).
- Make your changes.
- Commit your changes (git commit -m 'Add some feature').
- Push to the branch (git push origin feature/your-feature-name).
- Open a Pull Request.

## License

This project is licensed under the MIT License.

## Contact

For any questions or issues, please open an issue in this repository or reach out via [E-Mail](mailto:joshua.f@posteo.de).
