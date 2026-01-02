# Date format for history timestamps
set -Ux HIST_STAMPS "dd/mm/yyyy"

set -U fish_user_paths /opt/homebrew/bin /opt/homebrew/sbin /Applications/Neovide.app/Contents/MacOS $fish_user_paths

# Aliases
alias ipython "ipython --TerminalInteractiveShell.editing_mode=vi --no-autoindent"

set -Ux NODE_OPTIONS "--experimental-repl-await"
alias mongo "/Applications/mongosh"

alias run "./run.sh"
alias worker "./worker.sh"
alias prod-run "./prod-run.sh"

alias cron-machine "qssh ubuntu@i-0744034ec5da1fd56"
alias ec2-machine "qssh ec2-user@i-0ea4e601cb7e55b7d"
alias analytics-machine "qssh ubuntu@i-089a68b6b136d7dbf"
alias content-crons "qssh ubuntu@i-03acca3366424dc92"

alias emacs "open -a /Applications/Emacs.app"
alias e "/Applications/Emacs.app/Contents/MacOS/bin/emacsclient"

# Java Path
set -Ux PATH "/Library/Java/JavaVirtualMachines/temurin-21.jdk/Contents/Home/bin" $PATH
set -Ux PATH "/Users/cgv/.local/bin" $PATH

# Neovide as Vim
# alias vim "neovide"
# alias vim nvim
function vim
    # If we're already inside Neovide, ask Neovim to open a tab
    if set -q NVIM
        command nvim --server $NVIM --remote-tab $argv
    else
        # Outside Neovide, launch Neovide normally
        command neovide $argv
    end
end

function sync_nvim_cwd --on-variable PWD
    if set -q NVIM
        command nvim --server $NVIM  --remote-expr "execute('cd ' . fnameescape('$PWD'))"
    end
end

# Enable Vi mode
fish_vi_key_bindings

# Go Path
set -Ux PATH (go env GOPATH)/bin $PATH

# Add Neovide to PATH
set -Ux PATH "/Applications/Neovide.app/Contents/MacOS" $PATH

# Use `fnm` instead of `nvm`
fnm env --use-on-cd --shell fish | source
alias nvm "fnm"
fnm default 18

set -U fish_user_paths ~/go/bin $fish_user_paths
fzf --fish | source

# Created by `pipx` on 2025-05-07 04:49:39
set PATH $PATH /Users/cgv/.local/bin

fnm env | source
# export MANPAGER="col -b | vim -MR - "

# ${UserConfigDir}/fish/config.fish
set -Ux CARAPACE_BRIDGES 'zsh,fish,bash,inshellisense' # optional
carapace _carapace | source
bind \ck 'clear; commandline -f repaint'

set -Ux LESS -FRSX
