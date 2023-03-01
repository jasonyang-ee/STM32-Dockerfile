[![Build](https://github.com/jasonyang-ee/STM32-Dockerfile/actions/workflows/test.yml/badge.svg)](https://github.com/jasonyang-ee/STM32-Dockerfile/actions/workflows/build.yml)
[![Push](https://github.com/jasonyang-ee/STM32-Dockerfile/actions/workflows/Upload.yml/badge.svg)](https://github.com/jasonyang-ee/STM32-Dockerfile/actions/workflows/push.yml)


# Tags

- `1.0`: No Entrypoint. All build has to be done manually with docker run -it command.
- `2.0`: With Entrypoint. Git repo auto import and build implemented. And, Github Action Supported.
- `3.0`: ARM toolchain downloaded from Linux packages instead. Image size is bigger than v2.0. Not recommended.
- `3.1`: Reverting back to ARM toolchain direct downloaded from website.
- `3.2`: Add Github on premise server support. No TLS certification checking for https clone. 



# 1. Docker Container for STM32 CMake Compiling

## 1.1. Dockerfile

Dockerfile: https://github.com/jasonyang-ee/STM32-Dockerfile.git

Example Project: https://github.com/jasonyang-ee/STM32-CMAKE-TEMPLATE.git

## 1.2. Compiler

 - ARM GNU x86_64-arm-none-eabi  (939 MB)


## 1.3. Packages

- build-essential
- git
- cmake
- ninja-build
- stlink-tools





# 2. Use of This Image

This image is intended for building STM32 Microcontroller C/C++ Project Configured with CMake and Ninja.

The CMake has the following initialization variable enforced.

```
cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_EXPORT_COMPILE_COMMANDS=ON -DCMAKE_TOOLCHAIN_FILE:PATH="${sourceDir}/cmake/gcc-arm-none-eabi.cmake" "-B /home/build/" -G Ninja
```

## 2.1. Build Locally With Git Repo Link

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



## 2.2. Build Online With Github Action

In the application Github repo, create file `.github\workflows\build.yml` with the following.

This action script will build and upload binary outout to artifact for download.

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






# 3. Build Image from Dockerfile

If you choose to build this image from Dockerfile.


## 3.1. User Modifications

**Check ARM releases at here: <https://developer.arm.com/downloads/-/arm-gnu-toolchain-downloads/>**

- Modify `ARM_VERSION=12.2.rel1` for enforcing compiler version.

- If pulling latest version is desired, insert this line before `curl` command

```docker
&& ARM_VERSION=$(curl -s https://developer.arm.com/downloads/-/arm-gnu-toolchain-downloads | grep -Po '<h4>Version \K.+(?=</h4>)') \
```


## 3.2. Pre Configured VS Code Tasks has been setup to build automatically

- Modify the build arguments in `.vscode/tasks.json` if you wish to have different image name.
```
stm32_ubuntu:latest",
stm32_alpine:latest",
```
- `Ctrl + Shift + p` and enter `run task` and choose the build options: `Build Alpine` or `Build Ubuntu`.



## 3.3. Build Bash Command Example

```bash
docker build -t stm32_ubuntu:latest -f Dockerfile.ubuntu .
docker build -t stm32_alpine:latest -f Dockerfile.alpine .
```





# 4. Manual Image Usage

- Override ENTRYPOINT to keep interactive mode live:
```
docker run -it --entrypoint /bin/bash jasonyangee/stm32_ubuntu:latest
```

- `cd` to your desired work directory

- Copy your files either using `> Docker cp` or `$ git clone`

- Initialize CMake:
```bash
cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_EXPORT_COMPILE_COMMANDS=ON -DCMAKE_TOOLCHAIN_FILE:PATH="cmake/gcc-arm-none-eabi.cmake" "-B build/" -G Ninja
```

- Compile:
```bash
cmake --build build/ -j 10
```





On pushing of the branch main, Github will automatically test build your application.



# 5. ST-Link

ST Link Programmer has not yet been automated.

## 5.1. Flash Device in Manual Usage

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

## 5.2. Prepare USB Passthrough to WSL Docker Container
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

![](README_image/bind.png)

- Note the ST-Link ID and bind it
```cmd
usbipd bind --busid 3-5
usbipd attach --busid 3-5
usbipd wsl list
```

![](README_image/attached.png)



## 5.3. Run Docker Container in WSL

- Run WSL Ubuntu:
```shell
docker run -it --privileged jasonyangee/stm32_alpine:latest
st-info --probe
```
Note: `--privileged` is necessary to allow device port passthrough

![stlinked](README_image/stlinked.png)