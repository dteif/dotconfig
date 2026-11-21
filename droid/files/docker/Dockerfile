FROM debian:bookworm-slim

RUN apt-get update && apt-get install -y \
    curl git bash ripgrep jq \
    && rm -rf /var/lib/apt/lists/*

# Create user first
RUN adduser --disabled-password --shell /bin/bash claude

# Install as the claude user so the binary lands in /home/claude/.local/bin
USER claude
ENV PATH="/home/claude/.local/bin:$PATH"
RUN curl -fsSL https://claude.ai/install.sh | bash

# Switch back to root to install the entrypoint
USER root
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

USER claude
WORKDIR /workspace

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
