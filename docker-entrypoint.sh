#!/bin/bash

if [[ -z "$USERNAME" ]]; then
    echo "Must provide USERNAME in environment" 1>&2
    exit 1
fi

if [[ -z "$PASSWORD" ]]; then
    echo "Must provide PASSWORD in environment" 1>&2
    exit 1
fi

useradd $USERNAME && echo $USERNAME:$PASSWORD | chpasswd
echo $USERNAME:$PASSWORD | chpasswd

sockd -N 4