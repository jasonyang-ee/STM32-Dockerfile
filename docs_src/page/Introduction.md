# Docker Container for STM32 CMake & Ninja Compiling

Visit [GitHub](https://github.com/jasonyang-ee/STM32-Dockerfile) for source code.

## -+- TL;DR -+-

This docker image auto clone an online git repo and compile the CMake & Ninja supported STM32 project locally on your computer with mounted volume.
```bash
docker run -v "{Local_Full_Path}":"/home" jasonyangee/stm32-builder:ubuntu-latest -r {Git_Repo_URL}
```

![](img/run_time.gif)


## Example Project

For CMake setup, refer to the below STM32 project template.

<https://github.com/jasonyang-ee/STM32-CMAKE-TEMPLATE.git>


## Public Registry:

> ghcr.io/jasonyang-ee/stm32-builder:ubuntu-latest

> ghcr.io/jasonyang-ee/stm32-builder:debian-latest

> ghcr.io/jasonyang-ee/stm32-builder:alpine-latest

> ghcr.io/jasonyang-ee/stm32-builder:arch-latest

> jasonyangee/stm32-builder:ubuntu-latest

> jasonyangee/stm32-builder:debian-latest

> jasonyangee/stm32-builder:alpine-latest

> jasonyangee/stm32-builder:arch-latest


## Docker Image Compiler Environment

- [ARM GNU x86_64-arm-none-eabi](https://packages.ubuntu.com/jammy/gcc-arm-none-eabi)
- Ubuntu: [build-essential](https://packages.ubuntu.com/focal/build-essential)
- Alpine: [gcompat](https://pkgs.alpinelinux.org/package/edge/community/x86_64/gcompat) & [libc6-compat](https://pkgs.alpinelinux.org/package/edge/main/x86_64/libc6-compat) & [libstdc++](https://pkgs.alpinelinux.org/package/edge/main/x86_64/libstdc++) & [g++](https://pkgs.alpinelinux.org/package/edge/main/x86_64/g++) & [gcc](https://pkgs.alpinelinux.org/package/edge/main/x86_64/gcc)
- [git](https://git-scm.com/)
- [cmake](https://cmake.org/)
- [ninja-build](https://ninja-build.org/)
- [stlink-tools](https://github.com/stlink-org/stlink)


## Basics of This Image

This image is intended for building STM32 Microcontroller C/C++ Project Configured with CMake and Ninja.

The entrypoint bash script executes basically two commands in default:
```bash
cmake -DCMAKE_BUILD_TYPE=Release -S /home -B /home/build/ -G Ninja
cmake --build /home/build -j$(nproc)
```

- `CMAKE_TOOLCHAIN_FILE` must be defined in your project CMakeList.txt file.
- Default build type is `Release`.

