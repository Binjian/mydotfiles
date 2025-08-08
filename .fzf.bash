# Setup fzf
# ---------
if [[ ! "$PATH" == */home/x/.fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/home/x/.fzf/bin"
fi

eval "$(fzf --bash)"
