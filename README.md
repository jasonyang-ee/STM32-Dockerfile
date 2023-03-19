[![Build](https://github.com/jasonyang-ee/STM32-Dockerfile/actions/workflows/build.yml/badge.svg)](https://github.com/jasonyang-ee/STM32-Dockerfile/actions/workflows/build.yml)
[![Push](https://github.com/jasonyang-ee/STM32-Dockerfile/actions/workflows/push.yml/badge.svg)](https://github.com/jasonyang-ee/STM32-Dockerfile/actions/workflows/push.yml)


# 1. Tags

- `1.0`: No Entrypoint. All build has to be done manually with docker run -it command.
- `2.0`: With Entrypoint. Git repo auto import and build implemented. And, Github Action Supported.
- `3.0`: ARM toolchain downloaded from Linux packages instead. Image size is bigger than v2.0.
- `3.1`: Reverting back to ARM toolchain direct downloaded from website.
- `3.2`: Add Github on premise server support. No TLS certification checking for https clone. 
- `3.3`: Removed args -DCMAKE_EXPORT_COMPILE_COMMANDS=ON -DCMAKE_TOOLCHAIN_FILE:PATH=""
- `4.0`: Add Local Mounted Volume Support. Add Help Menu.
- `4.1`: Modify Action Test. Bug Fixs.
- `4.2`: Modify Action Test. Bug Fixs.
- `4.3`: Modify Action Test. Bug Fixs.
- `4.4`: Bug fix of volume mount path as arguments. Now has correct support on mounted project.
- `5.0`: Supports hybrid git repo URL + local mounted compile. This provides completed compile experience.




# 2. Docker Container for STM32 CMake & Ninja Compiling

-+- TL;DR -+-

This docker image auto clone an online git repo and compile the CMake & Ninja supported STM32 project locally on your computer with mounted volume.
```bash
docker run -v "{Local_Full_Path}":"/home" jasonyangee/stm32_ubuntu:latest {Git_Repo_URL}
```

![Run](Doc/img/run_time.gif)

## 2.1. Dockerfile

Dockerfile: https://github.com/jasonyang-ee/STM32-Dockerfile.git

Example Project: https://github.com/jasonyang-ee/STM32-CMAKE-TEMPLATE.git

Public Registry:
> ghcr.io/jasonyang-ee/stm32_alpine:latest

> ghcr.io/jasonyang-ee/stm32_ubuntu:latest

> jasonyangee/stm32_alpine:latest

> jasonyangee/stm32_ubuntu:latest



## 2.2. Docker Image Compiler Environment

- [ARM GNU x86_64-arm-none-eabi](https://packages.ubuntu.com/jammy/gcc-arm-none-eabi)
- Ubuntu: [build-essential](https://packages.ubuntu.com/focal/build-essential)
- Alpine: [gcompat](https://pkgs.alpinelinux.org/package/edge/community/x86_64/gcompat) & [libc6-compat](https://pkgs.alpinelinux.org/package/edge/main/x86_64/libc6-compat) & [libstdc++](https://pkgs.alpinelinux.org/package/edge/main/x86_64/libstdc++) & [g++](https://pkgs.alpinelinux.org/package/edge/main/x86_64/g++) & [gcc](https://pkgs.alpinelinux.org/package/edge/main/x86_64/gcc)
- [git](https://git-scm.com/)
- [cmake](https://cmake.org/)
- [ninja-build](https://ninja-build.org/)
- [stlink-tools](https://github.com/stlink-org/stlink)




# 3. Basics of This Image

This image is intended for building STM32 Microcontroller C/C++ Project Configured with CMake and Ninja.

The entrypoint bash script executes basically two commands:
```bash
cmake -DCMAKE_BUILD_TYPE=$TYPE -B /home/build/" -G Ninja
cmake --build /home/build -j 10
```

- `CMAKE_TOOLCHAIN_FILE` must be defined in your project CMakeList.txt file.
- Default build type is `Release`.



## 3.1. Help Menu
Example usage format can be viewed with `--help` command.
```bash
docker run jasonyangee/stm32_ubuntu:latest --help
```

# 4. Use of This Image



## 4.1. Use Locally With Git Repo Link

This is intended for testing compile only. It is recommended to `Use Locally Hybrid` for getting binary files.

- Format:
```bash
docker run {IMAGE:VERSION} {Git_Repo_URL}
docker run {IMAGE:VERSION} {Git_Repo_URL} {Build_Type}
```

- Example:
```bash
docker run --name builder jasonyangee/stm32_ubuntu:latest https://github.com/jasonyang-ee/STM32-CMAKE-TEMPLATE.git
docker run --name builder jasonyangee/stm32_ubuntu:latest https://github.com/jasonyang-ee/STM32-CMAKE-TEMPLATE.git Debug
```

- Optionally, you can copy out the binary files:
```bash
docker cp builder:/home/build/{TARGET_NAME}.elf {DEST_PATH}
docker cp builder:/home/build/{TARGET_NAME}.bin {DEST_PATH}
docker cp builder:/home/build/{TARGET_NAME}.hex {DEST_PATH}
```




## 4.2. Use Locally With Mounted Volume

`Local_Project_Full_Path` is the existing project folder path on your local host machine.

`/proj` is the folder in docker container. It can be any none-Linux-system-folder name in root. Repeating this folder name as 1st argument for entrypoint will invoke the auto compile process. Using `/home` is recommended to avoid confusions between the three different use case.

Binary Output `.bin` `.elf` `.hex` `.map` are located in `Local_Project_Path/build`.

- Format:
```bash
docker run -v "{Local_Project_Full_Path}":"/proj" {IMAGE:VERSION} /proj
docker run -v "{Local_Project_Full_Path}":"/proj" {IMAGE:VERSION} /proj {Build_Type}
```

- Example:
```bash
docker run -v "F:\Project\STM32-CMAKE-TEMPLATE":"/proj" jasonyangee/stm32_ubuntu:latest /proj
docker run -v "F:\Project\STM32-CMAKE-TEMPLATE":"/proj" jasonyangee/stm32_ubuntu:latest /proj Debug
```



## 4.3. Use Locally Hybrid

Due to hybrid usage and simplicity of required arguments, the container compile folder must be defined as `/home` to work.

`Local_Project_Full_Path` is any empty folder path on local host machine. If no folder existed, one will be created.

- Format:
```bash
docker run -v "{Local_Full_Path}":"/home" {IMAGE:VERSION} {Git_Repo_URL}
docker run -v "{Local_Full_Path}":"/home" {IMAGE:VERSION} {Git_Repo_URL} {Build_Type}
```

- Example:
```bash
docker run -v "F:\test_compile":"/home" jasonyangee/stm32_ubuntu:latest https://github.com/jasonyang-ee/STM32-CMAKE-TEMPLATE.git
docker run -v "F:\test_compile":"/home" jasonyangee/stm32_ubuntu:latest https://github.com/jasonyang-ee/STM32-CMAKE-TEMPLATE.git Debug
```





## 4.4. Use Online With Github Action

In the application Github repo, create file `.github\workflows\build.yml` with the following script.

This action script will build and upload binary outout to artifact.

In the Github Action use case, docker image entrypoint 1st argument will overwrite build_type.

- Short Example:
```yml
- uses: actions/checkout@v3
- name: BUILD
  run: build.sh
```
```yml
- uses: actions/checkout@v3
- name: BUILD
  run: build.sh Debug
```

- Full Script:

```yml
name: 'Build with Ubuntu Container'
on:
  push:
    branches:
      - main

jobs:
  BUILD_RELEASE:
    runs-on: ubuntu-latest
    container:
      image: 'jasonyangee/stm32_ubuntu:latest'
    steps:
    - uses: actions/checkout@v3
    - name: BUILD
      run: build.sh

    - name: Upload Binary .elf
      uses: actions/upload-artifact@v2
      with:
        name: BINARY.elf
        path: ${{ github.workspace }}/build/*.elf

    - name: Upload Binary .bin
      uses: actions/upload-artifact@v2
      with:
        name: BINARY.bin
        path: ${{ github.workspace }}/build/*.bin
```






# 5. Build Image from Dockerfile

If you choose to build your own image from Dockerfile.


## 5.1. User Modifications

**Check ARM releases at here: <https://developer.arm.com/downloads/-/arm-gnu-toolchain-downloads/>**

- Modify `ARM_VERSION=12.2.rel1` for enforcing compiler version.

- If pulling latest version is desired, insert this line before `curl` command in dockerfile.

```docker
&& ARM_VERSION=$(curl -s https://developer.arm.com/downloads/-/arm-gnu-toolchain-downloads | grep -Po '<h4>Version \K.+(?=</h4>)') \
```


## 5.2. Auto Build Using VS Code Tasks

- `Ctrl + Shift + p` and enter `run task` and choose the build options: `Build Ubuntu`.
- Modify the build arguments in `.vscode/tasks.json` if you wish to have different image name.
```
stm32_ubuntu:latest",
```



## 5.3. Manual Build Bash Command Example

```bash
docker build -t stm32_ubuntu:latest -f Dockerfile.ubuntu .
```





# 6. Manual Image Usage

- Override ENTRYPOINT to keep interactive mode live.
- Import project folder with volume mount.
```
docker run -v "F:\Project\STM32-CMAKE-TEMPLATE":"/build" -it --entrypoint /bin/bash jasonyangee/stm32_ubuntu:latest
```

- Run `build.sh` to invoke auto compiling process.

- Initialize CMake:
```bash
cmake -DCMAKE_BUILD_TYPE=Release "-B build/" -G Ninja
```

- Compile:
```bash
cmake --build build/ -j 10
```





On pushing of the branch main, Github will automatically test build your application.



# 7. ST-Link

ST Link Programmer has not yet been automated.

## 7.1. Flash Device in Manual Usage

Tool Details: https://github.com/stlink-org/stlink

Using Windows machine is difficault to expose USB device to container.

Using WSL maybe the only option for now. See next section.

- Confirm Connnection:

```shell
st-info probe
```

- Manual Flash:

```shell
st-flash write {TARGET.bin} 0x8000000 --reset
```

- Manual Reset:
```shell
st-flash reset
```

## 7.2. Prepare USB Passthrough to WSL Docker Container
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


- Run cmd (admin mode) on Windows:

```cmd
usbipd list
```

![](Doc/img/bind.png)

- Note the ST-Link ID and bind it
```cmd
usbipd bind --busid 3-5
usbipd attach --busid 3-5
usbipd wsl list
```

![](Doc/img/attached.png)



## 7.3. Run Docker Container in WSL

- Run WSL Ubuntu:
```shell
docker run -it --privileged --entrypoint /bin/bash jasonyangee/stm32_ubuntu:latest
st-info --probe
```
Note: `--privileged` is necessary to allow device port passthrough

![stlinked](Doc/img/stlinked.png)



# 8. Github Action Variables

For those who want to setup your own github action to auto publish variation of this dockerfile to your own docker registry. You may copy my action yml file setup and setup the following github variables.

```c
vars.REGISTRY					// Github package link (private: ghcr.io  -  org: ghcr.io/Org_Name)
secrete.DOCKERHUB_TOKEN			// Docker Hub login token
secrete.DOCKERHUB_USERNAME		// Docker Hub username
secrete.TOKEN_GITHUB_PERSONAL	// Github package token
secrete.USER_GITHUB_PERSONAL	// Github package username
```