#!/bin/bash

function usage {
    cat<<EOF
Usage

   $0 (-r|-i)

   $0 (--r|--i)

Objective

   Print version number on output, or exit with error code 1.

Operation

   Query user for input, or print the latest subversion revision.

Argument string

   -r            Print the latest subversion revision number to stdout.

   -i            Ask user for input, echo input to stdout.

Return codes

    0            Version on stdout.

    1            Missing version from output.

    2            Help text.  Return code two.  ASCII on stderr.
   
EOF
    exit 2
}
function svn_rev {
    tmpf=/tmp/$(basename $0).$$
    #
    # Output latest revision number
    #
    2>${tmpf} svn -v st | grep '[0-9][0-9].* .*[0-9][0-9]' | awk '{print $1 ":" $4 }' | sort | tail -1 | sed 's/:.*//'
    #
    # 'svn -v st' returns 0 when not in a subversion repository
    #
    if [ -f ${tmpf} ]
    then
        err=$(cat ${tmpf} )
        rm -f ${tmpf}
    else
        unset err
    fi
    #
    if [ -n "${err}" ]
    then
        return 1
    else
        return 0
    fi
}

if [ -n "${1}" ]
then
    case "${1}" in
        --r|-r)
            if svn_rev
            then
                exit 0
            else
                exit 1
            fi ;;
        --i|-i)
            while read -p "Enter version> " version
            do
                if [ -n "${version}" ]
                then
                    read -p "Accept version '${version}'? [Yn] " accept

                    if [ -n "${accept}" ]
                    then
                        case "${accept}" in
                            y|Y)
                                echo ${version}
                                exit 0 ;;
                        esac
                    else
                        echo ${version}
                        exit 0
                    fi
                fi
            done
            exit 1 ;;
        *)
            usage ;;
    esac
else
    usage
fi

