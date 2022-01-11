# Self-hosted Runner Container

This directory includes `Dockerfile`s for containers to run GitHub Actions self-hosted runner.

## Usage
### Preparation
To register a runner, get Personal Access Token from [here](https://github.com/settings/tokens).
Check "repo" and "workflow".
The token is used to get another token to register runner as `GITHUB_ACCESS_TOKEN`.

### Ubuntu Runner
#### Setup in Host Machine
To run a container on Ubuntu with GPU, setup environment for container to use GPU.
In host machine, run following:
```
cd ci
sudo ./install_nvidia_docker.sh
sudo systemctl restart docker
```

Details about the script is found [here](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html#docker)

#### Build & Run Container
Then build a container.
```
sudo docker build -t ci-runner-ubuntu -f Dockerfile.ubuntu .
```

And run it. Be sure to `.env` stores environment variable `GITHUB_ACCESS_TOKEN=XXXXXXXX`.
```
sudo docker run --rm -d --gpus all -v /var/run/docker.sock:/var/run/docker.sock --env-file ./.env -e LABELS="self-hosted,X64,Linux,ubuntu-self-hosted" ci-runner-ubuntu
```

## Environment Variables
|key|description|default|
|---|---|---|
|`RUNNER_NAME_PREFIX`|Used to define runner name(followed by UUID).|`qulacsosaka-ubuntu-ci`|
|`RUNNER_WORK_DIRECTORY`|Temporary directory for runner.|`/_work`|
|`RUNNER_REPOSITORY_URL`|Repository to run CI.|`https://github.com/Qulacs-Osaka/qulacs-osaka`|
|`LABELS`|Label to specify runner in workflow file in the repository.|`self-hosted,X64,Linux,ubuntu-self-hosted,gpu`|
|`GITHUB_ACCESS_TOKEN`|Personal Access Token(PAT) to fetch another token for runner registration dynamically. Specify either this or `RUNNER_TOKEN`.|None|
|`RUNNER_TOKEN`|This token is available at "Add runner" UI in the repository setting page. This token is updated frequently, so `GITHUB_ACCESS_TOKEN` is recommended.|None|

We recommend to store a token into `.env` file and provide it with `--env-file` option of `docker run` to avoid leave the token in a command history.

## Notice
Currently, nvcc test won't work properly with error: `too many resources requested for launch`.
* There is same error when test is performed in Docker manually
* `nvidia-smi` command works well in Docker, so GPU is recognized

For now, the test runs on runner installed in Ubuntu directly.
