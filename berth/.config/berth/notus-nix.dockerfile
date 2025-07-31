# Stage 1: Build the Nix environment
FROM nixos/nix:latest AS nix_builder

WORKDIR /app

# Define the Nix expression for the environment
RUN echo '{ pkgs ? import <nixpkgs> {} }: pkgs.buildEnv { name = "my-container-user-environment"; paths = [ pkgs.helix ];}' > env.nix

# Build the Nix environment and get the resulting symlink
RUN nix-build env.nix -o /tmp/my-env-result

# Create a directory that will hold *only* the /nix/store contents
# This is crucial for copying only the necessary Nix store paths.
RUN mkdir -p /tmp/nix_store_contents && \
    export ENV_STORE_PATH=$(readlink /tmp/my-env-result) && \
    nix-store --query --requisites $ENV_STORE_PATH | xargs cp -r -t /tmp/nix_store_contents --parents

# Stage 2: Extend your existing Docker image
FROM ghcr.io/archieatkinson/notus:trunk

# Create the /nix/store directory if it doesn't exist
RUN mkdir -p /nix/store

# Copy the contents of /tmp/nix_store_contents (which are the actual store paths)
# directly into the final image's /nix/store
COPY --from=nix_builder /tmp/nix_store_contents /nix/store/

# --- SIMPLER FIX STARTS HERE ---

# Create a symlink in the final image that points to the built Nix environment.
# This makes it easier to reference the environment.
# The `readlink` is executed in the build stage, and its output is used directly.
# This assumes the symlink target is stable within the build context.
RUN ln -s $(readlink /tmp/my-env-result) /nix/container-env

# Set the PATH environment variable directly using the symlink.
# This ENV instruction will apply to all subsequent layers and the final container runtime.
ENV PATH="/nix/container-env/bin:$PATH"

# No need for a custom ENTRYPOINT or /etc/profile.d script for PATH.
# The ENV instruction handles it directly.
# If you need to source other profile scripts for other reasons, keep the ENTRYPOINT.
# Otherwise, you can remove it if CMD is sufficient.
# For this specific problem (PATH), the ENV is enough.

# --- SIMPLER FIX ENDS HERE ---

CMD ["bash"]

