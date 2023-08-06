# Use Online With Github Action

## Mechanism

Using Github Action to load this docker image as base environment. Then run the build script.

Docker image entrypoint 1st argument will define CMake build_type.

## How To Use

In the source root, create file `.github\workflows\build.yml` with the following script.


- Short Example:
	```yml
	- uses: actions/checkout@v3
	- name: BUILD
	  run: build.sh
	```
	```yml
	- uses: actions/checkout@v3
	- name: BUILD
	  run: build.sh Debug
	```

- Full Script:
	```yml
	name: 'Build with Ubuntu Container'
	on:
	push:
		branches:
		- 'main'

	jobs:
	  BUILD and RELEASE:
		runs-on: ubuntu-latest
		container:
		  image: 'jasonyangee/stm32-builder:ubuntu-latest'
		
		steps:
		- uses: actions/checkout@v3
		- name: BUILD
		  run: build.sh

		- name: Upload Binary .elf
		  uses: actions/upload-artifact@v2
		  with:
		    name: BINARY.elf
		    path: ${{ github.workspace }}/build/*.elf

		- name: Upload Binary .bin
		  uses: actions/upload-artifact@v2
		  with:
		    name: BINARY.bin
		    path: ${{ github.workspace }}/build/*.bin
	```

