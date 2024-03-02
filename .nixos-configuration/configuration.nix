# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./hyprland.nix
      ./display-manager.nix
    ];
  nix.settings.experimental-features = ["nix-command" "flakes"];
  virtualisation.docker.enable = true;
  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
  };
  system.activationScripts.ldso = lib.stringAfter [ "usrbinenv" ] ''
            mkdir -m 0755 -p /lib64
            ln -sfn ${pkgs.glibc.out}/lib64/ld-linux-x86-64.so.2 /lib64/ld-linux-x86-64.so.2.tmp
            mv -f /lib64/ld-linux-x86-64.so.2.tmp /lib64/ld-linux-x86-64.so.2 # atomically replace
          '';
  # Android 
  programs.adb.enable = true;
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Yekaterinburg";
  sound.enable = true;
  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "ru_RU.UTF-8";
    LC_IDENTIFICATION = "ru_RU.UTF-8";
    LC_MEASUREMENT = "ru_RU.UTF-8";
    LC_MONETARY = "ru_RU.UTF-8";
    LC_NAME = "ru_RU.UTF-8";
    LC_NUMERIC = "ru_RU.UTF-8";
    LC_PAPER = "ru_RU.UTF-8";
    LC_TELEPHONE = "ru_RU.UTF-8";
    LC_TIME = "ru_RU.UTF-8";
  };

  hardware.pulseaudio.enable = true;
  hardware.pulseaudio.support32Bit = true;
  nixpkgs.config.pulseaudio=true;
  nixpkgs.config.permittedInsecurePackages = ["electron-25.9.0"];
  hardware.pulseaudio.extraConfig = "load-module module-combine-sink";
  # Configure keymap in X11

  # Define a user account. Don't forget to set a password with ‘passwd’.
  programs.zsh.enable = true;
  users.users.talkingfoxmid = {
    isNormalUser = true;
    shell = pkgs.zsh;
    description = "talkingfoxmid";
    extraGroups = [ "networkmanager" "wheel" "audio" "docker" "adbusers" ];
    packages = with pkgs; [];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
	programs.gnupg.agent = {                                                      
	  enable = true;
	  enableSSHSupport = true;
	  pinentryFlavor = "qt";
	};
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.pathsToLink = ["libexec"];
  nixpkgs.config.zathura.useMupdf = true;
  environment.systemPackages = with pkgs; [
    neovim
    kubectl
    python3
    youtube-dl
    neo4j
    neo4j-desktop
    bloomrpc
    patchelf
    protobuf3_20
    transmission_4-gtk
    zathura
    qrencode
    feh
    pass
    gnupg
    discord
    pkgs.jdk
    pkgs.jetbrains.idea-community
    obsidian
    vscode
    pavucontrol
    rxvt-unicode
    pkgs.chromium
    tdesktop
    git
    ranger
    picom
  #  wget
  ];
  services.picom = {
    enable = true;
    activeOpacity = 0.90;
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?
}


