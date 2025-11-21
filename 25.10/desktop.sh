#!/bin/bash

# Install XLibre (X11 Server)
install_xlibre () {
sudo apt-get update
sudo apt-get install -y ca-certificates curl

sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://xlibre-deb.github.io/key.asc | sudo tee /etc/apt/keyrings/xlibre-deb.asc
sudo chmod a+r /etc/apt/keyrings/xlibre-deb.asc

cat <<EOF | sudo tee /etc/apt/sources.list.d/xlibre-deb.sources
Types: deb deb-src
URIs: https://xlibre-deb.github.io/ubuntu/
Suites: $(. /etc/os-release && echo "$UBUNTU_CODENAME")
Components: main
Architectures: $(dpkg --print-architecture)
Signed-By: /etc/apt/keyrings/xlibre-deb.asc
EOF

sudo apt-get update
sudo apt-get install -y xlibre

echo "You can verify whether XLibre or Xorg is running by using this command:"
echo "head /var/log/Xorg.0.log | grep -i server"
}

# Install Brave (Web Browser)
install_brave () {
	curl -fsS https://dl.brave.com/install.sh | sh
}

# Replace Rust Utils (uutils) with GNU CoreUtils
install_gnu_coreutils () {
	sudo apt install coreutils-from-gnu --allow-remove-essential coreutils-from-uutils-
	echo "You can verify whether GNU coreutils or Rust uutils are installed by using this command:"
	echo "ls --version"
}

# Check for whiptail and install if needed (common practice for TUI scripts)
if ! command -v whiptail &> /dev/null
then
    echo "whiptail could not be found. Please install it (e.g., 'sudo apt install whiptail' or 'sudo pacman -S whiptail')."
    exit 1
fi

# The whiptail --checklist command arguments:
# TITLE, TEXT, HEIGHT, WIDTH, MENU_HEIGHT, ITEM TAG, DESCRIPTION, STATUS
CHOICES=$(whiptail --title "Ubuntu Lionheart" --separate-output --checklist \
"Select the components you wish to install or configure. Use SPACE to toggle a selection." \
20 78 12 \
"GNU CoreUtils" "Replace Rust uutils with GNU coreutils  " ON \
"XLibre" "X11 server with ongoing maintainership         " OFF \
"Brave" "A fast, privacy-focused web browser             " OFF 3>&1 1>&2 2>&3)

# Capture the exit status (0 for OK, 1 for Cancel)
EXIT_STATUS=$?

# --- 3. Process Selections ---

if [ $EXIT_STATUS -eq 0 ]; then
    echo -e "\n--- Processing Selections ---"

    # IFS (Internal Field Separator) is critical for iterating over the selection.
    # whiptail --separate-output usually separates items by newline.
    # If using standard whiptail output (not separate), you might need IFS=' '
    # We use 'read' here to safely process the output line-by-line.

    while IFS= read -r OPTION; do
        # The OPTION variable holds the tag (e.g., "XLibre")
        case "$OPTION" in
            "XLibre")
                install_xlibre
                ;;
            "Brave")
                install_brave
                ;;
            "GNU CoreUtils")
                install_gnu_coreutils
                ;;
            *)
                echo -e "\n[ERROR] Unrecognized selection: $OPTION"
                ;;
        esac
    done <<< "$CHOICES"

    echo -e "\n--- All selected tasks completed. ---"
else
    echo -e "\nSetup cancelled by user."
fi
