#!/bin/sh
mount.ntfs -o rw,nodev,nosuid,uid="$(id -u)",gid="$(id -g)",windows_names,uhelper=udisks2 "${@}"

