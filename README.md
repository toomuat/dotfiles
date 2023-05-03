# dotfiles

## Usage

Scripts for setting up a a macOS or Ubuntu development environment.

```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/toomuat/dotfiles/main/install.sh)"
```

Scripts for setting up a development environment in a container.

```bash
docker run -it ubuntu:23.04 /bin/bash

apt update
apt install -y curl
bash -c "$(curl -fsSL https://raw.githubusercontent.com/toomuat/dotfiles/main/setup_container.sh)"
```

### LICENSE

[MIT LICENSE](./LICENSE)
