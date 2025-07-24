{ config, pkgs, ... }: 

{
  # Basic system settings/prefrences
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
    root.openssh.authorizedKeys.keys = [
        "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC/43wyhH622OG5DGKTHajpCcg08EpSnvs2ZOPEKloM25zR84zjpwxjR4ptwb9+GMhNbN1v47/qCfcOV8rlbh7A/Ycp9DZuBXFxSS7SPkTOlieawZJYtAW7slGC9p2v/g+hZwKPlVK1FJkBQJMHidvivHnTFGUqggSm6S3rZdCRPIQIhEHQCWM1tEOkgT3Wm4E+QIAKBfXCfvGnMjBvYrBGPzjXYchUy/IGBOJgJaRedmUDxHznuIzzpTRBXh2QNP94MXPeNRKM/cIFkZPSVwB0PhMY33JfGAf3eI+VRsMb+0FSWBGaNRrJpn8+OpxurMXmI+Ce7tyG05NLTz5Oj8sb"
      ];
  };

  environment.systemPackages = with pkgs; [
    openssh
  ];

  system.stateVersion = "25.05";
}
