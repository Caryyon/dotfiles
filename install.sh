#!/usr/bin/env bash
set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

print_step() { echo -e "${BLUE}==>${NC} $1"; }
print_success() { echo -e "${GREEN}[OK]${NC} $1"; }
print_warning() { echo -e "${YELLOW}[WARN]${NC} $1"; }
print_error() { echo -e "${RED}[ERROR]${NC} $1"; }

# Detect platform
OS="unknown"
if [[ "$(uname)" == "Darwin" ]]; then
  OS="macos"
elif [[ "$(uname)" == "Linux" ]]; then
  OS="linux"
  # Detect Linux distro
  if [ -f /etc/debian_version ]; then
    DISTRO="debian"
  elif [ -f /etc/fedora-release ]; then
    DISTRO="fedora"
  elif [ -f /etc/arch-release ]; then
    DISTRO="arch"
  else
    DISTRO="unknown"
  fi
fi

echo ""
echo "=========================================="
echo "  Dotfiles Bootstrap Script"
echo "  Detected: $OS ${DISTRO:+($DISTRO)}"
echo "=========================================="
echo ""

# Install package manager and dependencies
install_dependencies() {
  print_step "Installing dependencies..."

  if [[ "$OS" == "macos" ]]; then
    # Install Homebrew if not present
    if ! command -v brew &> /dev/null; then
      print_step "Installing Homebrew..."
      /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi

    print_step "Installing packages via Homebrew..."
    brew install git neovim tmux zsh fzf bat eza lazygit ripgrep fd || true

    # Optional: GUI apps
    if [[ "${INSTALL_GUI:-false}" == "true" ]]; then
      brew install --cask alacritty lazydocker || true
    fi

  elif [[ "$OS" == "linux" ]]; then
    case "$DISTRO" in
      debian)
        print_step "Installing packages via apt..."
        sudo apt update
        sudo apt install -y git neovim tmux zsh fzf bat ripgrep fd-find curl
        # bat is installed as 'batcat' on Debian/Ubuntu
        if ! command -v bat &> /dev/null && command -v batcat &> /dev/null; then
          sudo ln -sf /usr/bin/batcat /usr/local/bin/bat
        fi
        # fd is installed as 'fdfind' on Debian/Ubuntu
        if ! command -v fd &> /dev/null && command -v fdfind &> /dev/null; then
          sudo ln -sf /usr/bin/fdfind /usr/local/bin/fd
        fi
        # eza might need to be installed from GitHub releases
        if ! command -v eza &> /dev/null; then
          print_warning "eza not in apt repos. Install manually: https://github.com/eza-community/eza"
        fi
        ;;
      fedora)
        print_step "Installing packages via dnf..."
        sudo dnf install -y git neovim tmux zsh fzf bat eza ripgrep fd-find
        ;;
      arch)
        print_step "Installing packages via pacman..."
        sudo pacman -Syu --noconfirm git neovim tmux zsh fzf bat eza lazygit ripgrep fd
        ;;
      *)
        print_warning "Unknown Linux distro. Please install manually: git neovim tmux zsh fzf bat eza ripgrep fd"
        ;;
    esac
  fi

  print_success "Dependencies installed"
}

# Install oh-my-zsh
install_ohmyzsh() {
  if [ ! -d "$HOME/.oh-my-zsh" ]; then
    print_step "Installing oh-my-zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    print_success "oh-my-zsh installed"
  else
    print_success "oh-my-zsh already installed"
  fi
}

# Clone dotfiles
setup_dotfiles() {
  if [ -d "$HOME/.dotfiles.git" ]; then
    print_success "Dotfiles repo already exists"
    return
  fi

  print_step "Cloning dotfiles..."
  git clone --bare https://github.com/Caryyon/dotfiles.git "$HOME/.dotfiles.git"

  # Define dotfiles function for this script
  dotfiles() {
    /usr/bin/git --git-dir="$HOME/.dotfiles.git" --work-tree="$HOME" "$@"
  }

  # Backup existing files
  print_step "Backing up existing files..."
  mkdir -p "$HOME/.dotfiles-backup"

  # Try checkout, backup conflicts
  if ! dotfiles checkout 2>/dev/null; then
    dotfiles checkout 2>&1 | grep -E "^\s+" | awk '{print $1}' | while read -r file; do
      if [ -f "$HOME/$file" ]; then
        mkdir -p "$HOME/.dotfiles-backup/$(dirname "$file")"
        mv "$HOME/$file" "$HOME/.dotfiles-backup/$file"
        print_warning "Backed up: $file"
      fi
    done
    dotfiles checkout
  fi

  # Hide untracked files
  dotfiles config --local status.showUntrackedFiles no

  print_success "Dotfiles installed"
}

