FROM nvidia/cuda:9.0-cudnn7-devel-ubuntu16.04

# install basic dependencies
RUN apt-get update && apt-get upgrade -y && apt-get install -y --no-install-recommends \
    sudo git wget cmake nano vim gcc g++ build-essential ca-certificates software-properties-common \
    && rm -rf /var/lib/apt/lists/*

# install python
RUN add-apt-repository ppa:deadsnakes/ppa \
&& apt-get update \
&& apt-get install -y python3.6 \
&& wget -O ./get-pip.py https://bootstrap.pypa.io/get-pip.py \
&& python3.6 ./get-pip.py \
&& ln -s /usr/bin/python3.6 /usr/local/bin/python3 \
&& ln -s /usr/bin/python3.6 /usr/local/bin/python

# install common python packages
RUN pip install pip setuptools -U \
&& pip install tensorflow-gpu==1.10.0 pillow==5.4.1 requests==2.21.0

COPY . /app
WORKDIR /app
RUN pip install -r requirements.txt
# ENTRYPOINT [ "python", "dataset-tools.py" ]