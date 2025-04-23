# Manual Image Usage

- Docker using volume mount and override ENTRYPOINT to keep interactive mode live
	```
	docker run -v "F:\Project\STM32-CMAKE-TEMPLATE":"/app" -it --entrypoint /bin/bash jasonyangee/stm32-builder:ubuntu-latest
	```

- Run build script to invoke auto compiling process.
	```bash
	build.sh
	```

- `build.sh` accpets the the same arguments: `-r` `-t`.
	```bash
	build.sh -t MinSizeRel
	```