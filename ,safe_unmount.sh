#!/bin/bash
device="${1:?${0##*/} </dev/sdb1>}"
sudo udisksctl unmount --block-device "${device}"
sudo udisksctl power-off --block-device "${device}"
