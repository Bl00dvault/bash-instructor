# Bash Instructor
A repository of different bash scripts that aid in instructing novel concepts.

## Description
This repository contains a collection of bash scripts designed to assist in teaching new concepts through command-line interactions. The scripts are designed to simplify complex tasks, provide visual representations, and make it easier to understand and work with various technologies.

One of the scripts included in this repository is visualize_ssh.sh, which helps users visualize SSH connections with port forwarding through redirectors.

## Getting Started
### Prerequisites
- A Unix-like operating system (Linux, macOS)
- Bash shell (usually available by default on Unix-like systems)

### Installation
1. Clone the repository:

```bash
git clone https://github.com/bl00dvault/bash-instructor.git
```

2. Change into the repository directory:
```bash
cd bash-script-instructors
```

3. Make the scripts executable:

```bash
chmod +x *.sh
```

## Usage
visualize_ssh.sh  

This script takes SSH commands for two redirectors as input and generates an ASCII diagram to visualize the connections between the client, redirectors, and target IP and port.

1. Run the script:

```bash
./visualize_ssh.sh
```

2. Enter the SSH commands for Redirector 1 and Redirector 2 when prompted. The script will then display the ASCII diagram with the extracted information.

```ruby
Enter the SSH command for Redirector 1: ssh -L 1234:localhost:5678 user@redir1.example.com
Enter the SSH command for Redirector 2: ssh -L 5678:localhost:8080 user@redir2.example.com -R 1.2.3.4:8080:localhost:5678
```
