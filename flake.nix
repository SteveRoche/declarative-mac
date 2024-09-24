{
  description = "Steve's Macbook flake";
  # Remote install - untested
  # $ curl \ --proto '=https' \ --tlsv1.2 \ -sSf \ -L https://install.determinate.systems/nix \ | sh -s -- install
  # $ nix run nix-darwin -- --flake github:SteveRoche/declarative-mac/master

  # Update system
  # $ nix flake update
  # $ darwin-rebuild switch --flake ~/.config/nix-darwin

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs @ {
    self,
    nix-darwin,
    nixpkgs,
    home-manager,
    ...
  }: let
    configuration = {pkgs, ...}: {
      environment.systemPackages = with pkgs; [
        # Tools
        wget
        tree
        neofetch
        jq
        ripgrep
        fzf
        unixtools.watch
        lf
        fd
        zoxide
        just

        # Git
        gitAndTools.gitFull
        gh
        lazygit

        # Editors
        vim
        neovim

        # Languages and language tools
        zig
        zls
        alejandra
        lua-language-server
        # texlive.combined.scheme-medium
        (texlive.combine { inherit (texlive) scheme-medium
          titlesec textpos isodate substr; })

        nodejs_20
        nodePackages.pnpm

        # Containerization
        podman
        kind
        kubectl
        kustomize_4
        kubernetes-helm
      ];

      # Auto upgrade nix package and the daemon service.
      services.nix-daemon.enable = true;
      # nix.package = pkgs.nix;

      # Necessary for using flakes on this system.
      nix.settings.experimental-features = "nix-command flakes";

      # Support Rosetta
      # $ softwareupdate --install-rosetta --agree-to-license
      nix.extraOptions = ''
        extra-platforms = x86_64-darwin aarch64-darwin
      '';

      # Create /etc/zshrc that loads the nix-darwin environment.
      programs.zsh.enable = true; # default shell on catalina
      # programs.fish.enable = true;

      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;

      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 4;

      # The platform the configuration will be used on.
      nixpkgs.hostPlatform = "aarch64-darwin";

      nixpkgs.config.allowUnfree = true;

      # Enable sudo using Touch ID
      security.pam.enableSudoTouchIdAuth = true;

      system.defaults = {
        NSGlobalDomain = {
          ApplePressAndHoldEnabled = false;
        };
        dock = {
          autohide = true;
          mru-spaces = false;
          magnification = true;
          persistent-apps = [
            "/Applications/Arc.app"
            "/Applications/TickTick.app"
            "/Applications/Obsidian.app"
            "/Applications/iTerm.app"
            "/Applications/Visual Studio Code.app"
          ];
          minimize-to-application = true;
          persistent-others = [];
          show-recents = false;
          tilesize = 48;
          largesize = 72;
        };
        finder = {
          AppleShowAllExtensions = true;
          AppleShowAllFiles = true; # Show hidden files
          CreateDesktop = true;
        };
        screensaver.askForPasswordDelay = 10; # seconds
        screencapture.location = "~/Pictures/Screenshots";
      };

      system.keyboard.enableKeyMapping = true;
      system.keyboard.remapCapsLockToEscape = true;
      users.users.steve.home = "/Users/steve";

      homebrew = {
        enable = true;
        onActivation = {
          autoUpdate = true;
          cleanup = "uninstall";
          upgrade = true;
        };
        taps = [ "cfergeau/crc" ];
        brews = [
          "vfkit" # https://github.com/NixOS/nixpkgs/issues/305868
        ];
        casks = [
          "obsidian"
          "raycast"
          "proton-pass"
          "protonvpn"
          "proton-mail"
          "proton-drive"
          "arc"
          "ticktick"
          "whatsapp"
          "blender"
          "discord"
          "keepingyouawake"
          "steam"
          # "unnaturalscrollwheels"

          # GUI developer tools
          "iterm2"
          "visual-studio-code"
          "github"
          "imhex"

          # Fonts
          "font-fragment-mono"
          "font-fira-code-nerd-font"
        ];
      };
    };
  in {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#Steves-MacBook-Pro
    darwinConfigurations."Steves-MacBook-Pro" = nix-darwin.lib.darwinSystem {
      system = "aarch64-darwin";
      modules = [
        configuration
        home-manager.darwinModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.steve = import ./home.nix;
        }
      ];
    };

    # Expose the package set, including overlays, for convenience.
    darwinPackages = self.darwinConfigurations."Steves-MacBook-Pro".pkgs;
  };
}
