#!/bin/bash
#
# Script to extract the OS version and determine system type (desktop/server)
# from the system environment, then execute a curl request using both
# variables in the URL.

# 1. Set script to exit immediately if any command fails
set -e

# Define the base URL structure
BASE_URL="https://ubuntulionheart.org"

detect_desktop_or_server() {
    # Check XDG session type first (most reliable)
    case "$XDG_SESSION_TYPE" in
        wayland|x11)
            echo "desktop"
            return
            ;;
    esac

    # Fallback: check for environment variables used by each system
    if [ -n "$WAYLAND_DISPLAY" ] || [ -n "$DISPLAY" ]; then
        echo "desktop"
    else
        echo "server"
    fi
}

# Define the list of supported OS versions for this specific application
# You can modify this array as needed.
SUPPORTED_VERSIONS=("25.10")

# --- Version Extraction ---
echo "Attempting to read OS version from /etc/os-release..."

# Check if the file exists
if [ ! -f "/etc/os-release" ]; then
    echo "Error: The required system file /etc/os-release was not found. Exiting."
    exit 1
fi

# Extract VERSION_ID
VERSION=$(grep VERSION_ID /etc/os-release | cut -d '=' -f 2 | tr -d '"')

# 2. Validate the extracted version (is not empty)
if [ -z "$VERSION" ]; then
    echo "Error: Could not extract the VERSION_ID from /etc/os-release. Exiting."
    exit 1
fi

echo "Successfully extracted version '$VERSION'."

# 2a. Check if the extracted version is supported
IS_SUPPORTED=0
for SUP_V in "${SUPPORTED_VERSIONS[@]}"; do
    if [ "$SUP_V" == "$VERSION" ]; then
        IS_SUPPORTED=1
        break
    fi
done

if [ "$IS_SUPPORTED" -eq 0 ]; then
    echo "--------------------------------------------------------"
    echo "Error: Unsupported OS Version '$VERSION'."
    echo "This script only supports versions: ${SUPPORTED_VERSIONS[*]}"
    echo "Exiting with status 1."
    echo "--------------------------------------------------------"
    exit 1
fi
# --- End of Supported Version Check ---

echo "Checking whether system is a desktop (i.e. X11 or Wayland present) or a server..."
SYSTEM_TYPE=$(detect_desktop_or_server)
echo "System Type: $SYSTEM_TYPE"


# 3. Construct the final URL
# Format: https://ubuntulionheart.org/{VERSION}/{SYSTEM_TYPE}/install.sh
TARGET_URL="${BASE_URL}/${VERSION}/${SYSTEM_TYPE}.sh"

echo "--------------------------------------------------------"
echo "Detected OS Version: $VERSION"
echo "Detected System Type: $SYSTEM_TYPE"
echo "Target URL: $TARGET_URL"
echo "--------------------------------------------------------"

# 4. Execute the curl request
# The '-s' flag makes curl silent (no progress bar or error messages)
# The '-O' flag saves the remote file with its original filename (install.sh)
echo "Executing curl request..."
echo "curl -fsSL \"$TARGET_URL\" | bash"
curl -fsSL "$TARGET_URL" | bash
