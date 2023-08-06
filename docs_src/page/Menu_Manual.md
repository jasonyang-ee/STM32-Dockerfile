# Manual Image Usage

- Docker using volume mount and override ENTRYPOINT to keep interactive mode live
	```
	docker run -v "F:\Project\STM32-CMAKE-TEMPLATE":"/home" -it --entrypoint /bin/bash jasonyangee/stm32-builder:ubuntu-latest
	```

- Run build script to invoke auto compiling process.
	```bash
	build.sh /home
	```

- Or optionally, manualy use CMake commands to compile:
	```bash
	cmake -B /home/build -G Ninja
	cmake --build /home/build
	```