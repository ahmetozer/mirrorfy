#!/bin/bash

port=${port-"22"}
user=${user-"mirrorfy"}
if [ "$auto" == "yes" ]; then
    password=${password-$(
        tr </dev/urandom -dc _A-Z-a-z-0-9 | head -c${1:-32}
        echo
    )}
fi

if [ ! -z "$port" ]; then
    port_regex="^((6553[0-5])|(655[0-2][0-9])|(65[0-4][0-9]{2})|(6[0-4][0-9]{3})|([1-5][0-9]{4})|([1-9][0-9]{3})|([1-9][0-9]{2})|([1-9][0-9])|([1-9]))$"

    if [[ ! $port =~ $port_regex ]]; then
        echo "ERR : Please write valid port number != $remote_port"
        exit 1
    fi
    #echo "Port $port" >>/etc/ssh/sshd_config
fi

if [ -f "first_run" ]; then
    set -e
    if [ ! -z "$user" ]; then
        if [[ ! $user =~ ^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z0-9]+$|^[a-zA-Z0-9_.+-]+$ ]]; then
            echo 'Your user is has a unexpected char. You can write a email adress or user'
            exit 1
        else
            if id "$user" &>/dev/null; then
                echo "user '$user' is found"
            else
                adduser --disabled-password $user
            fi
        fi
    fi

    if [ ! -z "$password" ]; then
        echo "$password
$password" | passwd $user
    fi
    set +e
    rm first_run
fi

if [ ! -f "/etc/ssh/ssh_host_dsa_key" ]; then
    ssh-keygen -A
fi

# Show credentials
if [ "$auto" == "yes" ]; then
    echo "Username $user password $password"
fi

if [ -f "/authorized_keys" ]; then
    ssh_dir=$(eval echo ~$user/.ssh)
    mkdir -p $ssh_dir
    cat /authorized_keys >$ssh_dir/authorized_keys
    chown -R $user $ssh_dir
    chmod 644 $ssh_dir/authorized_keys
fi
cp /etc/sshd/* /etc/ssh/

ssh_path=$(command -v sshd)
echo "Starting sshd"
$ssh_path -D -p $port
