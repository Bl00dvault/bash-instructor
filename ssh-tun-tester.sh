#!/bin/bash

# Function to extract host and port from SSH command
extract_host_port() {
    local ssh_command="$1"
    local type="$2"
    local host_port=$(echo "$ssh_command" | grep -oP "(?<=$type).*" | awk -F ':' '{print $1 ":" $2}')
    echo "$host_port"
}

# Read the SSH command for each redirector
read -p "Enter the SSH command for Redirector 1: " ssh_command_redir1
read -p "Enter the SSH command for Redirector 2: " ssh_command_redir2

# Extract host and port information
redir1_host_port=$(extract_host_port "$ssh_command_redir1" '-L')
redir2_host_port=$(extract_host_port "$ssh_command_redir2" '-L')

redir1_ip=$(echo "$redir1_host_port" | cut -d ':' -f 1)
redir1_port=$(echo "$redir1_host_port" | cut -d ':' -f 2)
redir2_ip=$(echo "$redir2_host_port" | cut -d ':' -f 1)
redir2_port=$(echo "$redir2_host_port" | cut -d ':' -f 2)

# Extract target IP and port
target_info=$(extract_host_port "$ssh_command_redir2" '-R')
target_ip=$(echo "$target_info" | cut -d ':' -f 1)
target_port=$(echo "$target_info" | cut -d ':' -f 2)

# Get listening ports on the client
listening_ports=$(sudo netstat -tuln | grep 'LISTEN' | grep -i 'ssh'| awk '{print $4}' | awk -F ':' '{print $NF}' | sort -u | tr '\n' ',' | sed 's/,$//')

# Calculate column widths
col1_width=$((10 + ${#listening_ports}))
col2_width=$((9 + ${#redir1_ip} + ${#redir1_port}))
col3_width=$((9 + ${#redir2_ip} + ${#redir2_port}))
col4_width=12

# Function to draw separator lines
separator() {
  printf "+"
  printf "%0.s-" $(seq 1 $col1_width)
  printf "+"
  printf "%0.s-" $(seq 1 $col2_width)
  printf "+"
  printf "%0.s-" $(seq 1 $col3_width)
  printf "+"
  printf "%0.s-" $(seq 1 $col4_width)
  printf "+\n"
}

# Create the ASCII diagram
separator
printf "| %-${col1_width}s | %-${col2_width}s | %-${col3_width}s | %-${col4_width}s |\n" "Client" "Redir1" "Redir2" "Target"
printf "| %-${col1_width}s | %-${col2_width}s | %-${col3_width}s | %-${col4_width}s |\n" "($listening_ports)" "$redir1_ip:$redir1_port" "$redir2_ip:$redir2_port" "$target_ip:$target_port"
separator
