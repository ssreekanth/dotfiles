if is_darwin; then
    export PATH="$HOME/.bin:$HOME/bin:/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin:/opt/X11/bin"
elif is_linux; then
    export PATH="$HOME/.bin:$HOME/bin:/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin:/opt/X11/bin:/usr/local/games:/usr/games:/snap/bin"
elif is_windows; then
    export PATH="$HOME/.bin:$HOME/bin:/usr/local/bin:$PATH"
fi
