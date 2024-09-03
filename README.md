# Dev Environment Docker Images

This repository contains a collection of Docker images tailored for various development environments. Each image is built on a specific base image like `UBI8`, `UBI9`, `Alpine`, or `Ubuntu` and is designed to provide a consistent and reproducible environment for developers.

## Directory Structure

The repository is organized by base image and further categorized by the programming language, tool or purpose the image is built for. Versioning is also applied where necessary.

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

Open VSCode.
Navigate to the desired environment, e.g., dev-environments/ubuntu/nodejs/14.
VSCode will automatically detect the .devcontainer configuration and prompt you to reopen in the container.

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
