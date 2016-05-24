#!/bin/bash

############################
# dotfiles-setup.h
# This script creates symlinks from the home directory to any desired dotfiles in ~/.dotfiles
############################

########## Variables

timestamp=$( date +"%Y-%m-%d_%H-%M-%S" )

dir=~/dotfiles                    # dotfiles directory
olddir=${dir}/.old/${timestamp}    # old dotfiles backup directory

# list of files/folders to symlink in homedir

common_files="aliases bashrc bin gitconfig hushlogin login subversion tmux.conf tmux vimrc vim zshrc"
common_special_files="ssh/config"

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

echo "Remove existing $olddir in ~"
rm -rf $olddir

# create dotfiles_old in homedir
echo "Creating $olddir for backup of any existing dotfiles in ~"
mkdir -p $olddir
echo -e "...done\n"

# change to the dotfiles directory
#echo "Changing to the $dir directory"
#cd $dir
#echo -e "...done\n"

#mkdir -p ~/.config

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks 
for file in $files; do
    echo "Moving ~/.$file to $olddir"
    mv -f ~/.$file $olddir
    echo "Creating symlink to $dir/$file in home directory."
    ln -s $dir/$file ~/.$file
    echo -e "\n"
done

for file in $special_files; do
    oldfldr=`dirname $olddir/$file`
    mkdir -p $oldfldr
    echo "Moving ~/.$file to $oldfldr"
    mv -f ~/.$file $oldfldr
    fldr=`dirname ~/.$file`
    mkdir -p $fldr
    echo "Creating symlink to $dir/$file in home directory."
    ln -s $dir/$file ~/.$file
    echo -e "\n"
done

# setup Nvim (neovim) config by linking to vim config files.
mkdir -p ${XDG_CONFIG_HOME:=$HOME/.config}
ln -s ~/.vim $XDG_CONFIG_HOME/nvim
ln -s ~/.vimrc $XDG_CONFIG_HOME/nvim/init.vim

