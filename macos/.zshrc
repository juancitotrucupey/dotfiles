# Juan Florez setup, taken from https://github.com/juancitotrucupey/dotfiles/blob/main/macos/.zshrc
# Note on .zshrc, .zprofile, .zshenv: https://ss64.com/osx/syntax-profile.html.
# tl;dr we need .zshrc.
# * .zprofile is for SSH connection details only
# * .zshenv is for all shells, including non-interactive ones


# Zsh doesn't store command history unless told to do so. Source:
# https://unix.stackexchange.com/a/470707
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
# Add command to history immediately after execution, as opposed to when the
# session is closed.
setopt SHARE_HISTORY


# Oh My Zsh set up
# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-autosuggestions zsh-syntax-highlighting zsh-lazyload poetry)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='nvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch $(uname -m)"

# Set personal aliases, overriding those provided by Oh My Zsh libs,
# plugins, and themes. Aliases can be placed here, though Oh My Zsh
# users are encouraged to define aliases within a top-level file in
# the $ZSH_CUSTOM folder, with .zsh extension. Examples:
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

##### Poetry
export PATH="$HOME/.local/bin:$PATH"


##### Pyenv
export PATH="$HOME/.pyenv/bin:$PATH"
# eval "$(pyenv init - zsh)"
# eval "$(pyenv virtualenv-init -)"
# Add the following commands as triggers for loading pyenv.
lazyload pyenv -- '. $HOME/.config/macos/pyenv.sh'
# 'python' and 'python3' also depend on running 'pyenv.sh'. However, binding
# the to run 'pyenv.sh' causes problems, probably due to cyclic dependency
# between pyenv and python.




##### Custom utilities
# Extracting tars is super cumbersome.
# Source: https://askubuntu.com/a/792063
function untar() {
    local filename="$1"
    local basename="${filename%.tar.gz}"

    mkdir -p $basename
    tar -xzf $filename -C $basename
}

# Installing a python version with pyenv using optimized compile
# Source: https://github.com/pyenv/pyenv/blob/master/plugins/python-build/README.md#building-for-maximum-performance
pyenv_opt_py_instl() {
    local version=$1
    
    # Check if the version argument is provided
    if [ -z "$version" ]; then
        echo "Error: Please provide a Python version."
        return 1
    fi
    
    # Construct the command string
    local command="env PYTHON_CONFIGURE_OPTS='--enable-optimizations --with-lto' PYTHON_CFLAGS='-march=native -mtune=native' pyenv install --verbose $version"
    
    # Execute the command
    eval "$command"
}

custom_aliases=(
    # --------------- dir movement --------------
    "cdd:cd $HOME/Desktop"

    # --------------- listing dirs --------------
    "l1:tree -L 1"
    "l2:tree -L 2"
    "l3:tree -L 3"
    "l:l1"
    "ll:ls -alhF --color=auto"
    "la:ls -ah --color=auto"

    # --------------- shortcuts --------------
    "lg:lazygit"
    
    # --------------- poetry --------------
    'pt-env-act:eval "$(poetry env activate)"'
    'pt-list-all-venvs:ls "$(poetry config cache-dir)/virtualenvs"'
)

# Define aliases
for entry in "${custom_aliases[@]}"; do
    # Workaround for old bash v3 that ships with macOS.
    # Source: https://stackoverflow.com/a/4444841
    # "$alias_name = $alias_value"
    # apply the alias
    alias "${entry%%:*}"="${entry#*:}"
done