#!/usr/bin/env bash

if [[ "$skip_tests" != "true" ]]; then
    set -x

    # Working directory must be dev/ (since this is where package.json is for npm test)
    # Make sure to cd - before exiting
    cd "$(dirname $0)/../dev"

    if [[ -z "$CODE_TESTS_WORKSPACE" ]]; then
        export CODE_TESTS_WORKSPACE="${HOME}/microclimate-workspace/"
    fi

    # Move node to somewhere that can be found on root user's PATH
    # https://stackoverflow.com/a/29903645/
    n=$(which node)
    n=${n%/bin/node}
    chmod -R 755 $n/bin/*
    sudo cp -r $n/{bin,lib,share} /usr/local

    sudo -E $(which npm) test --verbose
    result=$?

    cd -

    exit $result
else
    echo "skip_tests is true, skipping tests";
fi
