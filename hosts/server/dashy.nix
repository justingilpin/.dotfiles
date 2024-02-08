{ config, pkgs, lib, ... }: {

  virtualisation.oci-containers.containers = {


    dashy = {
      image = "lissy93/dashy";
      ports = [ "192.168.88.59:9090:80" ];
      volumes = [ "/home/user/.config/dashy/conf.yml:/app/public/conf.yml" ];
    };
    };

  systemd.services.docker-dashy.serviceConfig.TimeoutStopSec = lib.mkForce 15;
}
