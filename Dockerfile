FROM ubuntu:latest

WORKDIR /
ENV DEBIAN_FRONTEND noninteractive

RUN apt update && apt install -y wget

RUN wget https://firmware.grandstream.com/GWN_Manager-1.1.35.10-Ubuntu.tar.gz

FROM ubuntu:latest

WORKDIR /
ENV DEBIAN_FRONTEND noninteractive
ENV GWN_MANAGER_VERSION 1.1.35.10

COPY --from=0 /GWN_Manager-1.1.35.10-Ubuntu.tar.gz /GWN_Manager-1.1.35.10-Ubuntu.tar.gz

RUN apt update && apt install -y iproute2 openssh-server xfonts-utils fontconfig curl && \
    mkdir /GWN_Manager && \
    tar -xzvf /GWN_Manager-1.1.35.10-Ubuntu.tar.gz -C /GWN_Manager/ --strip-components=1 && \
    rm /GWN_Manager-1.1.35.10-Ubuntu.tar.gz && \
    dpkg -i /GWN_Manager/packages/*.deb && rm -rf /gwn/logs/* /gwn/data/*
ADD --chmod=755 run-gwn.sh /

CMD ["/run-gwn.sh"]
