# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# ZSH_THEME="robbyrussell"
ZSH_THEME="powerlevel10k/powerlevel10k"

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

# systemd editor
export SYSTEMD_EDITOR=vim

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git tmux asdf docker zsh-autosuggestions zsh-syntax-highlighting fast-syntax-highlighting zsh-autocomplete)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

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
#
#

# export V2RAYA_ADDRESS=0.0.0.0:2018
#export HTTP_PROXY=http://172.28.128.1:20171
#export HTTPS_PROXY=http://172.28.128.1:20171
source $HOME/.private_keys.zshrc
export HTTP_PROXY="http://127.0.0.1:20171"
export HTTPS_PROXY="http://127.0.0.1:20171"
export NO_PROXY="172.27.74.16,localhost,127.0.0.1"
export no_proxy="172.27.74.16,localhost,127.0.0.1"
#export http_proxy=http://127.0.0.1:20171
#export https_proxy=http://127.0.0.1:20171
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
export PATH="$PATH:$HOME/.config/emacs/bin"
export PATH=/usr/local/cuda/bin${PATH:+:${PATH}}
export PATH="$PATH:/usr/local/go/bin"
export PATH="$PATH:$HOME/go/bin:${ASDF_DATA_DIR}/shims"
# append completions to fpath
fpath=(${ASDF_DATA_DIR:-$HOME/.asdf}/completions $fpath)
# initialise completions with ZSH's compinit
autoload -Uz compinit && compinit

# Created by `pipx` on 2025-03-19 02:27:42
export PATH="$PATH:/home/x/.local/bin"

# Created by `pipx` on 2025-03-19 02:39:33
export PATH="$PATH:/usr/local/bin"
# add snap root
export PATH="$PATH:/snap/bin"
# add go path
export PATH="$PATH:/usr/local/go/bin"

# rust
export PATH="$PATH:$HOME/.cargo/bin"
. "$HOME/.cargo/env"           

export PYENV_ROOT="/d/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"

# Some GUI-launched shells inherit stale pyenv/conda markers from the desktop
# session. Clear them so Powerlevel10k reflects the actual current shell state.
if [[ ${PYENV_VERSION-} == system ]]; then
  unset PYENV_VERSION
fi
if [[ ${CONDA_SHLVL-0} == 0 ]]; then
  unset CONDA_DEFAULT_ENV CONDA_PREFIX CONDA_PREFIX_1 CONDA_PREFIX_2
  unset CONDA_PROMPT_MODIFIER PYENV_VIRTUAL_ENV VIRTUAL_ENV VIRTUAL_ENV_PROMPT
fi

eval "$(pyenv init - zsh)"
eval "$(pyenv virtualenv-init -)"
# source ollama model path
export OLLAMA_MODELS="/v/.ollama/models"

export ASDF_DATA_DIR="/d/.asdf"
export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"

# sourcing ros2
source /opt/ros/jazzy/setup.zsh
export WEBOTS_HOME=/usr/local/webots

## >>> conda initialize >>>
## !! Contents within this block are managed by 'conda init' !!
#__conda_setup="$('/home/x/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
#if [ $? -eq 0 ]; then
#    eval "$__conda_setup"
#else
#    if [ -f "/home/x/anaconda3/etc/profile.d/conda.sh" ]; then
#        . "/home/x/anaconda3/etc/profile.d/conda.sh"
#    else
#        export PATH="/home/x/anaconda3/bin:$PATH"
#    fi
#fi
#unset __conda_setup
## <<< conda initialize <<<

# start input leap 
#input-leapc --display :0 --debug INFO -f 172.27.74.56 &



# To customize prompt, run `p10k configure` or edit ~/dotfiles/.p10k.zsh.
[[ ! -f ~/dotfiles/.p10k.zsh ]] || source ~/dotfiles/.p10k.zsh


# The next line updates PATH for the Google Cloud SDK.
if [ -f '/d/programs/google-cloud-sdk/path.zsh.inc' ]; then . '/d/programs/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/d/programs/google-cloud-sdk/completion.zsh.inc' ]; then . '/d/programs/google-cloud-sdk/completion.zsh.inc'; fi

PATH="/home/x/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/home/x/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/home/x/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/home/x/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/x/perl5"; export PERL_MM_OPT;

# >>> juliaup initialize >>>

# !! Contents within this block are managed by juliaup !!

path=('/home/x/.juliaup/bin' $path)
export PATH

# <<< juliaup initialize <<<


# eval "$(ssh-agent -s)"
export GUROBI_HOME="/d/devel/opt/gurobi1203"
export PATH="$PATH:/d/devel/opt/gurobi1203/bin"
export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/d/devel/opt/gurobi1203/lib"
#export MUJOCO_DIR="/d/devel/mujoco/dist"
#export PATH="$PATH:/d/devel/mujoco/dist/bin"
#export MUJOCO_PY_MUJOCO_PATH=$MUJOCO_DIR
#export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$MUJOCO_DIR/bin"
#export LD_LIBRARY_PATH="$MUJOCO_DIR/lib:$LD_LIBRARY_PATH"
#
#source /opt/ros/jazzy/setup.zsh
#
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
eval "$(zoxide init zsh)"
eval "$(uv generate-shell-completion zsh)"

export UV_CACHE_DIR="/v/.cache/uv"


# Function to update the tmux session environment with the current shell's environment
update_tmux_env() {
  if [ -n "$TMUX" ]; then
    # Get all user-defined variables from the current shell
    vars=($(export | cut -d "=" -f 1 | grep -v "^_"))
    for var in "${vars[@]}"; do
      # Set each variable in the tmux session environment
      tmux set-environment -g "$var" "$(printenv "$var")"
    done
  fi
}

# Add the function to the precmd_functions array
autoload -U add-zsh-hook
add-zsh-hook precmd update_tmux_env
export DISPLAY=:1

export CYCLONEDDS_HOME="/d/devel/misc/cyclonedds/install"
export UV_EXTRA_INDEX_URL="https://pypi.nvidia.com"

export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


# Added by Antigravity CLI installer
export PATH="/home/x/.local/bin:$PATH"
