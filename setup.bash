cd $HOME/dotfiles
stow nvim
nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
