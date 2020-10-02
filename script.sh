#!/bin/bash

git add . &&
git commit -a -m "update" &&
git push origin "$(git_current_branch)" &&
hexo g &&
hexo d

