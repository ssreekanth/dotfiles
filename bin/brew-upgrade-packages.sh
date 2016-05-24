echo ">>>>>>>>>>> brew non-gui packages >>>>>>>>>>>>>>>>>"
brew update && brew upgrade && brew cleanup
echo ">>>>>>>>>>> brew gui packages >>>>>>>>>>>>>>>>>"
brew cask update && brew cask list | xargs brew cask install && brew cask cleanup

