FROM python:3.5.1

# https://github.com/GLYCAM-Web
LABEL maintainer "GLYCAM-Web <glycam@gmail.com>"

# Environment variables used by GEMS/GMML for compilation.
ENV GEMSHOME=/programs/gems/ PYTHON_HOME=/usr/local/include/python3.5m GEMSMAKEPROCS=4

# Update and install packages then set the timezone inside the image and create a user.
RUN apt-get update && \
    apt-get install -y --no-install-recommends --no-install-suggests \
      swig \
      qt4-dev-tools \
      qt4-qmake \
      vim \
      gdb \
      libboost-all-dev && \
    rm -rf /var/lib/apt/lists/*; \
    ln -s -f \
      /usr/share/zoneinfo/America/New_York \
      /etc/localtime && \
    dpkg-reconfigure -f \
      noninteractive tzdata; \
    useradd \
      --home-dir /home/glycam \
      --shell /bin/bash \
      --create-home \
      glycam;
      
ADD .bashrc /home/glycam/

# Clone the current version of GEMS and GMML dev branches into the image and compile them.
# This can be overridden by mounting a new host directory to /programs/gems/
RUN mkdir /programs/; \
    cd /programs/ && git clone https://github.com/GLYCAM-Web/gems.git -b gems-dev; \
    cd /programs/gems && git clone https://github.com/GLYCAM-Web/gmml.git -b gmml-dev; \
    bash make.sh; \
    chown -R glycam:glycam /programs/

# Set the rest of the commands to be run by glycam
USER glycam

# Set the working directory.
WORKDIR /programs/gems/

CMD [ "/bin/bash" ]
