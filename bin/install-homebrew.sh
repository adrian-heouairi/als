#!/bin/bash

type brew &> /dev/null && { echo "$0: brew is already installed"; exit 0; }

sudo apt install -y build-essential procps curl file git

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

echo -e '\nulimit -Sn "$(ulimit -Hn)"; eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> ~/.bashrc # Purposefully redundant with unit-env.sh

echo "$0: The 'brew' command will be available in new Bash instances"
#echo "WARNING: $0: Right after install you must run 'eval \"$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)\"' to use brew in the bash you're running this script from (new shells will have it automatically). Furthermore, note that before any manual 'brew install', you might need to run 'ulimit -Sn \"$(ulimit -Hn)\"'."
