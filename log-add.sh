#!/bin/bash

for each in $*
do
  if 2>/dev/null svn add $each
  then
    case $each in
    *.txt)
      svn ps 'svn:mime-type' 'text/plain' ${each}
      ;;
    *.html)
      svn ps 'svn:mime-type' 'text/html' ${each}
      ;;
    esac
  else
    cat<<EOF>&2
Error in 'svn add $each'
EOF
    exit 1
  fi
done
