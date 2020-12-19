if is_darwin; then
    export PATH=$PATH:"$HOME/.bin:$HOME/bin:/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin:/opt/X11/bin"
    export PATH=$PATH:/usr/local/opt/go/libexec/bin
    export PATH="/usr/local/opt/node@6/bin:$PATH"
elif is_linux; then
    export PATH=$PATH:"$HOME/.bin:$HOME/bin:/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin:/opt/X11/bin:/usr/local/games:/usr/games:/snap/bin"
elif is_windows; then
    export PATH=$PATH:"$HOME/.bin:$HOME/bin:/usr/local/bin:$PATH"
fi
