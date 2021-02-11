FROM alpine as Mirrorfyinstall
WORKDIR /src
COPY . .

RUN apk add inotify-tools openssh rsync screen openssh bash && \
chmod +x mirrorfy && \
chmod +x docker_cmd.sh && \
cp  -r /etc/ssh/ /etc/sshd/ && \
touch first_run

CMD [ "/src/docker_cmd.sh" ]