# Commenting here, as we already do 'source ~/.aliases' in ~/.zshrc
# [ -f ${HOME}/.aliases ] && . ${HOME}/.aliases

[ -f ${HOME}/.aliases_work ] && . ${HOME}/.aliases_work

[ -f ${HOME}/.kubech/kubech ] && export KUBECH_NAMESPACE_CHECK=label && . ${HOME}/.kubech/kubech

[[ ! -f ~/.kubecm ]] || source ~/.kubecm
