# Docker Build for STM32 Toolchain


## Packages

- build-essential
- git
- cmake
- ninja-build
- stlink-tools


## Compiler

 - ARM GNU x86_64-arm-none-eabi



## User Modifications

Modify `TOOLS_PATH=/opt/gcc-arm-none-eabi` for changing compiler default folder.

Modify `ARM_VERSION=12.2.rel1` for enforcing compiler version.

Check ARM releases at here: https://developer.arm.com/downloads/-/arm-gnu-toolchain-downloads/

If pulling latest version is desired, insert this line before `curl` command

```docker
&& ARM_VERSION=$(curl -s https://developer.arm.com/downloads/-/arm-gnu-toolchain-downloads | grep -Po '<h4>Version \K.+(?=</h4>)') \
```


## Project Import

Cloud:
```shell
$ git clone {URL}
```

Local:
```CMD
> docker cp SOURCE/. containerID:/home/
```




## Building

### Recommended building method:

CMAKE using VS Code: https://github.com/jasonyang-ee/STM32-CMAKE-TEMPLATE.git


### Optional Manual Building:

Initialize cmake:
```shell
$ cmake -DCMAKE_BUILD_TYPE=Debug -DCMAKE_EXPORT_COMPILE_COMMANDS=ON -DCMAKE_TOOLCHAIN_FILE:PATH="cmake/gcc-arm-none-eabi.cmake" "-B build/Debug/" -G Ninja
```

Compile:
```shell
$ cmake --build build/Debug/ -j 10
```

Note:

building path `build/Debug/`



## ST-Link

Tool Details: https://github.com/stlink-org/stlink

Confirm Connnection:

```shell
$ st-info probe
```

Manual Flash:

```shell
$ st-flash write {TARGET.bin} 0x8000000 --reset
```

Manual Reset:
```shell
$ st-flash reset
```