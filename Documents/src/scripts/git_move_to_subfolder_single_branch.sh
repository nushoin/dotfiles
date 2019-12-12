#!/bin/bash
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 name_of_new_subfolder"
    exit 1
fi

echo "Moving the whole repo to subfolder $1"
NEW_GIT_SUBFOLDER=$1 git filter-branch -f --index-filter $(dirname $0)/git_move_to_subfolder_helper.sh HEAD
