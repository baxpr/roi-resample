FROM centos:7

# Initial system
# bc libgomp perl tcsh vim-common                    for FS
#     mesa-libGL libXext libSM libXrender libXmu
# java-1.8.0-openjdk                                 for MCR
# mesa-libGLU mesa-dri-drivers                       for FS with xvfb
# xorg-x11-server-Xvfb xorg-x11-xauth which          xvfb
RUN yum -y update && \
    yum -y install wget tar zip unzip && \
    yum -y install bc libgomp perl tcsh vim-common && \
    yum -y install mesa-libGL libXext libSM libXrender libXmu && \
    yum -y install java-1.8.0-openjdk && \
    yum -y install mesa-libGLU mesa-dri-drivers && \
    yum -y install xorg-x11-server-Xvfb xorg-x11-xauth which && \
    yum -y install ImageMagick && \
    yum clean all

# Install the MCR
RUN wget -nv https://ssd.mathworks.com/supportfiles/downloads/R2019b/Release/6/deployment_files/installer/complete/glnxa64/MATLAB_Runtime_R2019b_Update_6_glnxa64.zip \
    -O /opt/mcr_installer.zip && \
    unzip /opt/mcr_installer.zip -d /opt/mcr_installer && \
    /opt/mcr_installer/install -mode silent -agreeToLicense yes && \
    rm -r /opt/mcr_installer /opt/mcr_installer.zip

# Matlab env
ENV MATLAB_SHELL=/bin/bash
ENV MATLAB_RUNTIME=/usr/local/MATLAB/MATLAB_Runtime/v97

# Copy the pipeline code. Matlab must be compiled before building. 
COPY build /opt/resample-roi/build
COPY bin /opt/resample-roi/bin
COPY src /opt/resample-roi/src
COPY README.md /opt/resample-roi

# Add pipeline to system path
ENV PATH=/opt/resample-roi/src:/opt/resample-roi/bin:${PATH}

# Matlab executable must be run at build to extract the CTF archive
RUN run_spm12.sh ${MATLAB_RUNTIME} function quit

# Entrypoint
ENTRYPOINT ["xwrapper.sh","pipeline.sh"]
