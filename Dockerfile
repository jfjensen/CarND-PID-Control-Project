
# starting with GCC image
FROM gcc:4.9

# let's update it...
RUN apt-get update

# make sure we have make...
RUN apt-get install make

# create a download dir...
RUN mkdir /temp
WORKDIR temp

# install cmake
RUN wget https://cmake.org/files/v3.8/cmake-3.8.0-Linux-x86_64.sh
RUN chmod 777 ./cmake-3.8.0-Linux-x86_64.sh
RUN echo y | ./cmake-3.8.0-Linux-x86_64.sh
RUN rm -r ./cmake-3.8.0-Linux-x86_64.sh

# set the path of cmake (not very clean, but it works)
# https://stackoverflow.com/questions/27093612/in-a-dockerfile-how-to-update-path-environment-variable
ENV PATH="/temp/cmake-3.8.0-Linux-x86_64/bin:${PATH}"

# get LIBUV and install it...
RUN git clone https://github.com/libuv/libuv.git
WORKDIR libuv
RUN ./autogen.sh
RUN ./configure
RUN make
RUN make install

WORKDIR ..

# get uWebsockets and install...
RUN git clone https://github.com/uWebSockets/uWebSockets.git
WORKDIR uWebSockets
RUN make
RUN make install

# go to our home dir and copy contents of our host dir...
WORKDIR /home
COPY . /home
COPY CMakeLists.txt CMakeLists.txt
RUN cmake .
RUN make

# next step: https://stackoverflow.com/questions/22049212/docker-copy-file-from-container-to-host