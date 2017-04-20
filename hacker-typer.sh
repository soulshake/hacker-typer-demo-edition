#!/bin/bash

echo -n '$ '

TEXT="whois mushify.xyz
docker ps
whoami
"

#while IFS= read -r line; do
    # do something with "$line" <-- quoted almost always
#done < file
# note: might be better to suppress all typed characters
# http://stackoverflow.com/questions/10987039/prevent-typed-characters-from-being-displayed-like-disabling-echo-attribute-i
IFS="
"
for line in $TEXT; do
    len=${#line}
    for i in $(seq 0 $len); do
        read -s -n 1
        echo -n -e "\r"
        echo -n "\$ ${line[@]:0:i}"
    done

    # we've printed the full command; stop and wait for enter (i.e. "")
    while true; do
        read -s -n 1 keystroke
        if [[ $keystroke == "" ]]; then
            echo && eval "$line"
            break
        fi
    done

    echo -n "\$ "
    continue
done
