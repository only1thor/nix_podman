{ config, pkgs, ... }: 

{
  imports = [
    # Import the docker-compose service definition
    ./docker-compose.nix
    ./hardware-configuration.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.initrd.systemd.enable = true;
  boot.initrd.systemd.emergencyAccess = true;

  # Basic system settings
  console.keyMap = "dvorak";
  networking.hostName = "my-hostname";
  time.timeZone = "Europe/Oslo";

  users.users.test = {
    isNormalUser = true;
    initialPassword = "test";
    extraGroups = [ "wheel" "podman" ];
  };

  # Add navidrome user with specific UID/GID
  users.users.navidrome = {
    isSystemUser = true;
    uid = 1234;
    group = "navidrome";
  };

  users.groups.navidrome = {
    gid = 1234;
  };

  # Create podman data directory with correct ownership
  systemd.tmpfiles.rules = [
    "d /podman/navidrome_data 0755 1234 1234 -"
    "d /podman/navidrome_music 0755 1234 1234 -"
  ];

  # One-time service to download music on first boot
  systemd.services.navidrome-music-download = {
    description = "Download music for Navidrome on first boot";
    wantedBy = [ "multi-user.target" ];
    after = [ "network-online.target" ];
    wants = [ "network-online.target" ];

    serviceConfig = {
      Type = "oneshot";
      User = "navidrome";
      Group = "navidrome";
      WorkingDirectory = "/podman/navidrome_music";
      ExecStart = "${pkgs.yt-dlp}/bin/yt-dlp --extract-audio --audio-quality 0 --add-metadata --embed-subs --embed-thumbnail --write-description --write-annotations https://soundcloud.com/lofi_girl/sets/synthwave-ambient-chill-music";
      # Ensure this only runs once
      ExecStartPost = "${pkgs.coreutils}/bin/touch /var/lib/navidrome-music-downloaded";
    };

    # Only run if the flag file doesn't exist
    unitConfig.ConditionPathExists = "!/var/lib/navidrome-music-downloaded";
  };

  networking.firewall.allowedTCPPorts = [ 8080 ];

  # VM-specific resources (optional, but recommended)
  virtualisation.vmVariant.virtualisation = {
    memorySize = 1024;
    cores = 1;
    # Increase disk space to 8GB (default is usually 512MB)
    diskSize = 8192;
    # Forward host port 8080 to VM port 8080
    forwardPorts = [
      { from = "host"; host.port = 8080; guest.port = 8080; }
      { from = "host"; host.port = 8081; guest.port = 5080; }
    ];
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  system.stateVersion = "25.05";
}
