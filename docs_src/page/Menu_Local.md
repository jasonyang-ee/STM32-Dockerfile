# Use With Git Link

This is intended for testing compile only. It is recommended to [Use Hybrid](Menu_Hybrid.md) for getting binary files.

## Mechanism

Container will clone the supplied git repo into `/home` and compile it in `/home/build`.

This process exist in container only. No files will be copied out.

## Command

- Format:
	```bash
	docker run {IMAGE:VERSION} {Git_Repo_URL}
	docker run {IMAGE:VERSION} {Git_Repo_URL} {Build_Type}
	```

- Example:
	```bash
	docker run --name builder jasonyangee/stm32-builder:ubuntu-latest -r https://github.com/jasonyang-ee/STM32-CMAKE-TEMPLATE.git
	docker run --name builder jasonyangee/stm32-builder:ubuntu-latest -r https://github.com/jasonyang-ee/STM32-CMAKE-TEMPLATE.git -t Debug
	```

## Output

- (Optional) You can copy out the binary files:
	```bash
	docker cp builder:/home/build/{TARGET_NAME}.elf {DEST_PATH}
	docker cp builder:/home/build/{TARGET_NAME}.bin {DEST_PATH}
	docker cp builder:/home/build/{TARGET_NAME}.hex {DEST_PATH}
	```

