
#!/bin/bash

set -e

# Variables
REPO="neovim/neovim"
INSTALL_DIR="/usr/local/bin"
TMP_DIR=$(mktemp -d)
ARCH=$(uname -m)

# Determine the system architecture for proper binary
if [[ "$ARCH" == "x86_64" ]]; then
    FILE_SUFFIX="linux64.tar.gz"
elif [[ "$ARCH" == "aarch64" ]]; then
    FILE_SUFFIX="linux_arm64.tar.gz"
else
    echo "Unsupported architecture: $ARCH"
    exit 1
fi

echo "Fetching latest Neovim release info..."

# Get latest release download URL
DOWNLOAD_URL=$(curl -s https://api.github.com/repos/${REPO}/releases/latest \
    | grep "browser_download_url" \
    | grep "$FILE_SUFFIX" \
    | cut -d '"' -f 4)

FILENAME=$(basename "$DOWNLOAD_URL")

echo "Downloading $FILENAME..."
curl -L "$DOWNLOAD_URL" -o "$TMP_DIR/$FILENAME"

echo "Extracting..."
tar -xzf "$TMP_DIR/$FILENAME" -C "$TMP_DIR"

# Move binary to /usr/local/bin
echo "Installing to $INSTALL_DIR..."
sudo cp "$TMP_DIR/nvim-linux64/bin/nvim" "$INSTALL_DIR/nvim"
sudo chmod +x "$INSTALL_DIR/nvim"

# Clean up
rm -rf "$TMP_DIR"

# Check version
echo "Neovim installed at $INSTALL_DIR/nvim"
nvim --version
