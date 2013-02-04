
Overview

  Shell scripts copy into svn project top directory to create
  log-VERSION.txt and log-VERSION.html from the subversion log.

  Requires a script named "./version.sh" that echos a VERSION string
  containing no spaces or hyphens.

Usage

  ./log-create.sh

      Create log-VERSION.txt and log-VERSION.html

  ./log-clear.sh

      Drop log-VERSION.txt and log-VERSION.html
