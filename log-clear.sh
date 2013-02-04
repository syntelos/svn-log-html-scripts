#!/bin/bash

function usage {
    cat<<EOF>&2
Usage

    $0

Description

    Delete package log files

EOF
    exit 1
}

#
# main
#

if [ -n "${1}" ]
then
    usage
else
    if name=log-$(./version.sh)
    then
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
fi

