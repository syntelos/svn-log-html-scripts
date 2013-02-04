#!/bin/bash

function usage {
    cat<<EOF>&2
Usage

    $0 [limit]

Description

    Generate package log files

EOF
    exit 1
}

#
# main
#
limit=9
if [ -n "${1}" ]
then
    if [ 0 -lt "${1}" ]&&[ 999 -gt "${1}" ]
    then
        limit=${1}
    else
        usage
    fi
fi

if name=log-$(./version.sh)
then

    if svn log --limit 9 > ${name}.txt
    then
        if cat ${name}.txt | ./log-html.sh ${name}.txt
        then
            if ./log-add.sh ${name}.{txt,html}
            then
                svn st
            else
                cat<<EOF>&2
Error in './log-add.sh ${name}.{txt,html}'
EOF
                exit 1
            fi
        else
            cat<<EOF>&2
Error in 'cat ${name}.txt | ./log-html.sh ${name}.txt'
EOF
            exit 1
        fi
    else
        cat<<EOF>&2
Error in 'svn log --limit 9 > ${name}.txt'
EOF
        exit 1
    fi
else
    cat<<EOF>&2
Error in 'name=log-\$(./version.sh)'
EOF
    exit 1
fi
