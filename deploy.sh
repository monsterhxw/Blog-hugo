#!/bin/bash

echo "Deleting old publication"

rm -rf public

# content update
hugo

# 更新到 blog-hugo repo
echo "deploy"

git add -A

git commit -m "update blog"

git push -u origin master
