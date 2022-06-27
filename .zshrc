#Aliases
alias -g l="ls -l"
alias -g la="ls -a"
alias -g lla="ls -la"

alias -g gal="gcloud auth login"
alias -g m="cd ~/Developer/kouzoh"
alias -g c="copypath"
alias -g h="history"
alias -g hi="h |grep -i"
alias -g p="pp_json"

alias -g k="kubectl"
alias -g kcx="kubectx"
alias -g kxc="kubectx -c"
alias -g kbs="kubens"
alias -g ksc="kubens -c"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/snkzt/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/snkzt/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/snkzt/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/snkzt/google-cloud-sdk/completion.zsh.inc'; fi

eval "$(direnv hook zsh)"
eval "$(nodenv init -)"

# OhMyZsh
# Plugin variable shoud be defined before initialise zsh 
plugins=(web-search copypath copybuffer dirhistory jsontools macos)
# Path to your oh-my-zsh installation.
export ZSH="$HOME/dotfiles/.oh-my-zsh"
ZSH_THEME="fwalch"
source $ZSH/oh-my-zsh.sh
plugins=(web-search)

# Kubectl functions
kubectl() {
  if ! type __start_kubectl >/dev/null 2>&1; then
    source <(command kubectl completion zsh)
    compdef k=kubectl
  fi

  command kubectl "$@"
}

_kk__ls() {
  kubectl get pods -o json | jq -r '.items[] | .metadata.name + "/" +  .spec.containers[].name'
}

_kk__pod() {
  _kk__ls | fzf
}

_kk__cpod() {
  _kk__pod | tr -d '\n'| sed 's%/% %' | pbcopy
}

_kk__exec() {
  local pod_slash_container="$(_kk__pod)"

  pod="$(echo ${pod_slash_container} | cut --delimiter='/' --fields=1)"
  container="$(echo ${pod_slash_container} | cut --delimiter='/' --fields=2)"

  # https://github.com/junegunn/fzf/issues/1849#issuecomment-581519151
  print -z -- kubectl exec -it "${pod}" --container "${container}" '-- '
}

kk() {
  if [ $# -eq 0 ]; then
    echo "Usage:\n"
    echo "    kk <cmd>"
    return 1
  fi

  local cmdname=$1; shift
  if type "_kk__$cmdname" >/dev/null 2>&1; then
    "_kk__$cmdname" "$@"
  else
    echo "Unknown command $cmdname"
    return 1
  fi
}

# GNU version of coreutil
PATH="$(brew --prefix)/opt/coreutils/libexec/gnubin:$PATH"
source /usr/local/opt/chruby/share/chruby/chruby.sh
source /usr/local/opt/chruby/share/chruby/auto.sh
chruby ruby-3.1.1

# snkzt@C02G40FXML85 mercari-api-jp 
# PS1="%n@%m %1~ %#" 
