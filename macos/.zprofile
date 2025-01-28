# Add Visual Studio Code (code)
export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"

eval "$(/opt/homebrew/bin/brew shellenv)"

# lazyload
# TODO: I do not want to load pyenv by deafult, check if this commands in the
# .zprofile overwrite or interfire with the ones in .zshrc
source $HOME/.local/share/jf-apps/zsh-lazyload/zsh-lazyload.zsh

# Pyenv
export PATH="$HOME/.pyenv/bin:$PATH"
# Add the following commands as triggers for loading pyenv.
lazyload pyenv -- '. $HOME/.config/macos/pyenv.sh'
# 'python' and 'python3' also depend on running 'pyenv.sh'. However, binding
# the to run 'pyenv.sh' causes problems, probably due to cyclic dependency
# between pyenv and python.

# Poetry
export PATH="$HOME/.local/bin:$PATH"