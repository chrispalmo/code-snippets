BACKUP_DIR="$HOME"/dev/code-snippets/macos/vscode
VSCODE_DIR="$HOME"/Library/Application\ Support/Code

rm -r "$BACKUP_DIR"/User/*
cp "$VSCODE_DIR"/User/keybindings.json "$BACKUP_DIR"/User
cp "$VSCODE_DIR"/User/settings.json "$BACKUP_DIR"/User
cp -r "$VSCODE_DIR"/User/sync "$BACKUP_DIR"/User

