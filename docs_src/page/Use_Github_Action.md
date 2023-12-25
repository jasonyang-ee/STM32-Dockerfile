# Use Online With Github Action

## Mechanism

Using Github Action to load this docker image as base environment. Then run the `build.sh` script.

`build.sh` accpets the the same arguments: `-r` `-t` `-v`.

Default `HostPath` is `/github/workspace` and `ContainerPath` is `/home`.

Only `-t` is recommended to be used with Github Action.

## How To Use

In the source root, create file `.github\workflows\build.yml` with the following script.


- Short Example:
	```yml
	- uses: actions/checkout@v3
	- name: BUILD
	  run: build.sh -t MinSizeRel
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
		  run: build.sh -t MinSizeRel

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

