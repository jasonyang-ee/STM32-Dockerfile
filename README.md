[![Test](https://github.com/jasonyang-ee/STM32-Dockerfile/actions/workflows/test.yml/badge.svg)](https://github.com/jasonyang-ee/STM32-Dockerfile/actions/workflows/test.yml)
[![Upload](https://github.com/jasonyang-ee/STM32-Dockerfile/actions/workflows/upload.yml/badge.svg)](https://github.com/jasonyang-ee/STM32-Dockerfile/actions/workflows/upload.yml)
[![Deploy Documentation](https://github.com/jasonyang-ee/STM32-Dockerfile/actions/workflows/mdbook.yml/badge.svg)](https://github.com/jasonyang-ee/STM32-Dockerfile/actions/workflows/mdbook.yml)

# Docker Container for STM32 CMake & Ninja Compiling

## Documentation

### Visit [Documentation](http://doc.jasony.org/STM32-Dockerfile) for more information.



## Tags
Postfix with base OS.
- `v8.0.0`: Using new ARM GCC 13.3.rel1.
- `v8.1.0`: Using new ARM GCC 14.2.rel1.
- `v8.2.0`: Reduced image size by removing static analysis tools. Renamed container volume path. Removed `-v` option in build script.
- `latest`: Equal to `v8.2.0`

> Example: ghcr.io/jasonyang-ee/stm32-builder:debian-v8.2.0

> Example: ghcr.io/jasonyang-ee/stm32-builder:debian-latest




## -+- TL;DR -+-

This docker image auto clone an online git repo and compile the CMake & Ninja supported STM32 project locally on your computer with mounted volume.
```bash
docker run -v "{HostEmptyPath}":"/app" jasonyangee/stm32-builder:ubuntu-latest -r {Git_Repo_URL}
```

![Run](docs_src/page/img/run_time.gif)


## Example Project

For CMake setup, refer to the below STM32 project template.

https://github.com/jasonyang-ee/STM32-CMAKE-TEMPLATE.git


## Help Menu

```
docker run jasonyangee/stm32-builder:ubuntu-latest --help                              
```
>```bash
>Usage: build.sh [OPTIONS]
>Options:
>  -h, --help                            Print this help message
>  -t, --type <build type>               Change CMake build type -- Default: Release
>  -r, --repo <repository url>           Clone repository from url and build [Optional]
>```


## Commands:

```
docker run -v {HostPath}:/app {IMAGE:VERSION} -r {Git_Repo_URL} -t {Build_Type}
```


## Public Registry:

> ghcr.io/jasonyang-ee/stm32-builder:ubuntu-latest

> ghcr.io/jasonyang-ee/stm32-builder:debian-latest

> ghcr.io/jasonyang-ee/stm32-builder:alpine-latest

> ghcr.io/jasonyang-ee/stm32-builder:arch-latest

> jasonyangee/stm32-builder:ubuntu-latest

> jasonyangee/stm32-builder:debian-latest

> jasonyangee/stm32-builder:alpine-latest

> jasonyangee/stm32-builder:arch-latest
