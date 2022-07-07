# Build layer
FROM nvidia/cuda:10.2-devel-ubuntu18.04 as builder

# install required packages
RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    git \
    build-essential \
    cmake \
    automake \
    libtool \
    autoconf \
    wget

# build the xmrig binary
RUN git clone https://github.com/xmrig/xmrig.git 
RUN mkdir /xmrig/build && cd /xmrig/scripts && ./build_deps.sh && cd ../build && cmake .. -DXMRIG_DEPS=scripts/deps && make -j4

# build the CUDA plugin
RUN git clone https://github.com/xmrig/xmrig-cuda.git
RUN mkdir /xmrig-cuda/build && cd /xmrig-cuda/build && cmake .. -DCUDA_LIB=/usr/local/cuda/lib64/stubs/libcuda.so -DCUDA_TOOLKIT_ROOT_DIR=/usr/local/cuda && make -j4

# Runtime layer
FROM nvidia/cuda:10.2-runtime-ubuntu18.04

# Set some defaults
ENV PATH=/xmrig/build:$PATH
ENV LIBXMRIG_CUDA=/xmrig-cuda/build/libxmrig-cuda.so
ENV DONATE_LVL=1
ENV POOL=us-west.minexmr.com
ENV PORT=443

# get the binaries from the previous layer
COPY --from=builder /xmrig/build /xmrig/build 
COPY --from=builder /xmrig-cuda/build /xmrig-cuda/build

# add a non-root user
RUN useradd -ms /bin/bash xmrig
USER xmrig
WORKDIR /home/xmrig

# get entrypoint script
COPY runxmrig.sh .

# set entrypoint
ENTRYPOINT ["bash","runxmrig.sh"]