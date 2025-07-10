{ config, pkgs, ... }: 

{
  imports = [
    # Import the docker-compose service definition
    ./docker-compose.nix
  ];

  # Basic system settings
  networking.hostName = "my-hostname";
  time.timeZone = "Europe/Oslo";

  users.users.test = {
    isNormalUser = true;
    initialPassword = "test";
    extraGroups = [ "wheel" "podman" ];
  };

  # Enable SSH for testing (optional)
  services.openssh.enable = true;

  networking.firewall.allowedTCPPorts = [ 8080 ];

  # VM-specific resources (optional, but recommended)
  virtualisation.vmVariant.virtualisation = {
    memorySize = 1024;
    cores = 1;
  };
  
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  system.stateVersion = "25.05";
}
