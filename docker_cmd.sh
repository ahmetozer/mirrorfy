#!/bin/bash

port=${port-22}
user=${user-mirrorfy}

if [ ! -f "/etc/ssh/ssh_host_dsa_key" ]; then
    if [ ! -z "$port" ]; then
        port_regex="^((6553[0-5])|(655[0-2][0-9])|(65[0-4][0-9]{2})|(6[0-4][0-9]{3})|([1-5][0-9]{4})|([1-9][0-9]{3})|([1-9][0-9]{2})|([1-9][0-9])|([1-9]))$"

        if [[ ! $port =~ $port_regex ]]; then
            echo "ERR : Please write valid port number != $remote_port"
            exit 1
        fi
        #echo "Port $port" >>/etc/ssh/sshd_config
    fi
    if [ ! -z "$user" ]; then
        if [[ ! $user =~ ^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z0-9]+$|^[a-zA-Z0-9_.+-]+$ ]]; then
            echo 'Your user is has a unexpected char. You can write a email adress or user'
            exit 1
        else
            adduser --disabled-password $user
        fi
    fi

    if [ ! -z "$password" ]; then
        echo "$password
$password" | passwd $user
    fi

    ssh-keygen -A

fi

if [ -f "/authorized_keys" ]; then
    ssh_dir=$(eval echo ~$user/.ssh)
    mkdir -p $ssh_dir
    cat /_/authorized_keys >$ssh_dir/authorized_keys
    chown -R $user:$user $ssh_dir
    chmod 644 $ssh_dir/authorized_keys
fi
cp /etc/sshd/* /etc/ssh/

ssh_path=$(command -v sshd)
echo "Starting sshd"
$ssh_path -D -p $port
