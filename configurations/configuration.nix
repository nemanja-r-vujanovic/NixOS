# Help: man configuration.nix
# Help: nixos-help
# Help: https://search.nixos.org/options
# Packages: https://search.nixos.org/
# Upgrades: https://nixos.org/manual/nixos/stable/#sec-upgrading
# Versions: https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion

{ config, lib, pkgs, ... }:

{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Disable the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = false;
  boot.loader.efi.canTouchEfiVariables = false;
  boot.loader.grub =
  {
    enable = true;
    device = "DISK_TO_BE_CHANGED";
    efiSupport = true;
    efiInstallAsRemovable = true;
  };

  fileSystems."/boot".options =
  [
    "umask=0077"
  ];

  # Configure network connections interactively with nmcli or nmtui.
  networking.networkmanager.enable = true;
  networking.hostName = "HOSTNAME_TO_BE_CHANGED"; # Define your hostname.

  # Set time zone.
  time.timeZone = "TIMEZONE_TO_BE_CHANGED";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  console =
  {
    font = "ter-132b";
    packages = with pkgs; [ terminus_font ];
  };

  # Enable the X11 windowing system.
  services.xserver =
  {
    enable = true;

    # desktopManager.lxqt.enable = true;
    windowManager.i3.enable = true;
    displayManager.lightdm.enable = true;
    displayManager.sessionCommands =
    ''
      xwallpaper --zoom "$HOME/nixos-sync/wallpapers/1.jpg"
      xset r rate 200 35 &

      ${pkgs.xrdb}/bin/xrdb -merge <<EOF
        Xcursor.theme: Vanilla-DMZ
        Xcursor.size: 45
      EOF
    '';

    xkb =
    {
      layout = "me";
      variant = "latinalternatequotes";
    };
  };

  services.xserver.excludePackages =
  [
    pkgs."xterm"
  ];

  # Enable services.
  services.gvfs.enable = true;
  services.udisks2.enable = true;
  security.polkit.enable = true;

  # Enable CUPS for printing.
  # services.printing.enable = true;

  # Enable sound.
  # services.pulseaudio.enable = true;
  # OR
  # services.pipewire =
  # {
  #   enable = true;
  #   pulse.enable = true;
  # };

  # Enable touchpad support.
  services.libinput.enable = true;

  # Define an account. Don't forget to set a password with ‘passwd’.
  users.mutableUsers = true;
  users.users.USERNAME_TO_BE_CHANGED =
  {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’.

    packages = with pkgs;
    [
      tree
    ];
  };

  programs.firefox.enable = false;
  programs.firejail.enable = true;

  # List packages installed in system profile.
  environment.systemPackages =
  [
    pkgs."sudo"
    pkgs."vim"
    pkgs."alacritty"
    pkgs."git"
    pkgs."chromium"
    pkgs."htop"
    pkgs."xwallpaper"
    pkgs."zip"
    pkgs."unzip"
    pkgs."p7zip"
    pkgs."vanilla-dmz"
    pkgs."pcmanfm"
    pkgs."pfetch"
    pkgs."glib"
    pkgs."bash"
    pkgs."gcc"
    pkgs."python3"
    pkgs."picom"
    pkgs."scrot"
    pkgs.lxqt."lxqt-policykit"
  ];

  environment.variables =
  {
    XCURSOR_THEME = "Vanilla-DMZ";
    XCURSOR_SIZE = "45";
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent =
  # {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # SSH intentionally disabled.
  services.openssh.enable = false;

  # Enable the firewall.
  networking.firewall =
  {
    enable = true;
    allowedTCPPorts = [ ];
    allowedUDPPorts = [ ];
  };

  # Copy the configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;
  #
  # This option defines the first version you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases)
  # created on older versions.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system.
  #
  # This value being lower than the current release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes
  # it would make to your configuration and migrated your data accordingly.

  system.stateVersion = "26.05"; # Did you read the comment?
}
