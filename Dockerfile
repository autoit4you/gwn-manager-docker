FROM ubuntu:latest

WORKDIR /
ENV DEBIAN_FRONTEND noninteractive

RUN apt update && apt install wget

RUN wget https://firmware.grandstream.com/GWN_Manager-1.1.35.10-Ubuntu.tar.gz

FROM ubuntu:latest

WORKDIR /
ENV DEBIAN_FRONTEND noninteractive

COPY --from=0 /GWN_Manager-1.1.35.10-Ubuntu.tar.gz /GWN_Manager-1.1.35.10-Ubuntu.tar.gz

RUN apt update && apt install iproute2 openssh-server xfonts-utils fontconfig curl
RUN tar -xzvf /GWN_Manager-1.1.35.10-Ubuntu.tar.gz
RUN /GWN_Manager-1.1.35.10-Ubuntu/install

ENTRYPOINT ["/gwn/gwn", "start"]

EXPOSE 8000/tcp
EXPOSE 8443/tcp


