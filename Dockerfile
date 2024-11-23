FROM ghcr.io/astral-sh/uv:python3.12-bookworm AS builder

ENV \
  CARGO_HOME=/rust/.cargo \
  RUSTUP_HOME=/rust/.rustup \
  PATH="/rust/.cargo/bin:$PATH"

# Install rust
COPY rust/rust-toolchain.toml rust-toolchain.toml
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --default-toolchain none \
  && rustc --version # Invoking rustc makes sure everything is installed

# Install python dependencies (only main, not dev dependencies)
RUN --mount=type=cache,target=/root/.cache/uv \
    --mount=type=bind,source=uv.lock,target=uv.lock \
    --mount=type=bind,source=pyproject.toml,target=pyproject.toml \
    uv sync --locked --no-install-project --no-dev

