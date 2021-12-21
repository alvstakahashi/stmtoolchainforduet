# Pull base image.
FROM ubuntu:20.04
 
# Install
ENV PACKAGES \
 sudo vim  curl  file  \
 build-essential gcc g++ libgtest-dev google-mock \
 openssl libssl-dev \
 make fish wget git libboost-all-dev openssh-server    \
 pkg-config libglib2.0-dev libmount-dev python3 python3-pip python3-dev libffi-dev autoconf automake libfreetype6-dev \
 libtheora-dev libtool libvorbis-dev pkg-config texinfo zlib1g-dev unzip cmake yasm libx264-dev libmp3lame-dev libopus-dev \
 libvorbis-dev libxcb1-dev libxcb-shm0-dev libxcb-xfixes0-dev texinfo zlib1g-dev libpixman-1-dev \
 re2c python \
 ruby  gcc-arm-none-eabi gdb-multiarch libpixman-1-0 libjpeg-dev libudev-dev \
 gdb bison flex


#pacage 
RUN dpkg --add-architecture armhf && \
apt update && DEBIAN_FRONTEND=noninteractive  apt install -y  $PACKAGES

#Homebrew
#$ sudo apt-get update && sudo apt-get -y install build-essential curl file git

WORKDIR /home

#RUN /bin/bash -c "$(curl -fsSL #https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" && \
RUN  mkdir -p /home/.cache/Homebrew && cd /home/.cache/Homebrew && \
    wget https://github.com/Homebrew/homebrew-portable-ruby/releases/download/2.6.3/portable-ruby-2.6.3.aarch64_linux.bottle.tar.gz &&\
    sudo mkdir -p /home/linuxbrew/.linuxbrew/Library/Homebrew/vendor && \
    cd /home/linuxbrew/.linuxbrew/Library/Homebrew/vendor && \
 sudo tar -zxvf /home/.cache/Homebrew/portable-ruby-2.6.3.aarch64_linux.bottle.tar.gz && \
cd /home/linuxbrew/.linuxbrew/Library/Homebrew/vendor/portable-ruby && \
   sudo ln -sf 2.6.3 current && \
    export PATH=/home/linuxbrew/.linuxbrew/Library/Homebrew/vendor/portable-ruby/current/bin:$PATH && \
    cd /home/linuxbrew/.linuxbrew/ && \
    sudo git clone https://github.com/Homebrew/brew /home/linuxbrew/.linuxbrew/Homebrew && \
    sudo mkdir /home/linuxbrew/.linuxbrew/bin && \
    sudo ln -s /home/linuxbrew/.linuxbrew/Homebrew/bin/brew /home/linuxbrew/.linuxbrew/bin && \
    eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv) && \
    chown -R $(whoami) /home/linuxbrew/.linuxbrew/ 


#Ninja
RUN git clone git://github.com/ninja-build/ninja.git && cd ninja && \
./configure.py --bootstrap && cp ninja /usr/bin/

#TOOPERS ASP3
#sudo apt install ruby  gcc-arm-none-eabi gdb-multiarch libpixman-1-0 libjpeg-dev 

# ST-LINKのインストール　
#RUN apt install -y libusb-1.0
WORKDIR /home/cmake

RUN wget https://github.com/libusb/libusb/releases/download/v1.0.24/libusb-1.0.24.tar.bz2 && \
 tar -jxf libusb-1.0.24.tar.bz2 && \
 cd libusb-1.0.24 && \
 ./configure && make && make install 
 

RUN wget https://github.com/Kitware/CMake/releases/download/v3.17.1/cmake-3.17.1.tar.gz && \
 tar zxvf cmake-3.17.1.tar.gz && \
 cd cmake-3.17.1/ && \
 ./bootstrap && \
 make && make install

RUN git clone https://github.com/texane/stlink && cd stlink && make && \
    cd build/Release && make install && ldconfig && \
    rm -rf /home/cmake


#Qemu ソースからビルド
WORKDIR /home/qemu

#RUN apt install -y bison flex
RUN git clone -b stable-2.12_toppers https://github.com/toppers/qemu_zynq.git && \
    cd qemu_zynq && mkdir build && cd build && \
    ../configure --disable-werror --target-list=arm-softmmu && \
    make && make install && \
    rm -rf /home/qemu

#cfg
WORKDIR /home/cfg
RUN git clone https://github.com/alvstakahashi/Toppers_ASP3_Build_STM32_Duet.git && \
cp Toppers_ASP3_Build_STM32_Duet/cfg .

WORKDIR /home

#Brewの起動設定
ENV PATH /home/linuxbrew/.linuxbrew/Library/Homebrew/vendor/portable-ruby/current/bin:$PATH
RUN echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> /root/.bashrc

# 起動シェルbash
CMD ["/bin/bash"]