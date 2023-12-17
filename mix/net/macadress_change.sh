#!/bin/bash

ifconfig | awk -F':' '/=/{print $1}' | xargs -I% sh -c 'echo "Interface: %"
    ifconfig % down
    #maccanger -a %   #--another  Set random vendor MAC of the same kind.
    macchanger -rb %  # --random --bia  When setting fully random MAC pretend to be a burned-in-address. If not used, the MAC will have the locally-administered bit set.
    #maccanger -p %   # --permanent  Reset MAC address to its original, permanent hardware value.
    ifconfig % up
    echo ""'
