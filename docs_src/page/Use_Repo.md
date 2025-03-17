# Use With Git Link

## Mechanism

Container will mount to local folder as working directory. Then it will clone the supplied git repo source file into `/home` and compile it in `/home/build`.

- `HostPath` is any empty folder path on local host machine. If no folder existed, one will be created.

- `ContainerPath` is the path inside of container. Default is `/home`.

## Command

- Format:
	```bash
	docker run -v "{HostPath}":"/home" {IMAGE:VERSION} -r {Git_Repo_URL}
	docker run -v "{HostPath}":"/home" {IMAGE:VERSION} -r {Git_Repo_URL} -t {Build_Type}
	docker run -v "{HostPath}":"{ContainerPath}" {IMAGE:VERSION} -r {Git_Repo_URL} -t {Build_Type} -v {ContainerPath}
	```

- Example:
	```bash
	docker run -v "F:\test_compile":"/home" jasonyangee/stm32-builder:ubuntu-latest -r https://github.com/jasonyang-ee/STM32-CMAKE-TEMPLATE.git
	docker run -v "F:\test_compile":"/home" jasonyangee/stm32-builder:ubuntu-latest -r https://github.com/jasonyang-ee/STM32-CMAKE-TEMPLATE.git -t MinSizeRel
	docker run -v "F:\test_compile":"/custom" jasonyangee/stm32-builder:ubuntu-latest -r https://github.com/jasonyang-ee/STM32-CMAKE-TEMPLATE.git -t Debug -v /custom
	```

## Output

Binary Output `.bin` `.elf` `.hex` `.map` are located in `HostPath/build`.
