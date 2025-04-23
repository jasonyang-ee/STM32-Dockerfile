# Use With Git Link

## Mechanism

Container will mount to local folder as working directory. Then it will clone the supplied git repo source file into `/app` and compile it in `/app/build`.

- `HostPath` is any empty folder path on local host machine. If no folder existed, one will be created.

## Command

- Format:
	```bash
	docker run -v "{HostEmptyPath}":"/app" {IMAGE:VERSION} -r {Git_Repo_URL}
	docker run -v "{HostEmptyPath}":"/app" {IMAGE:VERSION} -r {Git_Repo_URL} -t {Build_Type}
	```

- Example:
	```bash
	docker run -v "F:\EmptyPath":"/app" jasonyangee/stm32-builder:ubuntu-latest -r https://github.com/jasonyang-ee/STM32-CMAKE-TEMPLATE.git
	docker run -v "F:\EmptyPath":"/app" jasonyangee/stm32-builder:ubuntu-latest -r https://github.com/jasonyang-ee/STM32-CMAKE-TEMPLATE.git -t MinSizeRel
	```

## Output

Binary Output `.bin` `.elf` `.hex` `.map` are located in `HostPath/build`.
