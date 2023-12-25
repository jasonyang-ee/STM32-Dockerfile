# Use With Mount Volume

## Mechanism

Container will mount your existing project folder into `/home` and compile it in `/home/build`.

- `HostPath` is the existing project folder path on your local host machine. **This folder must contain your source code.**

- `ContainerPath` is the folder in docker container. Default is `/home`.


## Command

- Format:
	```bash
	docker run -v "{HostPath}":"/home" {IMAGE:VERSION} 
	docker run -v "{HostPath}":"/home" {IMAGE:VERSION} -t {Build_Type}
	docker run -v "{HostPath}":"/custom" {IMAGE:VERSION} -v /custom
	```

- Example:
	```bash
	docker run -v "F:\Project\STM32-CMAKE-TEMPLATE":"/home" jasonyangee/stm32-builder:ubuntu-latest
	docker run -v "F:\Project\STM32-CMAKE-TEMPLATE":"/home" jasonyangee/stm32-builder:ubuntu-latest -t Debug
	docker run -v "F:\Project\STM32-CMAKE-TEMPLATE":"/custom" jasonyangee/stm32-builder:ubuntu-latest -v /custom
	```


## Output

Binary Output `.bin` `.elf` `.hex` `.map` are located in `HostPath/build`.
