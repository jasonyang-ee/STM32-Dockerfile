[![Build](https://github.com/jasonyang-ee/STM32-Dockerfile/actions/workflows/build.yml/badge.svg)](https://github.com/jasonyang-ee/STM32-Dockerfile/actions/workflows/build.yml)
[![Build](https://github.com/jasonyang-ee/STM32-Dockerfile/actions/workflows/push.yml/badge.svg)](https://github.com/jasonyang-ee/STM32-Dockerfile/actions/workflows/push.yml)

# Docker Build for STM32 Toolchain

### Image
```
docker pull jasonyangee/stm32_ubuntu
docker pull jasonyangee/stm32_alpine
```

Dockerfile: https://github.com/jasonyang-ee/STM32-Dockerfile.git

Example Project: https://github.com/jasonyang-ee/STM32-CMAKE-TEMPLATE.git

## Packages

- build-essential
- git
- cmake
- ninja-build
- stlink-tools


## Compiler

 - ARM GNU x86_64-arm-none-eabi  (939 MB)



## User Modifications

**Check ARM releases at here: https://developer.arm.com/downloads/-/arm-gnu-toolchain-downloads/**

- Modify `TOOLS_PATH=/opt/gcc-arm-none-eabi` for changing compiler default folder.

- Modify `ARM_VERSION=12.2.rel1` for enforcing compiler version.

- If pulling latest version is desired, insert this line before `curl` command

```docker
&& ARM_VERSION=$(curl -s https://developer.arm.com/downloads/-/arm-gnu-toolchain-downloads | grep -Po '<h4>Version \K.+(?=</h4>)') \
```



## Build Docker

If you choose to build from this Dockerfile, a pre-configured VS Code Tasks has been setup to build automatically.

1. Modify the image build tag to be your Docker Hub username in `.vscode/tasks.json`
```
"jasonyangee/stm32_ubuntu:latest",
"jasonyangee/stm32_alpine:latest",
```
2. Or, you may choose to build for local use only like this
```
stm32_ubuntu:latest",
stm32_alpine:latest",
```
3. `Ctrl + Shift + p` and enter `run task` and choose the build options: `Build Alpine` or `Build Ubuntu`.









# Use Image to Build STM32 Binary Locally

## Recommended Building Using Docker Entrypoint Exec Form:

- Format:
```bash
docker run IMAGE:VERSION {Git_Repo_URL}
```

- Example:
```bash
docker run --name builder jasonyangee/stm32_ubuntu:latest https://github.com/jasonyang-ee/STM32-CMAKE-TEMPLATE.git
```

- Optionally, you can copy out the binary files:
```bash
docker cp builder:/home/build/{TARGET_NAME}.elf
docker cp builder:/home/build/{TARGET_NAME}.bin
docker cp builder:/home/build/{TARGET_NAME}.hex
```


## Manual Building:

- Override ENTRYPOINT to keep interactive mode live:
```
docker run -it --entrypoint /bin/bash jasonyangee/stm32_ubuntu:latest
```

- `cd` to your desired work directory

- Copy your files either using `Docker cp` or `git clone`

- Initialize cmake:
```shell
cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_EXPORT_COMPILE_COMMANDS=ON -DCMAKE_TOOLCHAIN_FILE:PATH="cmake/gcc-arm-none-eabi.cmake" "-B build/" -G Ninja
```

- Compile:
```shell
cmake --build build/ -j 10
```



## Build STM32 Binary in Github Action

This is using Docker Hug to host images. Github action will pull Docker Hub images on every build.

The build is only to verify the compilation. Unit Test is not implemented yet.

In the application repo, create file `.github\workflows\build.yml` with the following:

```yml
name: 'Build Binary Ubuntu'
on:
  push:
    branches:
      - main
    tags:
      - 'v[0-9]+.[0-9]+.[0-9]+'

jobs:
  BUILD_RELEASE:
    runs-on: ubuntu-latest
    container:
      image: 'jasonyangee/stm32_ubuntu:latest'
    steps:
    - uses: actions/checkout@v3
    - name: BUILD
      run: build.sh
```

On pushing of the branch main, Github will automatically test build your application.

It is a good practice to include build result badge in application repo.

1. Nevigate to the action page, select the build workflow, and click create status badge:

![badge](/README_image/badge.png)

2. Copy the badge markdown string:

![badge](/README_image/badgeMD.png)

3. Paste it to the top of your application README.md file to show build result

![badge](/README_image/badgeResult.png)




## ST-Link

Tool Details: https://github.com/stlink-org/stlink

Using Windows machine is difficault to expose USB device to container. Using WSL maybe the only option for now. See next section.

Confirm Connnection:

```shell
st-info probe
```

Manual Flash:

```shell
st-flash write {TARGET.bin} 0x8000000 --reset
```

Manual Reset:
```shell
st-flash reset
```

### Prepare USB passthrough to WSL Docker container
Follow this:
https://learn.microsoft.com/en-us/windows/wsl/connect-usb

- Run cmd (admin mode) on Windows:

```cmd
winget install --interactive --exact dorssel.usbipd-win
wsl --update
wsl --shutdown
```

- Run (restart) WSL Ubuntu:

```shell
sudo apt install linux-tools-5.4.0-77-generic hwdata
sudo update-alternatives --install /usr/local/bin/usbip usbip /usr/lib/linux-tools/5.4.0-77-generic/usbip 20
```

Optionally
```shell
sudo apt update
sudo apt upgrade
sudo apt autoremove
```

- Run cmd (admin mode) on Windows:

```cmd
usbipd list
```

![](README_image/bind.png)

Note the ST-Link ID and bind it
```cmd
usbipd bind --busid 3-5
usbipd attach --busid 3-5
usbipd wsl list
```

![](README_image/attached.png)



### Run Docker container

- Run WSL Ubuntu:
```shell
docker run -it --privileged jasonyangee/stm32_alpine:latest
st-info --probe
```
Note: `--privileged` is necessary to allow device port passthrough

![stlinked](README_image/stlinked.png)