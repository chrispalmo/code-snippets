BACKUP_DIR="$HOME"/dev/code-snippets/macos/vscode
VSCODE_DIR="$HOME"/Library/Application\ Support/Code

rm "$VSCODE_DIR"/User/keybindings.json
rm "$VSCODE_DIR"/User/settings.json
rm -r "$VSCODE_DIR"/User/sync
cp -r "$BACKUP_DIR"/User/* "$VSCODE_DIR"/User/

