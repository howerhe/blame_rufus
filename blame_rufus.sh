#!/bin/bash

# The project description says "active branch (boolean)". But it dosen't say
# the criteria. And in the sample output, "active branch" prints the branch
# name. So I use branch name as the output for this entry.

cd "$1" # dirname may have spaces

# git not used.
if [ ! $(git rev-parse --is-inside-work-tree 2>/dev/null) ]; then
    exit 1
fi

echo -n "active branch: "
git branch --show-current

echo -n "local changes: "
if [ "$(git status --porcelain)" ]; then
    echo "True"
else
    echo "False"
fi

echo -n "recent commit: "
commit_time=$(git log -1 HEAD --pretty=format:'%at')
current_time=$(date +"%s")
WEEK_SECONDS=$((7 * 24 * 60 * 60))
if [ $((current_time - commit_time)) -le $WEEK_SECONDS ]; then
    echo "True"
else
    echo "False"
fi

echo -n "blame Rufus: "
if [ "$(git log -1 HEAD --pretty=format:'%an')" = "Rufus" ]; then
    echo "True"
else
    echo "False"
fi
