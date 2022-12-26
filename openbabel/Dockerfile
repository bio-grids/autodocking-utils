FROM ubuntu

ARG DEBIAN_FRONTEND=noninteractive

SHELL ["/bin/bash", "-c"]

# Install dependencies
ARG build_deps="\
    build-essential \
    ca-certificates \
    cmake \
    libboost-filesystem-dev \
    libboost-iostreams-dev \
    libboost-program-options-dev \
    libboost-regex-dev \
    libboost-system-dev \
    libboost-thread-dev \
    libboost-serialization-dev \
    libboost-python-dev \
    libboost-test-dev \
    libboost-dev \
    libcairo2-dev \
    libeigen3-dev \
    libxml2-dev \
    python3 \
    python3-dev \
    python3-pip \
    python3-numpy \
    python3-cairo \
    rapidjson-dev \
    wget \
    libxml2 \
    swig \
    zlib1g-dev \
    libbz2-dev \
    lzma \
    git"
RUN apt-get update -y
RUN apt-get install --yes --no-install-recommends --quiet $build_deps

SHELL ["/bin/bash", "-c"]

# Arguments
ARG OPENBABEL_VERSION=3.1.1
ARG OPENBABEL_DIR=3-1-1
ARG OPENBABEL_HOME=/usr/local/openbabel/$OPENBABEL_DIR

# Download and unzip openbabel
RUN wget --quiet --no-hsts --output-document=- https://github.com/openbabel/openbabel/archive/openbabel-${OPENBABEL_VERSION//./-}.tar.gz | tar -zxvf - -C /tmp
RUN mkdir -p /tmp/openbabel-openbabel-${OPENBABEL_VERSION//./-}/build
WORKDIR /tmp/openbabel-openbabel-${OPENBABEL_DIR}/build

# Build and install openbabel
RUN cmake \
    -W no-dev \
    -D RUN_SWIG=ON \
    -D PYTHON_BINDINGS=ON \
    -D PYTHON_EXECUTABLE=/usr/bin/python3.10 \
    -D CMAKE_INSTALL_PREFIX=$OPENBABEL_HOME \
    -D CMAKE_BUILD_TYPE=Release \
    ..
RUN make -j $(nproc) && make install

# Set environment variables
ENV LD_LIBRARY_PATH=$OPENBABEL_HOME/lib:$LD_LIBRARY_PATH
ENV PATH=$OPENBABEL_HOME/bin:$PATH

# Install openbabel and pybel python libraries
RUN pip3 install --install-option=build_ext --install-option="-I$OPENBABEL_HOME/include/openbabel3" --install-option="-L$OPENBABEL_HOME/lib" openbabel
RUN pip3 install pybel

# Clean files
RUN cd / && rm -rf /tmp/*
RUN apt-get purge --yes --auto-remove $build_deps
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

RUN cd / && mkdir -p app
WORKDIR /app

CMD ["/usr/bin/python3"]
