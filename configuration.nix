{ config, pkgs, ... }:

{
  services.podman.enable = true;

  systemd.user.services.podman-compose = {
    description = "Podman Compose Services";
    after = [ "network.target" ];
    wantedBy = [ "default.target" ];
    serviceConfig = {
      ExecStart = "${pkgs.podman}/bin/podman-compose -f /path/to/docker-compose.yml up";
      Restart = "always";
      User = "your-unprivileged-user";
      WorkingDirectory = "/home/your-unprivileged-user/your-compose-dir";
    };
  };
}
