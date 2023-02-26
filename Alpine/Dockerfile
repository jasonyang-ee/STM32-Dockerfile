FROM alpine:3.17.2

ARG TOOLS_PATH=/opt/gcc-arm-none-eabi
ARG ARM_VERSION=12.2.rel1

# Prep basic packages
RUN apk --no-cache add \
	gcompat libc6-compat libstdc++ g++ gcc \
	make cmake ninja \
	git \
	stlink \
	bash curl
				
# Get ARM Toolchain
RUN mkdir ${TOOLS_PATH} \
	&& curl -Lo gcc-arm-none-eabi.tar.xz "https://developer.arm.com/-/media/Files/downloads/gnu/${ARM_VERSION}/binrel/arm-gnu-toolchain-${ARM_VERSION}-x86_64-arm-none-eabi.tar.xz" \
	&& tar xf gcc-arm-none-eabi.tar.xz --strip-components=1 -C ${TOOLS_PATH}

# Clean Up
RUN rm gcc-arm-none-eabi.tar.xz \
	&& rm ${TOOLS_PATH}/*.txt \
	&& rm -rf ${TOOLS_PATH}/share/doc \
	&& apk del curl

# Add Toolchain to PATH
ENV PATH="$PATH:${TOOLS_PATH}/bin"

ADD build.sh /usr/local/bin/build.sh
ENTRYPOINT ["bin/bash", "/usr/local/bin/build.sh"]
