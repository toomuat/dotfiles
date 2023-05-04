# dotfiles

## Usage

Scripts for setting up a a macOS or Ubuntu development environment.

```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/toomuat/dotfiles/main/install.sh)"
```

Scripts for setting up a development environment in a container.

```bash
docker run --name ${CONTAINER_NAME} -it ubuntu:23.04 /bin/bash

apt update
apt install -y curl
bash -c "$(curl -fsSL https://raw.githubusercontent.com/toomuat/dotfiles/main/setup/setup_container.sh)"

# zsh setup
docker exec -it $(docker start ${CONTAINER_NAME}) zsh
cd ${DOTFILES_PATH}
zsh setup/setup_container2.sh
```

### LICENSE

[MIT LICENSE](./LICENSE)
