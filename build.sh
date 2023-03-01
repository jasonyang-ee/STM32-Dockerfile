#!/bin/bash

if [[ $# -eq 1 ]]
then
	if [[ $1 == "http"* ]]
	then
		cd /home
		git clone $1 .
		git config --global http.sslverify false
		cmake -DCMAKE_BUILD_TYPE=Release "-B /home/build/" -G Ninja
		cmake --build /home/build/ -j 10
		if [[ $? -eq 0 ]]
		then
			echo '                                            ^'
			echo 'Build Completed                             |'
			echo 'Target Binaery in __________________________|'
		else
			exit $?
		fi
	else
		echo 'No Project Repo URL Found. Please Supply Project Files to Build'
		echo 'Example Command:'
		echo 'docker run jasonyangee/stm32_ubuntu {Github URL}'
	fi
else
	if [[ $GITHUB_ACTIONS == true ]]
	then
		cmake -DCMAKE_BUILD_TYPE=Release "-B $GITHUB_WORKSPACE/build" -G Ninja
		cmake --build $GITHUB_WORKSPACE/build -j 10
		if [[ $? -eq 0 ]]
		then
			echo '                                            ^'
			echo 'Build Completed                             |'
			echo 'Target Binaery in __________________________|'
		else
			exit $?
		fi
	fi
fi
