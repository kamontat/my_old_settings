if_file_exist "$HOME/.travis/travis.sh" && load "$HOME/.travis/travis.sh"

if [[ $MYZS_USE_ITERM == true ]] && if_file_exist "${HOME}/.iterm2_shell_integration.zsh"; then
	loading_files "${HOME}/.iterm2_shell_integration.zsh"
else
	curl -L https://iterm2.com/shell_integration/install_shell_integration_and_utilities.sh | zsh
	loading_files "${HOME}/.iterm2_shell_integration.zsh"
fi
