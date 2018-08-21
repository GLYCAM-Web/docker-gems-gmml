# docker-gems-gmml

This is the Git repo of the Docker image for [GLYCAM-Web](https://github.com/GLYCAM-Web) [GEMS](https://github.com/GLYCAM-Web/gems)/[GMML](https://github.com/GLYCAM-Web/gmml). The Docker image has an already compiled version of GEMS/GMML development branches, which was the current state of those projects/branches at the time of building the image. If you would like to have an image with the latest, see below for some instructions.

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.

### Prerequisites

[Docker](https://docs.docker.com) - Docker is a computer program that performs operating-system-level virtualization, also known as "containerization".

### Pulling the Docker image

``docker pull glycamweb/gems-gmml``

### Usages


#### Usage #1: Basic Usage

```
docker run \
    -it \
    glycamweb/gems-gmml
```

This command will start a Docker container and give you an interactive shell inside of the container with a working directory of /programs/gems/. As mentioned above, this image comes with a precompiled version of GMML and a Python wrapping for GEMS. 

To test everything is compiled correctly, you can run the command:

``bash test_installation.bash``

#### Usage #2: Compile your local version of GEMS/GMML

```
docker run \
    -it \
    -v /path/to/your/gems:/programs/gems/ \
    glycamweb/gems-gmml
```

This command will start a Docker container with your version of GEMS/GMML mounted inside the container at /programs/gems/ and give you an interactive shell inside the container. 

Your version of GEMS/GMML are not compiled yet, so you should first run the command:

``bash make.sh``

This will compile your version of GMML and wrap it into GEMS. This may take a little bit of time, so now is a good time to grab some coffee.

#### Usage #3: Using GEMS/GMML as a library for another program

As an example, [GlycoProtein Builder](https://github.com/gitoliver/GlycoProteinBuilder) is a program developed by Oliver Grant, which uses GMML functionality. In this example, we will use the Docker image to compile GlycoProtein Builder inside the image.

```
docker run \
    -it \
    -v /path/to/your/GlycoProteinBuilder:/home/glycam/GlycoProteinBuilder \
    -w /home/glycam/GlycoProteinBuilder \
    glycamweb/gems-gmml
```

This command will start a Docker container with the precompiled version of GEMS/GMML in the Docker image with your local version of GlycoProteinBuilder mounted in the container at /home/glycam/GlycoProteinBuilder and give you an interactive shell inside the container with the working directory of /home/glycam/GlycoProteinBuilder. You will then be able to compile GlycoProteinBuilder by running the command ```make```. See [GlycoProteinBuilder's README.md](https://github.com/gitoliver/GlycoProteinBuilder/blob/master/README.md) for more.

### ENVIRONMENT VARIABLES

A list of predefined ENV variables in the Docker image.
See https://docs.docker.com/engine/reference/commandline/run/#set-environment-variables--e---env---env-file for how to define them.

#### ```GEMSHOME```

Default value for ```GEMSHOME``` is /programs/gems/. This environment variable represents the location of your GEMS directory. Generally, there is no need to change this variable, but you can if you find a need to. For example, if you wanted to mount your local version of GEMS/GMML, but didn't want to override the version in /programs/gems/ and you want to use your local version in the Docker image.

#### ```PYTHON_HOME```

Default value for ```PYTHON_HOME``` is /usr/local/include/python3.5m. This environment variable represents the location of the the header files for Python in the image. Generally, there is no need to change this variable, but you can if you find a need to.

#### ```GEMSMAKEPROCS```

Defaule value for ```GEMSMAKEPROCS``` is 4. This environment variable represents the number of processes used for compiling GEMS/GMML when using the make.sh script in GEMS. If you are compiling GEMS/GMML inside the container and not using the precompiled version, then you may find it useful to change this environment variable.

## NOTE

This image has been tested on Ubuntu and Debian machines. Since it is using Docker, there is little reason to think it wouldn't work for Docker on Mac or Windows, but if you find otherwise, please submit an issue.

