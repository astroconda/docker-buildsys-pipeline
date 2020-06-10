FROM centos:6.9

# Declare build-time environment

# Miniconda
ARG MC_BASE_PYTHON=py37
ARG MC_VERSION=4.8.2
ARG MC_PLATFORM=Linux
ARG MC_ARCH=x86_64
ARG MC_URL=https://repo.continuum.io/miniconda

# Conda root
ARG CONDA_VERSION=4.8.2
ARG CONDA_BUILD_VERSION
ARG CONDA_PACKAGES

# Pipeline definition
ARG SNAPSHOT_URL


# Declare environment
ENV OPT=/opt \
    HOME=/home/developer

ENV PYTHONUNBUFFERED=1 \
    MC_VERSION=${MC_VERSION} \
    MC_PLATFORM=${MC_PLATFORM} \
    MC_ARCH=${MC_ARCH} \
    MC_URL=${MC_URL} \
    MC_INSTALLER=Miniconda3-${MC_BASE_PYTHON}_${MC_VERSION}-${MC_PLATFORM}-${MC_ARCH}.sh \
    MC_PATH=${OPT}/conda \
    CONDA_VERSION=${CONDA_VERSION} \
    CONDA_BUILD_VERSION=${CONDA_BUILD_VERSION} \
    CONDA_PACKAGES=${CONDA_PACKAGES}

# Toolchain
RUN yum update -y && yum install -y \
        bzip2-devel \
        curl \
        gcc \
        gcc-c++ \
        gcc-gfortran \
        git \
        glibc-devel.i686 \
        glibc-devel \
        kernel-devel \
        libX11-devel \
        mesa-libGL \
        mesa-libGLU \
        ncurses-devel \
        subversion \
        sudo \
        wget \
        zlib-devel \
    && yum clean all

# Create 'developer' user
# Configure sudoers
RUN groupadd developer \
    && useradd -g developer -m -d $HOME -s /bin/bash developer \
    && echo "developer:developer" | chpasswd \
    && echo "developer ALL=(ALL)	NOPASSWD: ALL" >> /etc/sudoers

# Install Miniconda
# Reset permissions
RUN curl -q -O ${MC_URL}/${MC_INSTALLER} \
    && bash ${MC_INSTALLER} -b -p ${MC_PATH} \
    && rm -rf ${MC_INSTALLER} \
    && echo export PATH="${MC_PATH}/bin:\${PATH}" > /etc/profile.d/conda.sh \
    && chown -R developer: ${OPT} ${HOME}


# Configure Conda
ENV PATH "${MC_PATH}/bin:${PATH}"
USER developer

RUN conda config --set auto_update_conda false \
    && conda config --set always_yes true \
    && conda config --set quiet true \
    && conda config --set rollback_enabled false \
    && conda install --yes --quiet \
        conda=${CONDA_VERSION} \
        git \
        ${CONDA_PACKAGES} \
    && curl -LO ${SNAPSHOT_URL} \
    && conda env update -n base --file $(basename $SNAPSHOT_URL)

WORKDIR ${HOME}

CMD ["/bin/bash"]
