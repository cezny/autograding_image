# Autolab - autograding docker image

FROM ubuntu:16.04
MAINTAINER Mihir Pandya <mihir.m.pandya@gmail.com>

RUN apt-get update --fix-missing
RUN apt-get install -y gcc make build-essential

# Install autodriver
WORKDIR /home
RUN useradd autolab
RUN useradd autograde
RUN apt-get -y install sudo
RUN adduser autolab sudo
RUN adduser autograde sudo
RUN mkdir autolab autograde output
RUN chown autolab:autolab autolab
RUN chown autolab:autolab output
RUN chown autograde:autograde autograde
RUN apt-get install -y git
RUN git clone https://github.com/autolab/Tango.git
WORKDIR Tango/autodriver
RUN make clean && make
RUN cp autodriver /usr/bin/autodriver
RUN chmod +s /usr/bin/autodriver

# Clean up
WORKDIR /home
RUN apt-get -y autoremove
RUN rm -rf Tango/

# Check installation
RUN ls -l /home
RUN which autodriver
