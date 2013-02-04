
Overview

  Shell scripts copy into svn project top directory to create
  log-VERSION.txt and log-VERSION.html from the subversion log.

  Requires a script named "./version.sh" that echos a VERSION string
  containing no spaces or hyphens.

Usage

  ./log-create.sh [limit]

      Create log-VERSION.txt and log-VERSION.html

      Optionally define the number of svn revisions to log with the
      argument 'limit'

  ./log-clear.sh

      Drop log-VERSION.txt and log-VERSION.html
