{ users, config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.

  imports = [
    ./alacritty
    ./fuzzel
  ];

  home.username = "talkingfoxmid";
  home.homeDirectory = "/home/talkingfoxmid";
  home.sessionPath = [
    "/home/talkingfoxmid/.scripts/"
  ];
  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.


  home.packages = with pkgs; [
    jetbrains.idea-community
    vlc
    starfetch
    btop
    hyprpaper

    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. If you don't want to manage your shell through Home
  # Manager then you have to manually source 'hm-session-vars.sh' located at
  # either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/talkingfoxmid/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
    NIX_PATH=
    ''
    $HOME/.nix-defexpr/channels:/nix/var/nix/profiles/per-user/root/channels''${NIX_PATH:+:$NIX_PATH}
    '';
    PICULO = "123";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  
  programs.neovim = {
    enable = true;
    extraConfig = 
    ''
    set shiftwidth=2
    '';
  };

  programs.zsh = {
  enable = true;
  initExtra = "starfetch";
  shellAliases = {
    ll = "ls -l";
    update = "sudo nixos-rebuild switch";
  };
  };
  programs.vscode = {
    enable = true;
    userSettings = { "window.titleBarStyle" = "custom"; };
  };

  programs.waybar = {
    enable = true;

    settings = {
      mainBar = {
        position = "bottom";
        monitor = "eDP-1";
        height = 25;
        modules-left = [
          "hyprland/workspaces"
          "river/tags"
          "sway/workspaces"
          "tray"
        ];
	modules-right = [
            "privacy"
            "network"
            "custom/wireguard"
            "custom/teavpn"
            "pulseaudio"
            "battery"
            "custom/date"
            "clock"
          ];
	"privacy" = {
	  "icon-spacing" = 4;
	  "icon-size" = 18;
	  "transition-duration" = 250;
	};
	"pulseaudio" = {
	  "format" = "{icon}{volume}%";
	  "format-muted" = "󰖁";
	  "on-click" = "amixer -q set Master toggle-mute";
	  "format-icons" = [
	    "󰕿"
	    "󰖀"
	    "󰕾"
	  ];
	};
      };
    };
  };
}
