#!/bin/bash
#just whole words match
grep \
    --dereference-recursive \
    --extended-regexp \
    --ignore-case \
    --word-regexp \
    --exclude-dir={.git,venv,log,asset,cache,css} \
    '(auth|authentication|authorization|bearer|secret|token|pass|password|username)' \
    .

# include partion match
grep \
    --dereference-recursive \
    --extended-regexp \
    --ignore-case \
    --exclude-dir={.git,venv,log,asset,cache,css} \
    '(auth|authentication|authorization|bearer|secret|token|pass|password|username)' \
    .

# Connection string
#DATABASE_URL=postgres://{user}:{password}@{hostname}:{port}/{database-name}
grep \
    --dereference-recursive \
    --extended-regexp \
    --ignore-case \
    --exclude-dir={.git,venv,log,asset,cache,css} \
    '\w+://\w+:\w+@\w+:[0-9]+/\w+' \
    .
