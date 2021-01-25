{ config, pkgs, ... }:

{
  imports = [
    (builtins.fetchTarball "https://github.com/r-raymond/nixos-mailserver/archive/v2.1.3.tar.gz")
  ];

  mailserver = {
    certificateScheme = 3;
    domains           = [ "placki.cloud" ];
    enable            = true;
    enableImap        = true;
    enableImapSsl     = true;
    enableManageSieve = true;
    enablePop3        = true;
    enablePop3Ssl     = true;
    fqdn              = "mx.placki.cloud";
    virusScanning     = false;

    # A list of all login accounts. To create the password hashes, use
    # mkpasswd -m sha-512 "super secret password"
    loginAccounts = {
      "placek@placki.cloud" = {
        hashedPassword = "$6$q0AGrkh0$Kyy2gIZF7yMe5Xvht.q2OV2oM0V9SD.Go.swZhpZ4ChKrAEIBmg.EwHLAS42042wMbIrX/xlvaCuImjcEvmcO/";
        aliases        = [ "postmaster@placki.cloud" ];
        catchAll       = [ "placki.cloud" ];
      };
    };

    # Extra virtual aliases. These are email addresses that are forwarded to
    # loginAccounts addresses.
    extraVirtualAliases = {
        # address = forward address;
        # "abuse@example.com" = "user1@example.com";
    };
  };
}
