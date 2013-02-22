#!/bin/bash

function usage {
    cat<<EOF>&2
Usage

    $0 [limit] [version argument]

    $0 [version argument]

Description

    Generate package log files

EOF
    exit 1
}

#
# main
#
limit=9
versarg='-r'

if [ -n "${1}" ]
then
    if [ 0 -lt "${1}" ]&&[ 999 -gt "${1}" ]
    then
        limit=${1}
        if [ -n "${2}" ]
        then
            case "${2}" in
                --r|-r)
                    versarg='-r';;
                --i|-i)
                    versarg='-i';;
                *)
                    usage ;;
            esac
        fi
    else
        case "${1}" in
            --r|-r)
                versarg='-r';;
            --i|-i)
                versarg='-i';;
            *)
                usage ;;
        esac
    fi
fi

if version=$(./version.sh ${versarg})
then
    if name=log-${version}
    then

        if svn log --limit ${limit} > ${name}.txt
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

else
    exit 1
fi