# Setup oh-my-zsh theme and plugins
setup_zsh_extras() {
  print_step "Setting up zsh theme and plugins..."

  # Copy gmork theme
  if [ -f "$HOME/.config/zsh/themes/gmork.zsh-theme" ]; then
    cp "$HOME/.config/zsh/themes/gmork.zsh-theme" "$HOME/.oh-my-zsh/themes/"
    print_success "Copied gmork theme"
  fi

  # Install zsh-autosuggestions
  if [ ! -d "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions" ]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions"
    print_success "Installed zsh-autosuggestions"
  fi

  # Install zsh-syntax-highlighting
  if [ ! -d "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting" ]; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting"
    print_success "Installed zsh-syntax-highlighting"
  fi
}

# Install tmux plugin manager
setup_tmux() {
  if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
    print_step "Installing tmux plugin manager..."
    git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
    print_success "TPM installed. Press prefix + I in tmux to install plugins."
  else
    print_success "TPM already installed"
  fi
}

# Install NVM
setup_nvm() {
  if [ ! -d "$HOME/.nvm" ]; then
    print_step "Installing NVM..."
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
    print_success "NVM installed"
  else
    print_success "NVM already installed"
  fi
}

# Change default shell to zsh
setup_shell() {
  if [[ "$SHELL" != *"zsh"* ]]; then
    print_step "Changing default shell to zsh..."
    if command -v zsh &> /dev/null; then
      chsh -s "$(which zsh)"
      print_success "Default shell changed to zsh"
    else
      print_error "zsh not found"
    fi
  else
    print_success "Shell is already zsh"
  fi
}

# Main installation
main() {
  echo "This script will:"
  echo "  1. Install dependencies (git, neovim, tmux, zsh, fzf, bat, eza, etc.)"
  echo "  2. Install oh-my-zsh"
  echo "  3. Clone and setup dotfiles"
  echo "  4. Install zsh plugins and theme"
  echo "  5. Install tmux plugin manager"
  echo "  6. Install NVM"
  echo "  7. Set zsh as default shell"
  echo ""

  read -p "Continue? [y/N] " -n 1 -r
  echo ""
  if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "Aborted."
    exit 1
  fi

  install_dependencies
  install_ohmyzsh
  setup_dotfiles
  setup_zsh_extras
  setup_tmux
  setup_nvm
  setup_shell

  echo ""
  echo "=========================================="
  echo "  Setup Complete!"
  echo "=========================================="
  echo ""
  echo "Next steps:"
  echo "  1. Restart your terminal or run: source ~/.zshrc"
  echo "  2. Open nvim and let plugins install: nvim"
  echo "  3. In tmux, press prefix + I to install plugins"
  echo "  4. Create ~/.zshrc.local for your secrets/API keys"
  echo ""

  if [ -d "$HOME/.dotfiles-backup" ] && [ "$(ls -A "$HOME/.dotfiles-backup" 2>/dev/null)" ]; then
    print_warning "Some files were backed up to ~/.dotfiles-backup"
  fi
}

# Run with optional flags
case "${1:-}" in
  --deps-only)
    install_dependencies
    ;;
  --help|-h)
    echo "Usage: $0 [OPTIONS]"
    echo ""
    echo "Options:"
    echo "  --deps-only    Only install dependencies"
    echo "  --help, -h     Show this help"
    echo ""
    echo "Environment variables:"
    echo "  INSTALL_GUI=true    Also install GUI apps (alacritty, etc.)"
    ;;
  *)
    main
    ;;
esac
