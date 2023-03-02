#!/bin/bash

# If Supplying Build Type
if [[ $# -eq 2 ]]
then
	TYPE=$2
else
	TYPE=Release
fi


# If Supplying URL
if [[ $# -eq 1 ]]
then
	if [[ $1 == "http"* ]]
	then
		echo 'debug 1'
		cd /home
		git clone $1 .
		git config --global http.sslverify false
		cmake -DCMAKE_BUILD_TYPE=$TYPE "-B /home/build/" -G Ninja
		cmake --build /home/build/ -j 10
		if [[ $? -eq 0 ]]
		then
			echo '                                            ^'
			echo 'Build Completed                             |'
			echo 'Target Binaery in __________________________|'
		else
			exit $?
		fi
	elif [[ $1 == "--help" ]]
	then
		echo ''
		echo 'Local Container Use Format:'
		echo 'URL:      $ docker run jasonyangee/stm32_ubuntu:latest {Github Repo URL}'
		echo 'Mount:    $ docker run -v "Local/Host/Project/Path":"/build" jasonyangee/stm32_ubuntu:latest'
		echo ''
		echo 'Remote Repo Use Format:'
		echo 'docker run jasonyangee/stm32_ubuntu:latest {Github_URL}'
		echo ''
		echo 'Github Action Use Format:'
		echo '- uses: actions/checkout@v3'
		echo '- run: build.sh'
		echo ''
		echo 'Add Debug / Release build-type at the end to overwrit default "Release" type'
		echo 'Example:  $ docker run jasonyangee/stm32_ubuntu:latest {Github_URL} Debug'
	else
		echo ''
		echo 'Format Error. No Project Repo URL Found in 1st Argument'
		echo 'Example:  $ docker run jasonyangee/stm32_ubuntu:latest {Github_URL}'
	fi
# If using in Github Action
elif [[ $GITHUB_ACTIONS == true ]]
then
	echo 'debug 3'
	cmake -DCMAKE_BUILD_TYPE=$TYPE "-B $GITHUB_WORKSPACE/build" -G Ninja
	cmake --build $GITHUB_WORKSPACE/build -j 10
	if [[ $? -eq 0 ]]
	then
		echo '                                            ^'
		echo 'Build Completed                             |'
		echo 'Target Binaery in __________________________|'
	else
		exit $?
	fi
# If Supplying Mounted Volume
elif [ -d "/build" ] && [ -n "$(ls -A "/build")" ]
then
	cd /build
	cmake -DCMAKE_BUILD_TYPE=$TYPE "-B /build/build/" -G Ninja
	cmake --build $1/build/ -j 10
else
	echo 'Format Error. Type --help to Get More Info > docker run jasonyangee/stm32_ubuntu:latest --help'
fi
