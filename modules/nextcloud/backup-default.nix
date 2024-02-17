{ self, config, lib, pkgs, ... }: {
  # Based on https://carjorvaz.com/posts/the-holy-grail-nextcloud-setup-made-easy-by-nixos/
  security.acme = {
    acceptTerms = true;
    defaults = {
      email = "justin.lee.gilpin@gmail.com";
      dnsProvider = "cloudflare";
      # location of your CLOUDFLARE_DNS_API_TOKEN=[value]
      # https://www.freedesktop.org/software/systemd/man/latest/systemd.exec.html#EnvironmentFile=
      environmentFile = "/home/justin/cloudflare";
    };
  };
  services = {
    nginx.virtualHosts = {
      "ow0w.com" = { # YOUR.DOMAIN.NAME
        forceSSL = true;
        enableACME = true; 
        # Use DNS Challenege.
        acmeRoot = null;
      };
    };
    # 
    nextcloud = {
      enable = true;
      hostName = "ow0w.com"; # YOUR.DOMAIN.NAME
      # Need to manually increment with every major upgrade. 
      package = pkgs.nextcloud28;
      # Optional Setting: Point directory to storage path
      # Let NixOS install and configure the database automatically.
      database.createLocally = true;
      # Let NixOS install and configure Redis caching automatically.
      configureRedis = true;
      # Increase the maximum file upload size.
      maxUploadSize = "16G";
      https = true;
      autoUpdateApps.enable = true;
      extraOptions = {
        trusted_domains = ["192.168.88.62" "ow0w.com"];
        default_phone_region = "US";
        overwriteprotocol = "https";
      };
      extraAppsEnable = true;
      extraApps = with config.services.nextcloud.package.packages.apps; {
        # List of apps we want to install and are already packaged in
        # https://github.com/NixOS/nixpkgs/blob/master/pkgs/servers/nextcloud/packages/nextcloud-apps.json
        inherit calendar contacts notes onlyoffice tasks cookbook qownnotesapi;
        # Custom app example.
#        socialsharing_telegram = pkgs.fetchNextcloudApp rec {
#          url =
#            "https://github.com/nextcloud-releases/socialsharing/releases/download/v3.0.1/socialsharing_telegram-v3.0.1.tar.gz";
#          license = "agpl3";
#          sha256 = "sha256-8XyOslMmzxmX2QsVzYzIJKNw6rVWJ7uDhU1jaKJ0Q8k=";
#        };
      };
      config = {
        dbtype = "pgsql";
        adminuser = "justin";
        adminpassFile = "${pkgs.writeText "adminpass" "test123"}";
      };
      # Suggested by Nextcloud's health check.
      phpOptions."opcache.interned_strings_buffer" = "16";
    };
    # Nightly database backups.
    postgresqlBackup = {
      enable = true;
      startAt = "*-*-* 01:15:00";
    };
  };
}
