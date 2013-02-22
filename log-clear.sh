#!/bin/bash

function usage {
    cat<<EOF>&2
Usage

    $0 [version argument]

Description

    Delete package log files

EOF
    exit 1
}

#
# main
#
versarg='-r'

if [ -n "${1}" ]
then
    case "${1}" in
        --r|-r)
            versarg='-r';;
        --i|-i)
            versarg='-i';;
        *)
            usage ;;
    esac
fi

if version=$(./version.sh ${versarg})
then
    if name=log-${version}
    then
        #
        # Discard 1>svn "D file"
        # because it's confusing with the following 'svn st'
        #
        if 1>/dev/null 2>/dev/null svn delete ${name}.{txt,html}
        then
            svn st
        else
            cat<<EOF>&2
Error in '2>/dev/null svn delete ${name}.{txt,html}'
EOF
            exit 1
        fi
    else
        cat<<EOF>&2
Error in 'name=log-\$(./version.sh)'
EOF
        exit 1
    fi

else
    exit 1
fi
