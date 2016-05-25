#!/bin/bash

############################
# dotfiles-setup.h
# This script creates symlinks from the home directory to any desired dotfiles in ~/.dotfiles
############################

# Variables

timestamp=$( date +"%Y-%m-%d_%H-%M-%S" )

src_dir=$(pwd)                           # dotfiles directory
old_dir=${src_dir}/.old/${timestamp}     # old dotfiles backup directory
dst_dir=${HOME}

# List of files/folders to symlink in homedir

common_files="aliases bashrc bin gitconfig hushlogin login subversion tmux.conf tmux vimrc vim zshrc"
common_special_files=""

linux_files="i3"
linux_special_files="config/terminator config/dunst config/volumeicon"

windows_files="minttyrc"
windows_special_files=""

if [[ "$OSTYPE" == "linux-gnu" ]]; then
    files="${common_files} ${linux_files}"
    special_files="${common_special_files} ${linux_special_files}"
elif [[ "$OSTYPE" == "cygwin" || "$OSTYPE" == "msys" || "$OSTYPE" == "win32" ]]; then
    files="${common_files} ${windows_files}"
    special_files="${common_special_files} ${windows_special_files}"
else
    files="${common_files}"
    special_files="${common_special_files}"
fi

##########

echo "Creating ${dst_dir}"
mkdir -p ${dst_dir}
echo -e "...done\n"

# create dotfiles_old in homedir
echo "Creating ${old_dir} for backup of any existing dotfiles from ${dst_dir}"
mkdir -p ${old_dir}
echo -e "...done\n"

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks
for file in $files; do
    echo "Moving ${dst_dir}/.${file} to ${old_dir}"
    mv -f ${dst_dir}/.${file} ${old_dir}
    echo "Creating symlink to ${src_dir}/${file} in home directory."
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
    echo "Creating symlink to ${src_dir}/${file} in home directory."
    ln -s ${src_dir}/${file} ${dst_dir}/.${file}
    echo -e "\n"
done

# setup Nvim (neovim) config by linking to vim config files.
mkdir -p ${XDG_CONFIG_HOME:=${dst_dir}/.config}
ln -nsf ${src_dir}/vim $XDG_CONFIG_HOME/nvim
ln -sf ${src_dir}/vimrc $XDG_CONFIG_HOME/nvim/init.vim
