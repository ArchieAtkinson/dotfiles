FROM ghcr.io/archieatkinson/notus:trunk

RUN sudo add-apt-repository ppa:maveonair/helix-editor && \
  sudo apt update -y && \
  sudo apt install -y helix

RUN git config --global --add safe.directory /home/user/west-workspace/notus


RUN git config --global user.email "archieatkinson97@gmail.com" && \
   git config --global user.name "Archie Atkinson"

RUN LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | \grep -Po '"tag_name": *"v\K[^"]*') && \
  curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/download/v${LAZYGIT_VERSION}/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz" && \
  tar xf lazygit.tar.gz lazygit && \
  sudo install lazygit -D -t /usr/local/bin/ 

USER user
