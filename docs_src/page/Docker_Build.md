# Build This Dockerfile

If you choose to build your own image from Dockerfile.



## Manual Build Bash Command Example

- Format
	```bash
	docker build -t {image_name}:{image_tag} -f Dockerfile.ubuntu .
	docker build -t {image_name}:{image_tag} -f Dockerfile.alpine .
	docker build -t {image_name}:{image_tag} -f Dockerfile.arch .
	docker build -t {image_name}:{image_tag} -f Dockerfile.debian .
	```

- Example
	```bash
	docker build -t jasonyangee/stm32-builder:ubuntu-latest -f Dockerfile.ubuntu .
	```

## Auto Build Using VS Code Tasks

- `Ctrl + Shift + p` and enter `run task` and choose the build options: `Build Ubuntu`.
- Modify the build arguments in `.vscode/tasks.json` if you wish to have different image name.
	```
	stm32-builder:ubuntu-latest",
	```


## User Modifications

**Check ARM releases at here:**

*<https://developer.arm.com/downloads/-/arm-gnu-toolchain-downloads/>*

- Modify `ARM_VERSION=14.2.rel1` for enforcing compiler version.

- If pulling latest version is desired, insert this line before `curl` command in dockerfile.

	```docker
	&& ARM_VERSION=$(curl -s https://developer.arm.com/downloads/-/arm-gnu-toolchain-downloads | grep -Po '<h4>Version \K.+(?=</h4>)') \
	```


## Github Action Variables

For those who want to setup your own github action to auto publish variation of this dockerfile to your own docker registry. You may copy my action yml file setup and define the following github variables.

```c
vars.REGISTRY			// Github package link (private: "ghcr.io"   organization: "ghcr.io/Org_Name")
secrete.DOCKERHUB_TOKEN		// Docker Hub login token
secrete.DOCKERHUB_USERNAME	// Docker Hub username
secrete.TOKEN_GITHUB_PERSONAL	// Github package token
secrete.USER_GITHUB_PERSONAL	// Github package username
```