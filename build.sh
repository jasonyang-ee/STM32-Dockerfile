#!/bin/bash

# Check for argument existance
if [[ $# -ge 1 ]]
then
	# If supplying build type, else default to release
	if [[ $# -eq 2 ]]
	then
		TYPE=$2
	else
		TYPE=Release
	fi
	# Starting to parse 1st argument
	if [[ $1 == "http"* ]] # Git repo case
	then
		cd /home
		git clone $1 .
		git config --global http.sslverify false # Accept internal github server with self https certs
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
	elif [[ -d $1 ]] # Volume mounted case
	then
		cmake -DCMAKE_BUILD_TYPE=$TYPE "-S $1" "-B $1/build/" -G Ninja
		cmake --build $1/build -j 10
		if [[ $? -eq 0 ]]
		then
			echo '                                            ^'
			echo 'Build Completed                             |'
			echo 'Target Binaery in __________________________|'
		else
			exit $?
		fi
	elif [[ $1 == "--help" ]] # Help menu
	then
		echo ''
		echo '[1] Local Volume Mount Usage Format:'
		echo '    $ docker run -v "Local_Project_Full_Path":"/build" jasonyangee/stm32_ubuntu:latest' /build
		echo ''
		echo '[2] Remote Repo Usage Format:'
		echo '    $ docker run jasonyangee/stm32_ubuntu:latest {Github_URL}'
		echo ''
		echo '[3] Github Action Usage Format:'
		echo '    container:'
      	echo '      image: jasonyangee/stm32_ubuntu:latest'
    	echo '    steps:'
		echo '    - uses: actions/checkout@v3'
		echo '    - run: build.sh'
		echo ''
		echo '[4] Optonally, 2nd argument supports overwriting default Release build type'
		echo '    $ docker run jasonyangee/stm32_ubuntu:latest {Github_URL} Debug'
		echo '    $ docker run -v "Local_Project_Full_Path":"/build" jasonyangee/stm32_ubuntu:latest' /build Debug
		exit 0
	else # 1st argument not supported
		echo ''
		echo 'Format error. No project found in 1st argument. Use --help to Get More Info.'
		echo '$ docker run jasonyangee/stm32_ubuntu:latest --help'
		exit 0
	fi
# If using in Github Action
elif [[ $GITHUB_ACTIONS == true ]]
then
	# In github action case, 1st argument is used as build type
	if [[ $# -eq 1 ]]
	then
		TYPE=$2
	else
		TYPE=Release
	fi
	# Starting of compile
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
# If no argument supplied
else
	echo ''
	echo 'Format error. Missing arguments. Use --help to Get More Info.'
	echo '$ docker run jasonyangee/stm32_ubuntu:latest --help'
fi
