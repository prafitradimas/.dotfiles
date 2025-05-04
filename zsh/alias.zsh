alias vim="nvim"

if [ -x "$(command -v minikube)" ]; then
    alias minikubectl="minikube kubectl --"
fi
