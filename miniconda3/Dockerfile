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
    git"

RUN apt-get update --fix-missing
RUN apt-get install --yes $build_deps
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/*

# Create a non-root user
ARG username=autodocking
ARG uid=1000
ARG gid=100
ENV USER $username
ENV UID $uid
ENV GID $gid
ENV HOME /home/$USER

RUN adduser --disabled-password \
    --gecos "Non-root user" \
    --uid $UID \
    --gid $GID \
    --home $HOME \
    $USER

USER $USER

# install miniconda
ENV MINICONDA_VERSION latest
ENV CONDA_DIR $HOME/miniconda3
WORKDIR ~/
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
ENV PROJECT_DIR $HOME/app
RUN mkdir $PROJECT_DIR
WORKDIR $PROJECT_DIR

# build the conda environment
ENV ENV_PREFIX $PROJECT_DIR/env
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
    swig \
    boost-cpp \
    sphinx \
    sphinx_rtd_theme \
    jupyterlab
RUN conda clean --all --yes

USER root

COPY requirements.txt /tmp/
RUN chown $UID:$GID /tmp/requirements.txt

COPY entrypoint.sh /usr/local/bin/
RUN chown $UID:$GID /usr/local/bin/entrypoint.sh && chmod u+x /usr/local/bin/entrypoint.sh

RUN pip install -r /tmp/requirements.txt

USER $USER
