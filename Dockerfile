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
    dpkg -i /GWN_Manager/packages/*.deb && \
    /gwn/scripts/install_gwn.sh "/GWN_Manager/packages/GWN_Manager_Upgrade_$GWN_MANAGER_VERSION.tar.gz" notstart && \
    rm -rf /gwn/logs/* /gwn/data/* /gwn/conf/* /gwn_backup
ADD --chmod=755 run-gwn.sh /

CMD ["/run-gwn.sh"]
