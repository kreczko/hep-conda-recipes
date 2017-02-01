FROM cern/slc6-base:20170113
LABEL maintainer Luke Kreczko <kreczko@cern.ch>

RUN yum update -y
RUN yum install -y git nano curl cmake gcc-c++ libssl-dev libcurl4-openssl-dev \
                   python-dev libpcre3 libpcre3-dev python-pip libxml2-dev \
                   uuid-dev patch wget gcc pcre-devel libxml2-devel flex bison \
                   libcurl-devel libcgroup-pam pam-devel libtool-ltdl-devel \
                   perl-Archive-Tar libtool libuuid-devel krb5-devel

RUN yum install -y condor
RUN yum clean all

RUN wget -q https://repo.continuum.io/miniconda/Miniconda-latest-Linux-x86_64.sh && \
    /bin/bash Miniconda-latest-Linux-x86_64.sh -b -p conda && \
    rm -f Miniconda-latest-Linux-x86_64.sh
ENV PATH=/conda/bin:$PATH
RUN source conda/bin/activate root
RUN conda/bin/conda update --yes -q conda && \
    conda/bin/conda update --yes --all && \
    conda/bin/conda install --yes  conda-build anaconda-client
ENV CONDARC /root/.condarc
RUN conda/bin/conda config --add channels https://conda.binstar.org/auto && \
    conda/bin/conda config --add channels https://conda.binstar.org/kreczko && \
    conda/bin/conda config --add channels https://conda.binstar.org/conda-forge && \
    conda/bin/conda config --set show_channel_urls yes

VOLUME ["/conda-recipes"]
WORKDIR /conda-recipes
