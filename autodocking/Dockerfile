FROM ubuntu

LABEL maintainer="DHN Chandan <php.chandan@gmail.com>"

SHELL [ "/bin/bash", "--login", "-c" ]

ARG build_deps="\
    build-essential \
    ca-certificates \
    pdb2pqr \
    wget \
    bzip2 \
    curl \
    swig \
    libxml2 libsm6 libxext6 libxrender-dev libgomp1 \
    git"

RUN apt-get update --fix-missing
RUN apt-get install --yes $build_deps
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/*

# install miniconda
ENV MINICONDA_VERSION latest
ENV CONDA_DIR /miniconda3
WORKDIR /
RUN wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-$MINICONDA_VERSION-Linux-x86_64.sh -O miniconda.sh
RUN chmod +x miniconda.sh
RUN bash ./miniconda.sh -b -p $CONDA_DIR
RUN rm miniconda.sh

# make non-activate conda commands available
ENV PATH=$CONDA_DIR/bin:$PATH

# make conda activate command available from /bin/bash --login shells
RUN echo ". $CONDA_DIR/etc/profile.d/conda.sh" >> ~/.profile

# make conda activate command available from /bin/bash --interative shells
RUN conda init bash

WORKDIR /tmp
RUN curl -SL https://ccsb.scripps.edu/adfr/download/1038 | tar -zx; \
    cd ADFRsuite_x86_64Linux_1.0; ./install.sh -d /opt/adfr/ -c 1 -l

ENV PATH=$PATH:/opt/adfr/bin/

# build the conda environment
RUN conda update --name base --channel defaults conda
RUN conda install --name base --channel conda-forge mamba
RUN conda config --prepend channels bioconda
RUN conda config --prepend channels conda-forge
RUN mamba install --yes \
    openbabel \
    mgltools \
    zlib \
    pip \
    numpy \
    pandas \
    scipy \
    rdkit \
    boost-cpp \
    sphinx \
    sphinx_rtd_theme \
    fpocket \
    pdbfixer \
    pymol-open-source \
    jupyterlab
RUN conda clean --all --yes

COPY requirements.txt requirements.txt

RUN pip install -r requirements.txt

RUN rm -rf /tmp/*

# copy bin files and add to path
WORKDIR /ubin
COPY bin/ .
ENV PATH=$PATH:/ubin/

# create a project directory inside user home
RUN mkdir app
WORKDIR /app
