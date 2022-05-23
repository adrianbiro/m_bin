#!/bin/bash
ls *.gz | parallel 'mkdir {.} && cd {.} && tar xzf ../{}'

