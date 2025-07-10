{ config, pkgs, ... }: 

{
  imports = [
    # Import the docker-compose service definition
    ./docker-compose.nix
  ];

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
  

  
  environment.systemPackages = with pkgs; [
    yt-dlp
  ];

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
