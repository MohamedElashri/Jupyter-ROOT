
FROM centos:8

WORKDIR /work

# Install packages from CentOS 7 base
RUN yum -y update
RUN yum -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
RUN yum -y install centos-release-scl

# install gcc 7
RUN yum -y install devtoolset-7-gcc*
SHELL [ "/usr/bin/scl", "enable", "devtoolset-7"]

# Install packages needed for ROOT
RUN yum -y install python3 python3-pip root which python3-root python3-devel
RUN yum -y install root-tmva root-tmva-python root-minuit2 python3-jupyroot

# curl will be needed when we install python packages below.
RUN yum -y install curl libcurl libcurl-devel

# Additional packages for some C++ work:
RUN yum -y install make boost-devel gsl-devel binutils-devel 
#RUN yum -y install gcc-c++ gcc-gfortran

# Set up cmake3 as default version of cmake.
RUN yum -y install cmake3 
RUN ln -sf /usr/bin/cmake3 /usr/bin/cmake

# Install python packages 
RUN pip3 install --upgrade wheel
RUN pip3 install --upgrade jupyter
RUN pip3 install --upgrade numpy scipy matplotlib 
RUN pip3 install --upgrade jupyterlab
RUN pip3 install --upgrade iminuit pandas sympy terminado urllib3 pycurl tables
RUN pip3 install --upgrade rootpy rootkernel root-numpy uproot

# Wrap it up.
RUN yum clean all

# Run jupyter when this docker container is started.
CMD ["jupyter", "notebook", "--ip=0.0.0.0", "--port=8080", "--allow-root"]
