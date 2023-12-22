# Use Hybrid With Mount Volume + Git Link

## Mechanism

Container will mount to local folder. Then it will clone the supplied git repo source file into `/home` and compile it in `/home/build`.

- `Local_Project_Full_Path` is any empty folder path on local host machine. If no folder existed, one will be created.


## Command

- Format:
	```bash
	docker run -v "{Local_Project_Full_Path}":"/home" {IMAGE:VERSION} -r {Git_Repo_URL}
	docker run -v "{Local_Project_Full_Path}":"/home" {IMAGE:VERSION} -r {Git_Repo_URL} -t {Build_Type}
	```

- Example:
	```bash
	docker run -v "F:\test_compile":"/home" jasonyangee/stm32-builder:ubuntu-latest -r https://github.com/jasonyang-ee/STM32-CMAKE-TEMPLATE.git
	docker run -v "F:\test_compile":"/home" jasonyangee/stm32-builder:ubuntu-latest -r https://github.com/jasonyang-ee/STM32-CMAKE-TEMPLATE.git -t Debug
	docker run -v "F:\test_compile":"/custom" jasonyangee/stm32-builder:ubuntu-latest -r https://github.com/jasonyang-ee/STM32-CMAKE-TEMPLATE.git -t Debug -v /custom
	```

## Output

Binary Output `.bin` `.elf` `.hex` `.map` are located in `Local_Project_Full_Path/build`.
