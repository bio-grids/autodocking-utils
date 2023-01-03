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

# create a project directory inside user home
RUN mkdir app
WORKDIR /app

# build the conda environment
RUN conda update --name base --channel defaults conda
RUN conda install --name base --channel conda-forge mamba
RUN conda config --prepend channels bioconda
RUN conda config --prepend channels conda-forge
RUN mamba install \
    openbabel \
    mgltools \
    zlib \
    pip \
    numpy \
    scipy \
    rdkit \
    boost-cpp \
    sphinx \
    sphinx_rtd_theme \
    jupyterlab
RUN conda clean --all --yes

COPY requirements.txt /tmp/requirements.txt

RUN pip install -r /tmp/requirements.txt
