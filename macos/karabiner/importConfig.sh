BACKUP_DIR="$HOME"/dev/code-snippets/macos/karabiner
CONFIG_DIR="$HOME"/.config

rm -r "$CONFIG_DIR"/karabiner/*
cp -r "$BACKUP_DIR"/backup/* "$CONFIG_DIR"/karabiner

