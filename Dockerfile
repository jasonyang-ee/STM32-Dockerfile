FROM ubuntu

# Prep Toolchain
RUN apt-get update &&\
	apt-get clean &&\
	apt-get install -y curl	xz-utils build-essential wget &&\
	ARM_TOOLCHAIN_VERSION=$(curl -s https://developer.arm.com/downloads/-/arm-gnu-toolchain-downloads | grep -Po '<h4>Version \K.+(?=</h4>)')  &&\
	curl -Lo gcc-arm-none-eabi.tar.xz "https://developer.arm.com/-/media/Files/downloads/gnu/${ARM_TOOLCHAIN_VERSION}/binrel/arm-gnu-toolchain-${ARM_TOOLCHAIN_VERSION}-x86_64-arm-none-eabi.tar.xz"

# Install Toolchain
RUN mkdir /opt/gcc-arm-none-eabi &&\
	tar xf gcc-arm-none-eabi.tar.xz --strip-components=1 -C /opt/gcc-arm-none-eabi &&\
	rm gcc-arm-none-eabi.tar.xz

# Add Toolchain to path
ENV PATH="$PATH:/opt/gcc-arm-none-eabi/bin"