if binary_exists nvim; then
    export EDITOR=nvim
elif binary_exists vim ; then
    export EDITOR=vim
elif binary_exists vi ; then
    export EDITOR=vi
fi
