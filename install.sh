#!/bin/bash

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}"
echo "   █████╗ ██╗  ██╗ █████╗ ███████╗██╗  ██╗██╗ ██████╗ "
echo "  ██╔══██╗██║ ██╔╝██╔══██╗██╔════╝██║  ██║██║██╔═══██╗"
echo "  ███████║█████╔╝ ███████║███████╗███████║██║██║   ██║"
echo "  ██╔══██║██╔═██╗ ██╔══██║╚════██║██╔══██║██║██║   ██║"
echo "  ██║  ██║██║  ██╗██║  ██║███████║██║  ██║██║╚██████╔╝"
echo "  ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝╚═╝ ╚═════╝ "
echo ""
echo "  ██╗  ██╗██╗   ██╗██████╗ ██████╗ ██╗      █████╗ ███╗   ██╗██████╗ "
echo "  ██║  ██║╚██╗ ██╔╝██╔══██╗██╔══██╗██║     ██╔══██╗████╗  ██║██╔══██╗"
echo "  ███████║ ╚████╔╝ ██████╔╝██████╔╝██║     ███████║██╔██╗ ██║██║  ██║"
echo "  ██╔══██║  ╚██╔╝  ██╔═══╝ ██╔══██╗██║     ██╔══██║██║╚██╗██║██║  ██║"
echo "  ██║  ██║   ██║   ██║     ██║  ██║███████╗██║  ██║██║ ╚████║██████╔╝"
echo "  ╚═╝  ╚═╝   ╚═╝   ╚═╝     ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═══╝╚═════╝ "
echo -e "${NC}"
echo -e "${GREEN}  Akashio's Hyprland Dotfiles Installer${NC}"
echo -e "${YELLOW}  https://github.com/Akashio28/hyprland-dotfiles${NC}"
echo ""

# Backup existing config
backup_config() {
    local config=$1
    if [ -d "$HOME/.config/$config" ]; then
        echo -e "${YELLOW}  ⚠️  Backup $config yang lama...${NC}"
        mv "$HOME/.config/$config" "$HOME/.config/$config.bak"
    fi
}

# Install config
install_config() {
    local config=$1
    if [ -d "$config" ]; then
        backup_config "$config"
        cp -r "$config" "$HOME/.config/"
        echo -e "${GREEN}  ✅ $config${NC}"
    else
        echo -e "${RED}  ⚠️  $config tidak ditemukan, skip${NC}"
    fi
}

# Konfirmasi
echo -e "${RED}  ⚠️  WARNING: Config lama akan di-backup ke ~/.config/nama.bak${NC}"
echo ""
read -p "  Lanjut install? (y/n): " confirm
if [[ "$confirm" != "y" ]]; then
    echo "  Install dibatalkan."
    exit 0
fi

echo ""
echo -e "${BLUE}  📦 Installing dotfiles...${NC}"
echo ""

CONFIGS=(
    "hypr"
    "waybar"
    "swaync"
    "rofi"
    "wofi"
    "tofi"
    "kitty"
    "gtk-3.0"
    "gtk-4.0"
    "wal"
    "wallust"
    "cava"
    "nwg-look"
    "nwg-displays"
    "qt5ct"
    "qt6ct"
    "fastfetch"
    "btop"
    "mpv"
    "wlogout"
    "swappy"
    "quickshell"
)

for config in "${CONFIGS[@]}"; do
    install_config "$config"
done

if [ -f "starship.toml" ]; then
    cp "starship.toml" "$HOME/.config/"
    echo -e "${GREEN}  ✅ starship.toml${NC}"
fi

echo ""
echo -e "${GREEN}  ✅ Selesai! Dotfiles berhasil diinstall!${NC}"
echo ""
echo -e "${YELLOW}  📝 Note:${NC}"
echo "  - Config lama disimpan di ~/.config/nama.bak"
echo "  - Restart Hyprland: SUPER + M lalu login lagi"
echo ""
