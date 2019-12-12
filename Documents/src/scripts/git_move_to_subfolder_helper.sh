#!/bin/bash

# The environment variable $NEW_GIT_SUBFOLDER should contain the name of the
# new subfolder into which the whole repo should be moved.

git ls-files -s | sed $'s-\t\"*-&'$NEW_GIT_SUBFOLDER'/-' | \
  GIT_INDEX_FILE=$GIT_INDEX_FILE.new git update-index --index-info && \
  mv "$GIT_INDEX_FILE.new" "$GIT_INDEX_FILE"
