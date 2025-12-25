# Helper function to add path only if not already present
add_to_path_if_missing() {
    local dir="$1"
    if [ -d "$dir" ] && [[ ":$PATH:" != *":$dir:"* ]]; then
        export PATH="$dir:$PATH"
    fi
}

if is_darwin; then
    # Homebrew paths and user bin directories are handled by ~/.zprofile for login shells
    # For non-login shells, ensure user paths are present
    add_to_path_if_missing "$HOME/.bin"
    add_to_path_if_missing "$HOME/bin"

    # Optional paths (uncomment as needed)
    # export PATH="$PATH:/usr/local/opt/go/libexec/bin"
    # export PATH="/usr/local/opt/node@6/bin:$PATH"
    # export PATH="/usr/local/opt/gnu-tar/libexec/gnubin:$PATH"
    # export PATH="$HOME/.docker/bin:$PATH"
    # export PATH="$HOME/.cargo/bin:$PATH"
elif is_linux; then
    export PATH="$PATH:$HOME/.bin:$HOME/bin:/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin:/opt/X11/bin:/usr/local/games:/usr/games:/snap/bin"
elif is_windows; then
    export PATH="$PATH:$HOME/.bin:$HOME/bin:/usr/local/bin:$PATH"
fi

unset -f add_to_path_if_missing

# export PATH=$PATH:${GOBIN}
#export PATH="/usr/local/opt/openjdk/bin:$PATH"
#export PATH="${CLOUDSDK_HOME}/bin:$PATH"
# export PATH="/usr/local/opt/kubernetes-cli/bin:$PATH"
#export PATH="/usr/local/opt/openjdk@11/bin:$PATH"
#export PATH="/usr/local/opt/gradle@6/bin:$PATH"
# export PATH=$HOME/.local/bin:$PATH
