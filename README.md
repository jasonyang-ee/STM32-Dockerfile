[![Test](https://github.com/jasonyang-ee/STM32-Dockerfile/actions/workflows/build.yml/badge.svg)](https://github.com/jasonyang-ee/STM32-Dockerfile/actions/workflows/build.yml)
[![Upload](https://github.com/jasonyang-ee/STM32-Dockerfile/actions/workflows/push.yml/badge.svg)](https://github.com/jasonyang-ee/STM32-Dockerfile/actions/workflows/push.yml)

# Docker Container for STM32 CMake & Ninja Compiling

## Documentation

Visit [Documentation](http://doc.jasony.org/STM32-Dockerfile) for more information.

## Tags

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
- `5.1`: Add Archlinux image and unified tags under stm32-builder. *OLD IMAGES ARE REMOVED*
- `5.2`: Add static analysis tool: clang-format clang-tidy, Lizard, cpplint. Use in dev container only.
- `5.3`: Add multiplatform support.
- `5.8`: Name change to stm32-builder: ubuntu-latest :alpine-latest :arch-latest. Some Bug fix.
- `6.0`: True multiplatform support on Ubuntu and Debian. Alpine and Archlinux for amd64 only.
- `Latest`: `6.0`


Recommandation: Use `5.1` for light weight and `6.0` when running on ARM64 platform.



## -+- TL;DR -+-

This docker image auto clone an online git repo and compile the CMake & Ninja supported STM32 project locally on your computer with mounted volume.
```bash
docker run -v "{Local_Full_Path}":"/home" jasonyangee/stm32-builder:ubuntu-latest {Git_Repo_URL}
```

> ![Run](docs_src/page/img/run_time.gif)


## Example Project

For CMake setup, refer to the below STM32 project template.

https://github.com/jasonyang-ee/STM32-CMAKE-TEMPLATE.git


## Public Registry:

> ghcr.io/jasonyang-ee/stm32-builder:ubuntu-latest

> ghcr.io/jasonyang-ee/stm32-builder:debian-latest

> ghcr.io/jasonyang-ee/stm32-builder:alpine-latest

> ghcr.io/jasonyang-ee/stm32-builder:arch-latest

> jasonyangee/stm32-builder:ubuntu-latest
> 
> jasonyangee/stm32-builder:debian-latest

> jasonyangee/stm32-builder:alpine-latest

> jasonyangee/stm32-builder:arch-latest
