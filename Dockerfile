# docker build -t my-vsftpd .
# docker run -d --rm -p 20:20 -p 21:21 -p 8080:80 -v roosterpict:/home/rooster/ftp/upload my-vsftpd
# docker exec -it <container_id> /bin/bash


FROM ubuntu:latest

RUN apt-get update && \
    apt-get install -y vsftpd && \
    apt-get clean

RUN echo "anonymous_enable=NO" >> /etc/vsftpd.conf && \
    echo "local_enable=YES" >> /etc/vsftpd.conf && \
    echo "write_enable=YES" >> /etc/vsftpd.conf && \
    echo "chroot_local_user=YES" >> /etc/vsftpd.conf && \
    echo "allow_writeable_chroot=YES" >> /etc/vsftpd.conf && \
    echo "local_umask=022" >> /etc/vsftpd.conf && \
    echo "dirmessage_enable=YES" >> /etc/vsftpd.conf && \
    echo "xferlog_enable=YES" >> /etc/vsftpd.conf && \
    echo "listen=YES" >> /etc/vsftpd.conf && \
    echo "listen_ipv6=NO" >> /etc/vsftpd.conf

RUN useradd -m rooster -s /bin/bash && \
    echo "rooster:password" | chpasswd

RUN mkdir -p /home/rooster/ftp/upload && \
    chown nobody:nogroup /home/rooster/ftp && \
    chown rooster:rooster /home/rooster/ftp/upload && \
    chmod 777 /home/rooster/ftp/upload

RUN mkdir -p /var/run/vsftpd/empty

EXPOSE 20 21

CMD vsftpd /etc/vsftpd.conf