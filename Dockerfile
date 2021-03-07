FROM jlesage/baseimage-gui:ubuntu-18.04 AS build

MAINTAINER Jean Iaquinta, jeani@geo.uio.no

# GNU compiler
RUN apt-get update -y && \
     DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
         g++ \
         gcc \
         gfortran \
         ca-certificates \
         git \
         make \
         qt5-default \
         qtpositioning5-dev \
         vim \
         wget \
         bzip2 \
         file \
         libcurl4-openssl-dev \
         m4 \
         libhdf5-serial-dev \
         libnetcdf-dev \
         zlib1g-dev && \
     rm -rf /var/lib/apt/lists/*

# Copy the start script.
COPY startapp.sh /startapp.sh

# Generate and install favicons.
RUN \
    APP_ICON_URL=https://github.com/NordicESMhub/docker-vrm-editor/raw/main/vrm-app-icon.png && \
    install_app_icon.sh "$APP_ICON_URL"

RUN mkdir -p /opt/vrm && cd /opt/vrm/ && wget https://github.com/NordicESMhub/Community_Mesh_Generation_Toolkit/archive/0.2.1.tar.gz && tar zxf 0.2.1.tar.gz && \
    cd /opt/vrm/Community_Mesh_Generation_Toolkit-0.2.1/VRM_tools/VRM_Editor/src && \
    qmake -qt5 VRM_Editor.pro && \
    make

RUN mkdir -p /opt/vrm/repo

ENV PATH=/opt/vrm/Community_Mesh_Generation_Toolkit-0.2.1/VRM_tools/VRM_Editor/src:$PATH

# Set the name of the application.
ENV APP_NAME="VRM-Editor"

ENV KEEP_APP_RUNNING=0

ENV TAKE_CONFIG_OWNERSHIP=1

ENV QT_GRAPHICSSYSTEM="minimal"

RUN sed-patch 's/<application type="normal">/<application type="normal" title="VRM Editor">/' /etc/xdg/openbox/rc.xml

COPY rc.xml /etc/xdg/openbox/rc.xml

# Define mountable directories.
VOLUME ["/config"]
VOLUME ["/storage"]
