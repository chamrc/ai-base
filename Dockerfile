#-----------------------------------
# CUDA
#-----------------------------------
FROM nvidia/cuda:9.1-cudnn7-devel-ubuntu16.04
ENV CUDA_HOME /usr/local/cuda

#-----------------------------------
# Install basic dependencies
#-----------------------------------
RUN apt-get update && apt-get install -y --no-install-recommends \
        build-essential \
        cmake \
        git \
        curl \
        wget \
        libopencv-dev \
        libsnappy-dev \
        ca-certificates \
        libjpeg-dev \
        libpng-dev \
        tzdata \
        vim

#-----------------------------------
# Anaconda 3.6
#-----------------------------------
RUN wget --quiet https://repo.continuum.io/archive/Anaconda3-5.1.0-Linux-x86_64.sh -O ~/anaconda.sh && \
    /bin/bash ~/anaconda.sh -b -p /usr/local/anaconda3 && \
    rm ~/anaconda.sh && \
    echo "export PATH=/usr/local/anaconda3/bin:$PATH" >> ~/.bashrc

#-----------------------------------
# pip
#-----------------------------------
ENV PATH="/usr/local/anaconda3/bin:$PATH"
RUN apt-get install -y sudo
RUN pip install --upgrade pip
RUN pip install tqdm h5py lmdb pandas
RUN pip install cffi
RUN pip install networkx scipy
RUN pip install scikit-image
RUN pip install dill
RUN pip install python-Levenshtein
RUN pip install pynvrtc cupy


#-----------------------------------
# PyTorch
#-----------------------------------
RUN conda install pytorch torchvision cuda91 -c pytorch
# RUN pip install http://download.pytorch.org/whl/cu90/torch-0.3.1-cp35-cp35m-linux_x86_64.whl
# RUN pip install torchvision
# RUN pip install git+https://github.com/pytorch/tnt.git@master
# RUN pip install git+https://github.com/inferno-pytorch/inferno --no-deps
# RUN pip install --upgrade pip

#RUN apt-get install -y software-properties-common python-software-properties
#RUN sh -c 'echo "deb http://archive.getdeb.net/ubuntu yakkety-getdeb apps" >> /etc/apt/sources.list.d/getdeb.list'
#RUN wget -q -O - http://archive.getdeb.net/getdeb-archive.key | apt-key add -
#RUN apt-get update
#RUN apt-get install -y pycharm
#RUN add-apt-repository ppa:ubuntu-desktop/ubuntu-make
#RUN apt-get update
#RUN apt-get install -y ubuntu-make
#RUN umake ide pycharm
#RUN apt-get -y install snap snapd
#RUN service  snapd restart
#RUN snap install pycharm-community --classic

# Tensorflow
RUN pip install tensorflow-gpu

RUN pip install --upgrade pip

#-----------------------------------
# Cleanup
#-----------------------------------

WORKDIR /workspace
