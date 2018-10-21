# Build
Here are two sample build environments.

# Run a C++-based test using docker

First build the g++ environment including googletest, a json parser, and protobuf:
````bash
docker build -f Dockerfile.build -t with_protobuf .
````
Then copy the src directory to a Docker volume (one time)
````bash
tar cvf - src | docker run --rm --mount source=srcVol,target=/vol -i ubuntu bash -c "cd /vol; tar xvf -"
````
and finally execute the tests:
````bash
docker run --rm --mount source=srcVol,target=/vol -t with_protobuf bash -c "cd /vol/src/json && make && ./tester"
docker run --rm --mount source=srcVol,target=/vol -t with_protobuf bash -c "cd /vol/src/proto && make && ./ptest"
````

This was tried using Ubuntu 18.04 using the docker installation instructions found here: https://docs.docker.com/install/linux/docker-ce/ubuntu/

# Modification when behind the firewall at Intel

The docker build commands need the following additional arguments behind the Intel firewall:
````bash
--build-arg http_proxy=http://proxy-chain.intel.com:911 --build-arg https_proxy=http://proxy-chain.intel.com:911
````
So the build command that needs a network connection becomes:
````bash
docker build -f Dockerfile.build -t with_protobuf --build-arg http_proxy=http://proxy-chain.intel.com:911 --build-arg https_proxy=http://proxy-chain.intel.com:911 .
````
Also, it seems that the http_proxy and https_proxy environment variables should not be set in the shell where you execute these docker build commands.

This was tried using WSL (Windows Subsystem for Linux) on a Win 10 Pro machine. The docker daemon is running as a windows process. The docker build and run command are executed in a WSL Ubuntu 18.04 shell.

# Run a Python-based test using docker

The docker build command is:
````bash
docker build -f Dockerfile.build.python -t with_python .
````

To run a python example, try:
```bash
tar cvf - src | docker run --rm --mount source=srcVol,target=/vol -i ubuntu bash -c "cd /vol; tar xvf -"
docker run --rm --mount source=srcVol,target=/vol -t with_python_protobuf bash -c "source /sympy/bin/activate && cd /vol/src/call-c-from-python  && python setup.py build && python setup.py install && pytest"
````