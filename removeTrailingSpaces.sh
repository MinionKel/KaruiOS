#!/bin/bash
# removeTrailingSpaces

unamestr=$(uname)
if [[ "$unamestr" == 'Linux' ]]; then
    echo "On Linux"
    find . -name "*.c" -type f -print0 | xargs -0 sed -i 's/[[:space:]]*$//'
    find . -name "*.h" -type f -print0 | xargs -0 sed -i 's/[[:space:]]*$//'
    find . -name "*.asm" -type f -print0 | xargs -0 sed -i 's/[[:space:]]*$//'
    find . -name "Makefile" -type f -print0 | xargs -0 sed -i 's/[[:space:]]*$//'
elif [[ "$unamestr" == 'Darwin' ]]; then
    echo "On Mac"
    find . -type f -name '*.c' -exec sed -i '' -e's/[[:space:]]*$//' {} \+
    find . -type f -name '*.h' -exec sed -i '' -e's/[[:space:]]*$//' {} \+
    find . -type f -name '*.asm' -exec sed -i '' -e's/[[:space:]]*$//' {} \+
    find . -type f -name 'Makefile' -exec sed -i '' -e's/[[:space:]]*$//' {} \+
fi

