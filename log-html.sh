#!/bin/bash
# 2013-02-01 12:20:36 -0500 (Fri, 01 Feb 2013)

function usage {
    cat<<EOF
Usage

    cat log.txt | $0 log.txt

Description

    Produces log.html

EOF
    exit 1
}
function head {
    cat<<EOF  >"${1}"
<html>
 <head>
  <title>$(basename ${1} .html)</title>
 </head>
 <body bgcolor="#FFF">
  <table border="0" width="100%">
EOF
}
function body {
    cat<<EOF >>"${1}"
   <tr>
    <td>${version}</td>
    <td>${author}</td>
    <td>${dow}, ${date} ${time}</td>
    <td>${msg}</td>
   </tr>
EOF
}
function tail {
    cat<<EOF >>"${1}"
  </table>
 </body>
</html>
EOF
}

if [ -n "${1}" ]&&[ -f "${1}" ]
then
    inf="${1}"
    ouf="$(basename "${1}" .txt).html"

    count=0
    declare -a finary

    head "${ouf}"

    while read -a finary
    do
        case "${finary[0]}" in
            -----------------*);;
            r[0-9]*)
                version=${finary[0]}
                author=${finary[2]}
                date=${finary[4]}
                time=${finary[5]}
                tz=${finary[6]}
                dow=$(echo ${finary[7]} | sed 's/(//; s/,//;')
                dom=${finary[8]}
                month=${finary[9]}
                year=$(echo ${finary[10]} | sed 's/)//')
                lines=${finary[12]}
                count=0
                ;;
            "")
                ;;
            *)
                if [ 0 -eq ${count} ]
                then
                    msg="${finary[@]}"

                elif [ $count -lt $lines ]
                then
                    msg="${msg} ${finary[@]}"
                fi

                count=$(( $count + 1 ))

                if [ $count -eq $lines ]
                then
                    body "${ouf}"
                fi
                ;;
        esac
    done

    tail "${ouf}"
else
    usage
fi

