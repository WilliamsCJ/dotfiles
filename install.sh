#!/bin/sh

set -e # -e: exit on error

if ! $CODESPACES ; then
  echo "Not a GitHub Codespaces environment"
else
  echo "GitHub Codespaces environment"
fi

# Install oh-my-zsh
if ! $CODESPACES ; then
  if [ "$(command -v curl)" ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  elif [ "$(command -v wget)" ]; then
    sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  else
    echo "To install ohmyzsh, you must have curl or wget installed." >&2
    exit 1
  fi
fi

ZSH_CUSTOM="$HOME/.oh-my-zsh/custom"

# Install zsh plugins
git clone https://github.com/spaceship-prompt/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt" --depth=1 # spaceship-prompt
ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting # zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions # zsh-autosuggestions

pip install wakatime
git clone https://github.com/sobolevn/wakatime-zsh-plugin.git $ZSH_CUSTOM/plugins/wakatime # Wakatime
echo "[settings]\napi_key = $WAKATIME_API_KEY" > $HOME/.wakatime.cfg

# Install 

if [ ! "$(command -v chezmoi)" ]; then
  bin_dir="$HOME/.local/bin"
  chezmoi="$bin_dir/chezmoi"
  if [ "$(command -v curl)" ]; then
    sh -c "$(curl -fsLS https://git.io/chezmoi)" -- -b "$bin_dir"
  elif [ "$(command -v wget)" ]; then
    sh -c "$(wget -qO- https://git.io/chezmoi)" -- -b "$bin_dir"
  else
    echo "To install chezmoi, you must have curl or wget installed." >&2
    exit 1
  fi
else
  chezmoi=chezmoi
fi

# POSIX way to get script's dir: https://stackoverflow.com/a/29834779/12156188
script_dir="$(cd -P -- "$(dirname -- "$(command -v -- "$0")")" && pwd -P)"
# exec: replace current process with chezmoi init
exec "$chezmoi" init --apply "--source=$script_dir"

zsh
