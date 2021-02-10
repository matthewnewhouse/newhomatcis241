#!/usr/bin/env bash

mkdir $1

cd $1

git init 

mkdir bin

mkdir include

mkdir lib

mkdir share

mkdir man

mkdir info

echo $1 >> README.md

touch .gitignore

git add *

git commit -m "Create initial structure."
