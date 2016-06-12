#!/bin/bash

###############################################################################
# File:         setup.sh
# Description:  This script creates symlinks in the home directory to any
#               desired dotfiles from this directory.
###############################################################################

# Functions

create_symlinks () {

    files=$1
    special_files=$2
    src_dir=$3
    dst_dir=$4

    # move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks
    for file in $files; do
        echo "Moving ${dst_dir}/.${file} to ${old_dir}"
        mv -f ${dst_dir}/.${file} ${old_dir}
        echo "Creating symlink to ${src_dir}/${file} in ${dst_dir} directory."
        ln -s ${src_dir}/${file} ${dst_dir}/.${file}
        echo -e "\n"
    done

    for file in $special_files; do
        old_fldr=`dirname ${old_dir}/${file}`
        mkdir -p ${old_fldr}
        echo "Moving ${dst_dir}/.${file} to ${old_fldr}"
        mv -f ${dst_dir}/.${file} ${old_fldr}
        fldr=`dirname ${dst_dir}/.${file}`
        mkdir -p ${fldr}
        echo "Creating symlink to ${src_dir}/${file} in ${dst_dir} directory."
        ln -s ${src_dir}/${file} ${dst_dir}/.${file}
        echo -e "\n"
    done

}

# Variables

timestamp=$( date +"%Y-%m-%d_%H-%M-%S" )

dotfiles_repo_dir=$(pwd)                           # source location of dotfiles.
old_dir=${dotfiles_repo_dir}/.old/${timestamp}     # backup directory for old dotfiles.
user_home_dir=${HOME}                              # target location for symlinks.

# List of files/folders to symlink in homedir

common_files="aliases bashrc bin hushlogin login subversion tmux.conf tmux vimrc vim zshrc"
common_special_files=""

darwin_files="gitconfig"
darwin_special_files=""

linux_files="gitconfig i3"
linux_special_files="config/terminator config/dunst config/volumeicon"

windows_files="gitconfig minttyrc"
windows_special_files=""

echo "Creating ${user_home_dir}"
mkdir -p ${user_home_dir}
echo -e "...done\n"

# create dotfiles_old in homedir
echo "Creating ${old_dir} for backup of any existing dotfiles from ${user_home_dir}"
mkdir -p ${old_dir}
echo -e "...done\n"

create_symlinks "${common_files}" "${common_special_files}" "${dotfiles_repo_dir}/common" "${user_home_dir}"

if [[ "$OSTYPE" == "linux-gnu" ]]; then
    create_symlinks "${linux_files}" "${linux_special_files}" "${dotfiles_repo_dir}/linux" "${user_home_dir}"
elif [[ "$OSTYPE" == "cygwin" || "$OSTYPE" == "msys" || "$OSTYPE" == "win32" ]]; then
    create_symlinks "${windows_files}" "${windows_special_files}" "${dotfiles_repo_dir}/windows" "${user_home_dir}"
elif [[ "$OSTYPE" == "darwin"* ]]; then
    create_symlinks "${darwin_files}" "${darwin_special_files}" "${dotfiles_repo_dir}/darwin" "${user_home_dir}"
fi

# setup Nvim (neovim) config by linking to vim config files.
mkdir -p ${XDG_CONFIG_HOME:=${user_home_dir}/.config}
ln -nsf ${dotfiles_repo_dir}/common/vim $XDG_CONFIG_HOME/nvim
ln -sf ${dotfiles_repo_dir}/common/vimrc $XDG_CONFIG_HOME/nvim/init.vim
