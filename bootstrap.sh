#!/usr/bin/env bash
set -euo pipefail

# =========================================================
# LazyVim bootstrap desde este repo
# - Instala Homebrew (Linux/macOS)
# - Instala Neovim + utilidades via brew
# - (Opcional) crea symlink de este repo a ~/.config/nvim (default)
# - (Opcional) copia los archivos al ~/.config/nvim si usas --copy
# - Sincroniza plugins en modo headless
# Uso:
#   bash bootstrap.sh
#   bash bootstrap.sh --copy   # si prefieres copiar en lugar de symlink
# =========================================================

MODE="symlink"
if [[ "${1:-}" == "--copy" ]]; then
  MODE="copy"
fi

msg() { printf "\033[1;32m==>\033[0m %s\n" "$*"; }
err() { printf "\033[1;31m[ERROR]\033[0m %s\n" "$*" >&2; }

# Directorio del repo (donde está este script)
REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET_DIR="$HOME/.config/nvim"

OS="$(uname -s)"

install_homebrew() {
  if command -v brew >/dev/null 2>&1; then
    msg "Homebrew ya está instalado."
    return
  fi

  msg "Instalando Homebrew..."
  # En Linux, instala dependencias base antes de Homebrew
  if [[ "$OS" == "Linux" ]] && command -v apt >/dev/null 2>&1; then
    sudo apt update
    sudo apt install -y build-essential procps curl file git
  fi

  # Comando oficial
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  # Añadir brew a PATH para esta sesión
  if [[ "$OS" == "Darwin" ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)" 2>/dev/null || eval "$(/usr/local/bin/brew shellenv)" 2>/dev/null || true
  else
    test -d /home/linuxbrew/.linuxbrew && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
    test -d "$HOME/.linuxbrew" && eval "$("$HOME/.linuxbrew/bin/brew" shellenv)"
  fi

  # Persistir en el perfil
  local PROFILE_FILE
  if [[ -n "${ZSH_VERSION:-}" ]]; then PROFILE_FILE="$HOME/.zshrc"; else PROFILE_FILE="$HOME/.bashrc"; fi

  if [[ "$OS" == "Darwin" ]]; then
    grep -q 'brew shellenv' "$PROFILE_FILE" 2>/dev/null || echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> "$PROFILE_FILE"
  else
    grep -q 'brew shellenv' "$PROFILE_FILE" 2>/dev/null || echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> "$PROFILE_FILE"
  fi
}

setup_brew_shellenv() {
  if command -v brew >/dev/null 2>&1; then return; fi
  if [[ "$OS" == "Darwin" ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)" 2>/dev/null || eval "$(/usr/local/bin/brew shellenv)" 2>/dev/null || true
  else
    test -d /home/linuxbrew/.linuxbrew && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
    test -d "$HOME/.linuxbrew" && eval "$("$HOME/.linuxbrew/bin/brew" shellenv)"
  fi
  command -v brew >/dev/null 2>&1 || { err "No pude cargar brew en PATH."; exit 1; }
}

install_packages() {
  msg "Instalando Neovim y utilidades (brew)..."
  brew update
  brew install neovim git ripgrep fd fzf lazygit node npm python

  # Configurar fzf (opcional)
  if [[ -x "$(brew --prefix)/opt/fzf/install" ]]; then
    yes | "$(brew --prefix)/opt/fzf/install" || true
  fi
}

backup_existing_config() {
  if [[ -e "$TARGET_DIR" || -L "$TARGET_DIR" ]]; then
    local TS; TS="$(date +%Y%m%d_%H%M%S)"
    msg "Encontré $TARGET_DIR. Respaldo en ${TARGET_DIR}.backup_${TS}"
    mv "$TARGET_DIR" "${TARGET_DIR}.backup_${TS}"
  fi
}

deploy_config() {
  mkdir -p "$(dirname "$TARGET_DIR")"

  if [[ "$MODE" == "copy" ]]; then
    msg "Copiando archivos del repo a $TARGET_DIR ..."
    rsync -a --delete --exclude ".git/" --exclude "bootstrap.sh" "$REPO_DIR/" "$TARGET_DIR/"
  else
    msg "Creando symlink $TARGET_DIR -> $REPO_DIR ..."
    ln -s "$REPO_DIR" "$TARGET_DIR"
  fi
}

lazy_sync() {
  command -v nvim >/dev/null 2>&1 || { err "Neovim no está en PATH.";
