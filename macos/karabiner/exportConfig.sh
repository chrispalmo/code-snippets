BACKUP_DIR="$HOME"/dev/code-snippets/macos/karabiner
CONFIG_DIR="$HOME"/.config

rm -r "$BACKUP_DIR"/backup/*
cp -r "$CONFIG_DIR"/karabiner/* "$BACKUP_DIR"/backup

