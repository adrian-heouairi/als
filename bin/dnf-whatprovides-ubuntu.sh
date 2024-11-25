#!/bin/bash

# apt-file list (dpkg -L also for not-installed packages) uses -F by default.

# Search for a fullpath provided by any package, installed or not (dpkg -S but also works for not-installed packages)

# -x, --regexp: Treat pattern as a (perl) regular expression. Without this option, pattern is treated as a literal string to search for. Can be rather slow.
# -F anchors as if ^$. The reciprocal which is the default for the search action is --substring-match.
# -i for case-insensitive search

# Note that apt-file update and apt update are the same.

exec apt-file -F search "$@"
