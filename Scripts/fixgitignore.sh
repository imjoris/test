#!/bin/bash

# git add -A
# git commit -m "about to fix  gitignore"

git rm -r --cached .
git add .
git commit -m "fixed untracked files"
