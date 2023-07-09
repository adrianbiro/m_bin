#!/usr/bin/awk -f
BEGIN{
    #FS="=";
    while ("env" | getline) {
        if(/^(WSL|XDG)_.*$/){
            printf("-e %s\n", $0)
        }
    }
}

# $ docker run -it $(./,insertEnvVars.awk) --rm alpine env
# -e XDG_SESSION_ID=c2
# -e XDG_SESSION_PATH=/org/freedesktop/DisplayManager/Session0
# -e XDG_RUNTIME_DIR=/run/user/1000
# idea from
