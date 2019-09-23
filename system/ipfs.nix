{ config, lib, ... }:

{
  services.ipfs.enable = true;
  services.ipfs.extraFlags = [ "--writable" ];
}
