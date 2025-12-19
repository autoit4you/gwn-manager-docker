FROM ubuntu:latest

WORKDIR /
ENV DEBIAN_FRONTEND noninteractive

RUN apt update && apt install -y wget

RUN wget https://firmware.grandstream.com/GWN_Manager-1.1.35.10-Ubuntu.tar.gz

FROM ubuntu:latest

WORKDIR /
ENV DEBIAN_FRONTEND noninteractive

COPY --from=0 /GWN_Manager-1.1.35.10-Ubuntu.tar.gz /GWN_Manager-1.1.35.10-Ubuntu.tar.gz

RUN apt update && apt install -y iproute2 openssh-server xfonts-utils fontconfig curl && tar -xzvf /GWN_Manager-1.1.35.10-Ubuntu.tar.gz && /GWN_Manager-1.1.35.10-Ubuntu/install

CMD ["/gwn/gwn", "start"]

EXPOSE 8000/tcp
EXPOSE 8443/tcp


