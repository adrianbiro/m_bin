#!/bin/bash
device="${1:?${0##*/} </dev/sdb1>}"
udisksctl unmount --block-device "${device}"
udisksctl power-off --block-device "${device}"
