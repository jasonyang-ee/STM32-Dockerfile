FROM ubuntu:22.04

ARG TOOLS_PATH=/opt/gcc-arm-none-eabi

# Prep basic packages
RUN apt update && apt-get clean && apt-get install -y \
	xz-utils \
	curl \
	build-essential \
	git \
	cmake \
	ninja-build \
	stlink-tools
				
# Get ARM Toolchain
RUN mkdir ${TOOLS_PATH} \
	&& ARM_TOOLCHAIN_VERSION=$(curl -s https://developer.arm.com/downloads/-/arm-gnu-toolchain-downloads | grep -Po '<h4>Version \K.+(?=</h4>)') \
	&& curl -Lo gcc-arm-none-eabi.tar.xz "https://developer.arm.com/-/media/Files/downloads/gnu/${ARM_TOOLCHAIN_VERSION}/binrel/arm-gnu-toolchain-${ARM_TOOLCHAIN_VERSION}-x86_64-arm-none-eabi.tar.xz" \
	&& tar xf gcc-arm-none-eabi.tar.xz --strip-components=1 -C ${TOOLS_PATH}

# Clean Up
RUN rm gcc-arm-none-eabi.tar.xz \
	&& rm ${TOOLS_PATH}/*.txt \
	&& rm -rf ${TOOLS_PATH}/share/doc \
	&& apt remove -y xz-utils curl \
	&& cd home

# Add Toolchain to PATH
ENV PATH="$PATH:${TOOLS_PATH}/bin"