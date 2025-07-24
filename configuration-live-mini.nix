{ config, pkgs, ... }: 

{
  # Basic system settings
  nix.extraOptions = "experimental-features = nix-command flakes";
  networking.hostName = "nixos-live";
  programs.fish.enable = true;
  users.defaultUserShell = pkgs.fish;
  console.keyMap = "dvorak";
  time.timeZone = "Europe/Oslo";

  # Preload your SSH key
  users.users = {
    nixos = {
      isNormalUser = true;
      openssh.authorizedKeys.keys = [
        "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC/43wyhH622OG5DGKTHajpCcg08EpSnvs2ZOPEKloM25zR84zjpwxjR4ptwb9+GMhNbN1v47/qCfcOV8rlbh7A/Ycp9DZuBXFxSS7SPkTOlieawZJYtAW7slGC9p2v/g+hZwKPlVK1FJkBQJMHidvivHnTFGUqggSm6S3rZdCRPIQIhEHQCWM1tEOkgT3Wm4E+QIAKBfXCfvGnMjBvYrBGPzjXYchUy/IGBOJgJaRedmUDxHznuIzzpTRBXh2QNP94MXPeNRKM/cIFkZPSVwB0PhMY33JfGAf3eI+VRsMb+0FSWBGaNRrJpn8+OpxurMXmI+Ce7tyG05NLTz5Oj8sb"
      ];
    };
    # Set root password
    root.openssh.authorizedKeys.keys = [
        "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC/43wyhH622OG5DGKTHajpCcg08EpSnvs2ZOPEKloM25zR84zjpwxjR4ptwb9+GMhNbN1v47/qCfcOV8rlbh7A/Ycp9DZuBXFxSS7SPkTOlieawZJYtAW7slGC9p2v/g+hZwKPlVK1FJkBQJMHidvivHnTFGUqggSm6S3rZdCRPIQIhEHQCWM1tEOkgT3Wm4E+QIAKBfXCfvGnMjBvYrBGPzjXYchUy/IGBOJgJaRedmUDxHznuIzzpTRBXh2QNP94MXPeNRKM/cIFkZPSVwB0PhMY33JfGAf3eI+VRsMb+0FSWBGaNRrJpn8+OpxurMXmI+Ce7tyG05NLTz5Oj8sb"
      ];
  };


  # Add necessary packages for the live environment
  environment.systemPackages = with pkgs; [
    openssh
    # Add any other tools needed for installation
  ];

  # VM-specific resources (optional, but recommended)
  virtualisation.vmVariant.virtualisation = {
    memorySize = 1024;
    cores = 1;
    diskSize = 8192; # 8GB disk size for the live environment
    # Forward SSH port for remote access
    forwardPorts = [
      { from = "host"; host.port = 2222; guest.port = 22; }
    ];
  };

  system.stateVersion = "25.05";
}
