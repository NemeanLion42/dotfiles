# ~/.bashrc: executed by bash(1) for non-login shells.

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

#####################
### SHOPT OPTIONS ###
#####################

shopt -s autocd       # Typing just a path cds into it
shopt -s checkjobs    # Check for running jobs before exiting a shell
shopt -s checkwinsize # Update LINES and COLUMNS after each command
shopt -s cmdhist      # Save multiline commands as one history entry
shopt -s histappend   # Append to the history file, don't overwrite it
shopt -s lithist      # Preserve new lines in multiline history entries

#########################
### ALIAS DEFINITIONS ###
#########################

### Connect to AFS ###
# if not working, make sure openafs-client service is running
alias afs-start="kinit jwlewis && aklog -c athena.mit.edu -k ATHENA.MIT.EDU"

### Move config to .config ###
alias nvidia-settings=nvidia-settings --config="$XDG_CONFIG_HOME"/nvidia/settings

### Functions ###
start() { nohup "$1" & disown; }

### Dotfiles repo ###
alias config="/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=/$HOME"

### Alert for long commands (e.g. "sleep 10; alert") ###
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

### Colors ###
alias dir="dir --color=auto"
alias vdir="vdir --color=auto"
alias grep="grep --color=auto"
alias fgrep="fgrep --color=auto"
alias egrep="egrep --color=auto"

### ls ###
alias ls="ls -F --color=auto"
alias ll="ls -Alh --time-style=long-iso"
alias la="ls -A"

### mkdir makes parents ###
alias mkdir="mkdir -pv"

### DANGER ###
alias cp="cp -i"
alias ln="ln -i"
alias mv="mv -i"
alias rm="rm -i"

### Fun ###
alias pls='sudo "$BASH" -c "$(history -p !!)"'
#alias neofetch="neofetch --ascii $HOME/.config/neofetch/sith_empire_ascii.txt --ascii_colors 9 9 9 9 9 9"
alias neofetch="neofetch --ascii $HOME/.config/neofetch/arch_10.txt --ascii_colors 81 217 231 217 81"

### Replacement Programs ###
#alias cat="batcat"
alias v="nvim"
alias vim="nvim"

### Loopback Microphone ###
alias loop="pactl load-module module-loopback latency_msec=1"
alias unloop="pactl unload-module module-loopback"

###############
### EXPORTS ###
###############

export PATH=$PATH:~/.local/bin
export PATH=$PATH:~/.local/lib
export PATH=$PATH:~/.emacs.d/bin
export PATH=$PATH:~/.local/share/gem/ruby/3.0.0/bin
export HISTCONTROL=ignoreboth # ignore duplicates and space-started lines in history
export HISTSIZE=1000
export HISTFILESIZE=2000
export EDITOR=nvim
export TERMINAL=alacritty
export PROMPT_COMMAND='echo -ne "\033]0;${PWD/#${HOME}/\~}\007"'
export _JAVA_AWT_WM_NONREPARENTING=1
export XAUTHORITY=~/.config/Xauthority
export GVIMINIT='let $MYGVIMRC = !has("nvim") ? "$XDG_CONFIG_HOME/vim/gvimrc" : "$XDG_CONFIG_HOME/nvim/init.gvim" | so $MYGVIMRC'
export VIMINIT='let $MYVIMRC = !has("nvim") ? "$XDG_CONFIG_HOME/vim/vimrc" : "$XDG_CONFIG_HOME/nvim/init.lua" | so $MYVIMRC'
export HISTFILE="$XDG_STATE_HOME"/bash/history
export RUSTUP_HOME="$XDG_DATA_HOME"/rustup
export PYTHONSTARTUP="$XDG_CONFIG_HOME"/pythonrc
export _JAVA_OPTIONS=-Djava.util.prefs.userRoot="$XDG_CONFIG_HOME"/java
export LESSHISTFILE="$XDG_CACHE_HOME"/less/history
export GTK2_RC_FILES="$XDG_CONFIG_HOME"/gtk-2.0/gtkrc
export GRADLE_USER_HOME="$XDG_DATA_HOME"/gradle
export GNUPGHOME="$XDG_DATA_HOME"/gnupg
export CARGO_HOME="$XDG_DATA_HOME"/cargo
export ANDROID_HOME="$XDG_DATA_HOME"/android
export FrameworkPathOverride=/usr/lib/mono/4.8-api

###############
### STARTUP ###
###############

### Powerline Shell ###
function _update_ps1() {
    PS1=$(powerline-shell $?)
}

if [[ $TERM != linux && ! $PROMPT_COMMAND =~ _update_ps1 ]]; then
    PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
fi

### Neofetch ###
neofetch
