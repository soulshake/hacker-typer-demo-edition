#!/bin/bash

TEXT=$(cat commands.txt)

# Set the internal field separator to a newline for file parsing
IFS="
"

# Don't output any typed characters to the terminal
stty -echo

for line in $TEXT; do
    # Print a fake PS1
    echo -n '$ '

    # Print the command one character at a time, regardless of which key the user actually typed
    len=${#line}
    for i in $(seq 0 $len); do
        # Read a single character (without displaying it)
        read -s -n 1
        # Echo a carriage return to delete the whole line
        echo -n -e "\r"
        # Reprint with one additional character
        echo -n "\$ ${line[@]:0:i}"
    done

    # We've now printed the full command; stop and wait for enter (i.e. "")
    while true; do
        read -s -n 1 keystroke
        if [[ $keystroke == "" ]]; then
            echo && eval "$line"
            break
        fi
    done
done

# Restore the terminal
stty echo
