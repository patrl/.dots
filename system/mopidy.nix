{config, pkgs, ... }:

{


  environment.systemPackages = with pkgs; [
    ncmpcpp
  ];

  services.mopidy = {
    enable = true;
    extensionPackages = [ pkgs.mopidy-spotify pkgs.mopidy-mopify ];
    configuration = ''
      [audio]
      output = pulsesink server=127.0.0.1

      [spotify]
      enabled = true
      username = Phonomancer
      password = N;g1cS<"JL0zC[=h
      client_id = 6cceb417-d7f4-477b-a2d3-4a153c0a78e2
      client_secret = VSeJ161coj-hCoq4HVlBGIpEai7HrWMAIcqE_TomW88=
      bitrate = 320

      [local]
      media_dir = home/patrl/Sync/music
    '';
  };

  hardware.pulseaudio = {
    tcp.enable = true;
    tcp.anonymousClients.allowedIpRanges = [ "127.0.0.1" ];
    };
}
