alias -g l="ls -l"
alias -g la="ls -a"
alias -g lla="ls -la"

alias -g gal="gcloud auth login"

alias -g k="kubectl"
alias -g kcx="kubectx"
alias -g kxc="kubectx -c"
alias -g kbs="kubens"
alias -g ksc="kubens -c"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/snkzt/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/snkzt/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/snkzt/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/snkzt/google-cloud-sdk/completion.zsh.inc'; fi
