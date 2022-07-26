# Qulacs Docker Images

[日本語版](./README-ja.md)

## Build & Test Qulacs in Docker
Requirements: Docker([installation](https://docs.docker.com/engine/install/))

Docker prepares environment required to compile & install qulacs. This is useful for debugging because we can run program in almost the same environment.
You may need root priviledge to use docker command.

For Ubuntu-based container, the easiest way is pulling pre-built image from GitHub. 
First, log in to GitHub Container Registry.
```bash
docker login ghcr.io
```

Then you will be asked username and password, fill them with GitHub's ones.
If you enable two factor authentication on GitHub, use PAT(Persona Access Token) instead of password.
Refer to [this document](https://docs.github.com/en/github/authenticating-to-github/creating-a-personal-access-token) to create PAT.
When you create a PAT, enable `read:packages`, `write:packages`, and `delete:packages` scopes.

After logged in, you can pull the image.
```bash
docker pull ghcr.io/qulacs/qulacs-ubuntu-conda:latest
```

We have useful aliases to invoke containers, let's activate them first.
```bash
source .aliases.sh
# To persist, write to .bashrc
echo "source /path/to/.aliases.sh" >> .bashrc
# Or .zshrc
echo "source /path/to/.aliases.sh" >> .zshrc
```
The default container name invoked by the aliases is `ghcr.io/qulacs/qulacs-ubuntu-pyenv:latest`. If you want to use another container, update `CONTAINER_NAME` in `.aliases.sh`. For example, `CONTAINER_NAME=ghcr.io/qulacs/qulacs-ubuntu-conda`. After modification, run `source .aliases.sh` or reload your terminal.

For build and test, run these commands.
```bash
cd /path/to/qulacs
# Build qulacs for C++
qulacs_run
# Run test
qulacs_test
# Install Python module into ./dist
qulacs_install
# Run arbitrary commands in containers
qulacs_run ls -la
qulacs_run echo "Hello"
```

If you want to build an image by yourself, just run following:
```bash
cd /path/to/this/repository
docker build -t qulacs-env -f Dockerfile.ubuntu .
```

If you want to use a CentOS based image, build with `Dockerfile.centos` instead of `Dockerfile.ubuntu.*`.

## About images
### Which one to use?
If you want useful packages bundled with Anaconda, use `qulacs-ubuntu-conda`. This image size is bigger, but more versatile.  
Or if you just build and test qulacs, use `qulacs-ubuntu-pyenv`. Its available packages are limited, but it has smaller image size and is enough to develop qulacs.

### `qulacs-ubuntu-conda`
Python environment: Anaconda  
Python version: 3.8.8  
OS: Ubuntu  
GPU Compatible: No  
Be careful that this image has about 5GB.

### `qulacs-ubuntu-pyenv`
Python environment: pyenv  
Python version: 3.8.8  
OS: Ubuntu  
GPU Compatible: No  
This image is smaller version(about 1.2GB).

## Development in this repository
### Issue
Create an issue for every feature and modification. Issue as an idea or an proposition without implementation is welcomed.

### Branch
Create branch for the issue to start developing the new feature. Branch name convension is `{issue number}-{feature summary}`. For example, `3-role-install-boost`(use `-` for delimeter).

### Pull Request
After implementation, create Pull Request(PR) to the `main` branch from the feature branch you are on now. Another contributor should review the PR change to understand the new feature and find bugs.
