# RUST "Playspace" | Using Docker and Neovim

This repository has it role as a containerized development environment for building Rust applications.

The environment uses:

- **Debian bookworm** as a stable OS in combination with Neovim
- rustc and cargo
- **Neovim (v0.11.4)** | As a preferred choice of coding.
- **PostgreSQL** | To integrate a database service for future applications
- The standard build tools (`clang`, `lld`, `git`..)

## Prerequisites 
- [Docker] (https://www.docker.com/get-started)
- [Docker Compose] (https://docs.docker.com/compose/install/)
- SSH Key for git authentication

## Quick Start
1. **Clone the repository:**
   ```bash
   git clone https://github.com/0Nulliu/rust_dev_environment
   cd RUST_CITY  ("A very creative name, I Know.")
   ```
2. **Prepare SSH: (step needs to be repeated on every access for safety)**
   This environment uses SSH forwarding to securely handle Git credentials. Run these commands.
   ```bash
   eval "$(ssh-agent -s)"
   ssh-add ~/.ssh/id_ed25519
   newgrp docker
   ```
3. **Build and start (only need to run once):**
   ```bash
   docker-compose up -d --build
   ```
4. **Enter the Docker:**
   ```bash
   docker-compose exec dev bash
   ```
5. **Happy days! and Happy coding!**
  ```bash
   cd /home/devuser/project
   cargo new future_billion_dollar_company
   cd future_billion_dollar_company
   nvim .
   ```

PostgreSQL is a bit shifty right now, future instructions will be given once I've set it up better.

### Is neovim configured?
    Yes there is a .nvim.conf situated inside of the ~/devuser/project, the first time you run it, it will install all necessary plugins.

