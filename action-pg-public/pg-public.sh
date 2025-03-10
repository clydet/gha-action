#!/bin/bash
FILE_MATCH='liquibase.properties'
UPDATE_MATCH='defaultSchemaName:public'

# Use git diff to get the changes and filter the filenames containing 'defaultSchemaName:public'
changed_files=$(git diff --name-only --diff-filter=ACMRTUXB -- "${FILE_MATCH}" | xargs grep -l "${UPDATE_MATCH}")

# Iterate through the changed files and find the lines with the specific string
for file in $changed_files; do
    echo "${UPDATE_MATCH} found in $file:"
    git diff --unified=0 -- $file | grep -n "${UPDATE_MATCH}"
done

if [ -n "$changed_files" ]; then
    echo "The above files contain the string ${UPDATE_MATCH}."
    echo "The use of 'public' as the default schema is not allowed."
    exit 1
fi
