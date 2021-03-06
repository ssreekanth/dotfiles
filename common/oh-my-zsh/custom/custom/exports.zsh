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
