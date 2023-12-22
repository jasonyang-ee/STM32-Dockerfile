# Use With Mount Volume

## Mechanism

Container will mount your existing project folder into `/home` and compile it in `/home/build`.

- `Local_Project_Full_Path` is the existing project folder path on your local host machine. This folder must contain your source code.

- `/home` is the folder in docker container.

Repeating `/home` folder name as 1st argument is necessary to invoke the auto compile process.

## Command

- Format:
	```bash
	docker run -v "{Local_Project_Full_Path}":"/home" {IMAGE:VERSION} 
	docker run -v "{Local_Project_Full_Path}":"/home" {IMAGE:VERSION} -t {Build_Type}
	docker run -v "{Local_Project_Full_Path}":"/custom" {IMAGE:VERSION} -v /custom
	```

- Example:
	```bash
	docker run -v "F:\Project\STM32-CMAKE-TEMPLATE":"/home" jasonyangee/stm32-builder:ubuntu-latest
	docker run -v "F:\Project\STM32-CMAKE-TEMPLATE":"/home" jasonyangee/stm32-builder:ubuntu-latest -t Debug
	docker run -v "F:\Project\STM32-CMAKE-TEMPLATE":"/custom" jasonyangee/stm32-builder:ubuntu-latest -v /custom
	```


## Output

Binary Output `.bin` `.elf` `.hex` `.map` are located in `Local_Project_Full_Path/build`.
