# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).
{ pkgs, settings, ... }:

{

  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./disko-configuration.nix
    ./system
    ./stylix
    ./gaming
  ];

  nix.settings = {
    substituters = [ "https://hyprland.cachix.org" ];
    trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
  };

  networking = {
    hostName = settings.hostname;
    networkmanager.enable = true;
  };
  # Set your time zone.
  time.timeZone = settings.timeZone;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = settings.locale;
  console = {
    # Make fonts readable from the boot start
    # earlySetup = true;
    # ter-<CODE_PAGE=1|2|9|c|d|g|i|k|m|p|u|v><SIZE><STYLE=n|b|f>
    font = "ter-v32n";
    packages = with pkgs; [ terminus_font ];
    keyMap = "us";
    # useXkbConfig = true; # use xkb.options in tty.
  };

  services.gnome.gnome-keyring.enable = true;
  security = {
    polkit.enable = true;
    pam.services = {
      login.u2fAuth = true;
      sudo.u2fAuth = true;
      sddm = {
        enableGnomeKeyring = true;
      };
    };
  };
  services.pcscd.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${settings.username} = {
    description = settings.name;
    isNormalUser = true;
    extraGroups = [
      "audio"
      "i2c"
      "wheel"
      "bluetooth"
      "network"
      "networkmanager"
      "scanner"
      "lp"
    ];
  };

  programs.git.enable = true;
  programs.lazygit.enable = true;
  programs.fzf.fuzzyCompletion = true;

  programs._1password.enable = true;
  programs._1password-gui = {
    enable = true;
    # Certain features, including CLI integration and system authentication support,
    # require enabling PolKit integration on some desktop environments (e.g. Plasma).
    polkitPolicyOwners = [ settings.username ];
    package = pkgs._1password-gui-beta;
  };

  environment.etc = {
    "1password/custom_allowed_browsers" = {
      text = ''
        firefox
        chromium
        zen
        zen-beta
      '';
      mode = "0755";
    };
  };

  programs.ssh = {
    extraConfig = ''
      Host *
        IdentityAgent /home/${settings.username}/.1password/agent.sock
    '';
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  boot.kernelParams = [ "resume_offset=${settings.swap.offset}" ];
  boot.resumeDevice = "/dev/disk/by-uuid/${settings.swap.uuid}";

  powerManagement.enable = true;

  swapDevices = [
    {
      device = "/swapfile";
      size = settings.swap.size;
    }
  ];

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

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "24.05"; # Did you read the comment?

}
# vim:et:sw=2:ts=2:sta:nu
