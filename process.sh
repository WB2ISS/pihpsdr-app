#! /bin/bash
cat VMLibraries7 | while read LINE; do
    echo \'$LINE\' \\
done
