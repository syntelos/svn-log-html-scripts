#!/bin/bash

function usage {
    cat<<EOF
Usage

   $0 (-c)

   $0 (--c)

Objective

   Copy shell (*.sh) files from a non working directory containing
   this script into the caller's working directory.

Operation

   Copy files, with the following listing on stdout.

   "I file"  Ignoring existing file of the same name.

   "C file"  Copying file into this name.

Argument string

   -c            Copy files

Return codes

    0            Copy files

    1            Local copy error

    2            Help text.  Return code two.  ASCII on stderr.
   
EOF
    exit 2
}

function copier {
    src=$(dirname $0 )
    if [ -n "${src}" ]&&[ '.' != "${src}" ]&&[ -d "${src}" ]
    then
        for srcf in "${src}"/*.sh
        do
            tgtf=$(basename "${srcf}")
            if [ -f "${tgtf}" ]
            then
                echo "I ${tgtf}"
            elif cp -p "${srcf}" "${tgtf}"
            then
                echo "C ${tgtf}"
            else
                echo "X ${tgtf}"
            fi
        done
        return 0
    else
        return 1
    fi
}

if [ -n "${1}" ]
then
    case "${1}" in
        --c|-c)
            if copier
            then
                exit 0
            else
                exit 1
            fi ;;
        *)
            usage ;;
    esac
else
    usage
fi

