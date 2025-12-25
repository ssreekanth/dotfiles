if binary_exists nvim; then
    export EDITOR=nvim
elif binary_exists vim ; then
    export EDITOR=vim
elif binary_exists vi ; then
    export EDITOR=vi
fi

if [ $TERMINIX_ID ]; then
    source /etc/profile.d/vte-*.sh;
fi # Ubuntu Budgie END

if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
    source /etc/profile.d/vte-*.sh
fi

if is_openwrt; then
    export TERM=xterm-256color
fi

export GOBIN=${HOME}/go/bin
export GOPATH=${HOME}/go/

if is_darwin; then
    # export CLOUDSDK_PYTHON=/usr/local/bin/python3
fi

export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && \. "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
