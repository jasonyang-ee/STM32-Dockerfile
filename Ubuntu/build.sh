#!/bin/bash
URL=$1

if [[ $# -gt 0 ]]
then
	cd /home
	git clone ${URL} .
	cmake -DCMAKE_BUILD_TYPE=Debug -DCMAKE_EXPORT_COMPILE_COMMANDS=ON -DCMAKE_TOOLCHAIN_FILE:PATH="/home/cmake/gcc-arm-none-eabi.cmake" "-B /home/build/Debug/" -G Ninja
	cmake --build /home/build/Debug/ -j 10
	echo '                                            ^'
	echo 'Build Completed                             |'
	echo 'Target Binaery in __________________________|'
else
	echo 'Please Supply git repo URL to Build'
	echo 'Example Command:'
	echo 'docker run jasonyangee/stm32_ubuntu {URL}'
fi