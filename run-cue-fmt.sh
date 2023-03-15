#!/usr/bin/env bash

set -eu -o pipefail

cue_fmt () {
    STAGED_CUE_FILES=$(git diff --cached --name-only | grep ".cue$")
    if [[ "$STAGED_CUE_FILES" = "" ]]; then
        exit 0
    fi

    for cuefile in $(echo $STAGED_CUE_FILES); do cue fmt $cuefile; done
    if git diff --name-only | grep ".cue$"; then
        echo "formatted cue files. Stage these changes as well"
    exit 1
    fi
}

if ! command -v cue &> /dev/null ; then
    echo "cue not installed or available in the PATH" >&2
    echo "please check https://cuelang.org/docs/install" >&2
    exit 1
fi

cue_fmt