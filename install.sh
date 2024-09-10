# Untested on a fresh system
nix run nix-darwin -- switch --flake ~/.config/nix-darwin
darwin-rebuild switch --flake ~/.config/nix-darwin
mkdir -p ~/Pictures/Wallpapers
wget -O ~/Pictures/Wallpapers/Fuji.heic https://cdn.dynamicwallpaper.club/wallpapers/gpf7f97jk3b/Fuji.heic

