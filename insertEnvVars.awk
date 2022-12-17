#!/usr/bin/awk -f
BEGIN{
    FS="=";
    while ("env" | getline) {
        if(/^(WSL|XDG)_.*$/){
            printf("-e %s\n", $1)
        }
    }
}

# $ docker run -it $(./insertEnvVars.awk) --rm alpine env
# -e XDG_SESSION_TYPE
# -e XDG_SEAT_PATH
# -e XDG_SESSION_CLASS
# idea from
#env | grep -E "^(WSL|XDG)_.*$" | cut -d "=" -f 1 | sed "s/^/-e /"
