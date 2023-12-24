#!/bin/bash

# Default values
TYPE=Release
VOLUME=/home

# Parse arguments
POSITIONAL_ARGS=()
while [[ $# -gt 0 ]]; do
	case $1 in
	-h | --help)
		HELP=true
		shift # past argument
		;;
	-t | --type)
		# Check if has argument value
		if [[ -z "$2" ]] || [[ "$2" =~ ^-+ ]]; then
			shift # past argument
		else
			TYPE="$2"
			shift # past argument
			shift # past value
		fi
		echo "Using $TYPE build type"
		;;
	-v | --volume)
		# Check if has argument value
		if [[ -z "$2" ]] || [[ "$2" =~ ^-+ ]]; then
			shift # past argument
		else
			VOLUME="$2"
			shift # past argument
			shift # past value
		fi
		echo "Using $VOLUME as volume mount point"
		;;
	-r | --repo)
		# Check if has argument value
		if [[ -z "$2" ]] || [[ "$2" =~ ^-+ ]]; then
			echo "stm32-builder: '$1' missing repository url argument" >&2
			echo "See '--help' for more information"
			exit 1
		else
			REPO="$2"
			shift # past argument
			shift # past value
		fi
		;;
	-* | --*=) # unsupported argument
		echo "stm32-builder: Unsupported argument '$1'" >&2
		echo "See '--help' for more information"
		exit 1
		;;
	esac
done

# Check for help flag
if [[ $HELP == true ]]; then
	echo "Usage: build.sh [OPTIONS]"
	echo "Options:"
	echo "  -h, --help                            Print this help message"
	echo "  -t, --type <build type>               Set CMake build type"
	echo "                                        Default: Release"
	echo "  -v, --volume <volume mount path>      Path to mount project inside of container and cmake will build in this path"
	echo "                                        Default: /home"
	echo "  -r, --repo <repository url>           Clone repository from url into volume path and build"
	echo ""
	echo "Example:"
	echo "  docker run {IMAGE:VERSION} -v /project:/home"
	echo "  docker run {IMAGE:VERSION} -r https://github.com/jasonyang-ee/STM32-CMAKE-TEMPLATE.git"
	echo "  docker run {IMAGE:VERSION} -v /project:/home -r https://github.com/jasonyang-ee/STM32-CMAKE-TEMPLATE.git -t Debug"
	echo ""
	echo "Github Action Example:"
	echo "  - uses: actions/checkout@v3"
	echo "  - name: Build"
	echo "    run: build.sh -t Debug"
	echo "  - name: Upload Binary Artifact"
	echo "    uses: actions/upload-artifact@v2"
	echo "    with:"
	echo "      name: binary.elf"
	echo "      path: \${{ github.workspace }}/build/*.elf"
	exit 0
fi

# Check if running in Github Action
if [[ $GITHUB_ACTIONS == true ]]; then
	VOLUME=$GITHUB_WORKSPACE
else
	mkdir -p $VOLUME
fi

# Check for repo
if [[ ! -z $REPO ]]; then
	git clone $REPO $VOLUME
	git config --global http.sslverify false # Accept internal github server with self https certs
fi

# Check if project exists in volume
if [[ -z "$(ls -A $VOLUME)" ]]; then
	echo "Volume $VOLUME is empty"
	echo "Please mount project to volume or supply repository url to clone into"
	exit 1
fi

# Start building project
CORES=$(nproc)
cmake -DCMAKE_BUILD_TYPE=$TYPE -S $VOLUME -B $VOLUME/build/ -G Ninja
cmake --build $VOLUME/build/ -j$CORES
if [[ $? -eq 0 ]]; then
	echo '                                            ^'
	echo 'Build Completed                             |'
	echo 'Target Binaery in __________________________|'
else
	exit $?
fi
