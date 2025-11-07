#!/data/data/com.termux/files/usr/bin/bash
# Termux Setup Script for Zsh + Oh My Posh + Catppuccin Theme

set -e

echo ""
echo "=========================================="
echo " Installing Zsh, Git, Oh My Posh, and Wget..."
echo "=========================================="
pkg update -y
pkg upgrade -y
pkg install zsh git oh-my-posh wget -y

echo ""
echo "=========================================="
echo " Installing RobotoMono Nerd Font..."
echo "=========================================="
oh-my-posh font install RobotoMono

# Apply Termux Catppuccin Theme
echo ""
echo "=========================================="
echo " Applying Catppuccin Termux theme..."
echo "=========================================="
git clone https://github.com/catppuccin/termux.git ~/termux-catppuccin
mkdir -p ~/.termux
cp -f ~/termux-catppuccin/themes/catppuccin-mocha.properties ~/.termux/colors.properties
termux-reload-settings

# Apply Font
echo ""
echo "=========================================="
echo " Setting Termux font..."
echo "=========================================="
mkdir -p ~/.termux
cp -f ~/.local/share/fonts/robotomono-nerd-font/RobotoMonoNerdFont-Regular.ttf ~/.termux/font.ttf || {
  echo "Font not found, skipping font copy step."
}
termux-reload-settings

# Install Oh My Posh Theme
echo ""
echo "=========================================="
echo " Setting up Oh My Posh theme..."
echo "=========================================="
mkdir -p ~/.poshthemes
wget -q https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes/catppuccin_mocha.omp.json -O ~/.poshthemes/catppuccin_mocha.omp.json

# Install Zsh plugins
echo ""
echo "=========================================="
echo " Installing Zsh plugins..."
echo "=========================================="
mkdir -p ~/.zsh
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/zsh-syntax-highlighting
git clone --depth 1 https://github.com/marlonrichert/zsh-autocomplete.git ~/.zsh/zsh-autocomplete

# Configure .zshrc
echo ""
echo "=========================================="
echo " Configuring .zshrc..."
echo "=========================================="
cat > ~/.zshrc <<'EOF'
# ========== AUTOCOMPLETE INSTANT ==========
source ~/.zsh/zsh-autocomplete/zsh-autocomplete.plugin.zsh

# ========== OTHER PLUGINS ==========
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# ========== OH MY POSH ==========
eval "$(oh-my-posh init zsh --config ~/.poshthemes/catppuccin_mocha.omp.json)"

# ========== HISTORY ==========
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt share_history
setopt hist_ignore_dups
EOF

# Change default shell to zsh
echo ""
echo "=========================================="
echo " Changing default shell to Zsh..."
echo "=========================================="
chsh -s zsh || echo "Could not change shell automatically. Run 'chsh -s zsh' manually if needed."

echo ""
echo "=========================================="
echo " Installation Complete!"
echo " Restart Termux or run 'zsh' to begin."
echo "=========================================="
