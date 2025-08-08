#!/bin/bash

# Check if script is run as root
if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

# Enable unprivileged user namespaces
echo "Enabling unprivileged user namespaces..."
echo "kernel.unprivileged_userns_clone=1" > /etc/sysctl.d/99-disable-chrome-sandbox.conf

# Apply new sysctl settings
echo "Applying new sysctl settings..."
sysctl --system

# Set up system-wide environment variable
echo "Setting up system-wide environment variable..."
echo "CHROME_DEVEL_SANDBOX=/usr/local/bin/chrome-devel-sandbox" >> /etc/environment

# Create dummy sandbox binary
echo "Creating dummy sandbox binary..."
touch /usr/local/bin/chrome-devel-sandbox
chmod 755 /usr/local/bin/chrome-devel-sandbox

echo "Setup complete. Please reboot your system for changes to take effect."
echo "WARNING: This script disables sandboxing for all AppImages. Use at your own risk."
