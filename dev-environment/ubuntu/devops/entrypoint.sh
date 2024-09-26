#!/bin/bash
# Print a welcome message
echo "Welcome to the development container!"
echo "-----------------------------"

# Display some system information
echo "Container Info:"
echo "Host: $(hostname)"
echo "Date: $(date)"
echo "Uptime: $(uptime)"
echo "-----------------------------"

# Optionally: Display resource usage
echo "Resource usage:"
free -h
df -h
echo "-----------------------------"

# Start a bash shell (or keep the original entrypoint functionality)
exec "$@"
