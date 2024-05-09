#!/bin/bash

## Ad hoc
 
#https://kubernetes.io/docs/tasks/manage-kubernetes-objects/update-api-object-kubectl-patch/
#kubectl patch cronjobs <job-name> -p '{"spec" : {"suspend" : true }}'

## In reto to ArgoCD

# disable
find . -name '*cronjob.yaml' -type f -exec sed -i 's/suspend: false$/suspend: true/g' {} \;
# enable
find . -name '*cronjob.yaml' -type f -exec sed -i 's/suspend: true$/suspend: false/g' {} \;