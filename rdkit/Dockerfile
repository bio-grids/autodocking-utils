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

WORKDIR /

# Arguments
ARG RDKIT_DIR=2022_09_3
ARG RDKIT_HOME=/usr/local/rdkit/$RDKIT_DIR

# Download and unzip rdkit
RUN wget --quiet --no-hsts --output-document=- https://github.com/rdkit/rdkit/archive/Release_${RDKIT_DIR}.tar.gz | tar -zxvf - -C /tmp
RUN mkdir -p /tmp/rdkit-Release_${RDKIT_DIR}/build
WORKDIR /tmp/rdkit-Release_${RDKIT_DIR}/build

# Build and install rdkit
# RDK_OPTIMIZE_NATIVE=ON assumes container will be run on the same architecture on which it is built
RUN cmake -Wno-dev \
  -D RDK_INSTALL_INTREE=OFF \
  -D RDK_INSTALL_STATIC_LIBS=OFF \
  -D RDK_BUILD_INCHI_SUPPORT=ON \
  -D RDK_BUILD_AVALON_SUPPORT=ON \
  -D RDK_BUILD_PYTHON_WRAPPERS=ON \
  -D RDK_BUILD_CAIRO_SUPPORT=ON \
  -D RDK_USE_FLEXBISON=OFF \
  -D RDK_BUILD_THREADSAFE_SSS=ON \
  -D RDK_OPTIMIZE_NATIVE=ON \
  -D PYTHON_EXECUTABLE=/usr/bin/python3.10 \
  -D PYTHON_NUMPY_INCLUDE_PATH="$(python -c 'import numpy; print(numpy.get_include())')" \
  -D CMAKE_INSTALL_PREFIX=$RDKIT_HOME \
  -D CMAKE_BUILD_TYPE=Release \
  ..

RUN make -j $(nproc) && make install

# Clean files
RUN cd / && rm -rf /tmp/*
RUN apt-get purge --yes --auto-remove $build_deps
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

RUN cd / && mkdir -p app
WORKDIR /app

CMD ["/usr/bin/python3"]
