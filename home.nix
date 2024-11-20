{
  config,
  pkgs,
  ...
}: {
  home.username = "steve";
  home.stateVersion = "24.05";

  home.packages = with pkgs; [];

  home.file = {
    ".zprofile".source = ./dotfiles/.zprofile;
    ".zshrc".source = ./dotfiles/.zshrc;
    ".zshenv".source = ./dotfiles/.zshenv;
    ".p10k.zsh".source = ./dotfiles/.p10k.zsh;
    ".gitconfig".source = ./dotfiles/.gitconfig;

    ".config/helix/config.toml".source = ./dotfiles/helix/config.toml;
    ".config/lf/lc.sh".source = ./dotfiles/lf/lc.sh;
    ".config/nvim" = {
      source = ./dotfiles/nvim;
      recursive = true;
    };
    # "file".text = '' '';
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    DOCKER_HOST = "unix:///tmp/podman/podman-machine-default-api.sock";
  };

  programs.home-manager.enable = true;

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
  };
}
