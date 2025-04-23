# Use With Mount Volume

## Mechanism

Container will mount your existing project folder into `/app` and compile it in `/app/build`.

- `HostPath` is the existing project folder path on your local host machine. **This folder must contain your source code.**


## Command

- Format:
	```bash
	docker run -v "{HostPath}":"/app" {IMAGE:VERSION} 
	docker run -v "{HostPath}":"/app" {IMAGE:VERSION} -t {Build_Type}
	```

- Example:
	```bash
	docker run -v "F:\Project\STM32-CMAKE-TEMPLATE":"/app" jasonyangee/stm32-builder:ubuntu-latest
	docker run -v "F:\Project\STM32-CMAKE-TEMPLATE":"/app" jasonyangee/stm32-builder:ubuntu-latest -t Debug
	```


## Output

Binary Output `.bin` `.elf` `.hex` `.map` are located in `HostPath/build`.
