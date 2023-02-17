FROM ubuntu
RUN apt-get update &&\
	apt-get install curl &&\
	apt-get install xz-utils &&\
	ARM_TOOLCHAIN_VERSION=$(curl -s https://developer.arm.com/downloads/-/arm-gnu-toolchain-downloads | grep -Po '<h4>Version \K.+(?=</h4>)') &&\
	curl -Lo gcc-arm-none-eabi.tar.xz "https://developer.arm.com/-/media/Files/downloads/gnu/${ARM_TOOLCHAIN_VERSION}/binrel/arm-gnu-toolchain-${ARM_TOOLCHAIN_VERSION}-x86_64-arm-none-eabi.tar.xz" &&\
	sudo mkdir /opt/gcc-arm-none-eabi &&\
	sudo tar xf gcc-arm-none-eabi.tar.xz --strip-components=1 -C /opt/gcc-arm-none-eabi &&\
	echo 'export PATH=$PATH:/opt/gcc-arm-none-eabi/bin' | tee -a /etc/profile.d/gcc-arm-none-eabi.sh &&\
	source /etc/profile &&\
	rm -rf gcc-arm-none-eabi.tar.xz
