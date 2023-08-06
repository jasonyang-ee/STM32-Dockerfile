# Use Hybrid With Mount Volume + Git Link

## Mechanism

Container will mount to local folder. Then it will clone the supplied git repo source file into `/home` and compile it in `/home/build`.

- `Local_Project_Full_Path` is any empty folder path on local host machine. If no folder existed, one will be created.


## Command

- Format:
	```bash
	docker run -v "{Local_Project_Full_Path}":"/home" {IMAGE:VERSION} {Git_Repo_URL}
	docker run -v "{Local_Project_Full_Path}":"/home" {IMAGE:VERSION} {Git_Repo_URL} {Build_Type}
	```

- Example:
	```bash
	docker run -v "F:\test_compile":"/home" jasonyangee/stm32-builder:ubuntu-latest https://github.com/jasonyang-ee/STM32-CMAKE-TEMPLATE.git
	docker run -v "F:\test_compile":"/home" jasonyangee/stm32-builder:ubuntu-latest https://github.com/jasonyang-ee/STM32-CMAKE-TEMPLATE.git Debug
	```

## Output

Binary Output `.bin` `.elf` `.hex` `.map` are located in `Local_Project_Full_Path/build`.
