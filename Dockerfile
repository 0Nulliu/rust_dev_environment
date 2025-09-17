# Dockerfile (Final Version, Corrects the symbolic link typo)
FROM debian:bookworm-slim
ENV DEBIAN_FRONTEND=noninteractive

ARG NVIM_VERSION="v0.11.4"
ARG NVIM_FILENAME="nvim-linux-x86_64.tar.gz"

# Step 1: Install system-level dependencies as root
# Added libfuse2 just in case, it's a common dependency for AppImage-like binaries.
RUN apt-get update && apt-get install -y \
    build-essential pkg-config libssl-dev curl ca-certificates git openssh-client unzip clang lld postgresql-client libfuse2 \
    --no-install-recommends && rm -rf /var/lib/apt/lists/*

# Step 2: Download and install your chosen version of Neovim (v0.11.4)
RUN curl -LO "https://github.com/neovim/neovim/releases/download/${NVIM_VERSION}/${NVIM_FILENAME}" && \
    tar -C /usr/local -xzf "${NVIM_FILENAME}" && \
    # THE TYPO FIX IS HERE: The directory is nvim-linux-x86_64, not nvim-linux64.
    ln -s /usr/local/nvim-linux-x86_64/bin/nvim /usr/local/bin/nvim && \
    rm "${NVIM_FILENAME}"

# Step 3: Create the non-root user
RUN useradd -ms /bin/bash devuser

# Step 4: Switch to the non-root user
USER devuser
WORKDIR /home/devuser

# Step 5: Install user-specific tools (Rust) as the user
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y \
    && /home/devuser/.cargo/bin/rustup component add rust-analyzer

# Step 6: Explicitly define the complete PATH for the user
ENV PATH="/home/devuser/.cargo/bin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"

# Set a default command to keep the container running
CMD ["tail", "-f", "/dev/null"]
