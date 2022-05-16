#!/usr/bin/env bash

gitlab_token=$1

if [ -f "$gitlab_token" ]; then
    echo "Using GitLab token stored in $gitlab_token."
    gitlab_token=$(< gitlab_token)
else 
    echo "Using supplied GitLab token"
fi

[ -z "$gitlab_token" ] && printf "No GitLab token supplied or GitLab token is empty. \nReading from public ARCs only.\n"