# syntax=docker/dockerfile:1

# Get python version
ARG python_version

# Create Container
FROM python:${python_version}-alpine

# Get remaining arguments
ARG exoctk_version

# set up working directory
WORKDIR /exoctk

# Set up container environment
ENV EXOCTK_DATA="/exoctk/exoctk_data/"
ENV MODELGRID_DIR="/exoctk/exoctk_data/modelgrid/"
ENV EXOCTK_VERSION=${exoctk_version}
ENV FLASK_APP=app_exoctk.py
ENV FLASK_RUN_HOST="0.0.0.0"
ENV FLASK_RUN_PORT="5000"

# Install necessary base software
RUN apk update
RUN echo "http://dl-8.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories
RUN apk --no-cache --update-cache add gcc gfortran build-base wget freetype-dev libpng-dev openblas-dev git hdf5-dev

# Install numpy with custom batman
WORKDIR /exoctk
RUN pip install --force-reinstall --no-cache-dir numpy==2.2.6
RUN pip uninstall batman-package
RUN git clone https://github.com/lkreidberg/batman.git
WORKDIR /exoctk/batman
RUN pip install .
WORKDIR /exoctk

# Install very specific versions of packages
RUN pip install svo-filters==0.4.4

ARG exoctk_repo

# Clone exoctk repository
ADD https://api.github.com/repos/${exoctk_repo}/git/refs/heads/$EXOCTK_VERSION version.json
RUN git clone https://github.com/${exoctk_repo}
WORKDIR /exoctk/exoctk
RUN git checkout $EXOCTK_VERSION
RUN pip install -e .

# Set up the port that exoctk will listen on
EXPOSE 5000

# Add the entrypoint scripts
WORKDIR /exoctk
COPY ./exoctk_entrypoint.sh exoctk_entrypoint.sh
RUN chmod +x exoctk_entrypoint.sh
COPY ./worker_entrypoint.sh worker_entrypoint.sh
RUN chmod +x worker_entrypoint.sh

# Run exoctk
WORKDIR /exoctk/exoctk/exoctk
CMD ["tail", "-f", "/dev/null"]
