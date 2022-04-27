#!/bin/sh

for file in .github/workflows/dockerimage.yml Dockerfile README.md
do
  sed -i s/[0-9]\\+\\.[0-9]\\+\\.[0-9]\\+/$1/g "$file"
done
