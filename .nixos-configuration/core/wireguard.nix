
{ config, pkgs, lib, ... }: 
{
  networking.wg-quick.interfaces = {
    wg0 = {
      address = [ "10.8.0.7/24" ];
      dns = [ "1.1.1.1" ];
      privateKey = "QE+w6yWjoc3DcQQltc24xiM6ElDQn2KnP/+1mZ4WBlM=";
      
      peers = [
        {
          publicKey = "1VpBkKP/x2IwpkvkwIa15S1efqNxX4i8U4kMTUn+Vkg=";
          presharedKey = "VixSPwre05YqgSxf8qC9JDFKbnEhuiBayS57aOR1ob0=";
          allowedIPs = [ "0.0.0.0/0" "::/0" ];
          endpoint = "minecraft.wlappa.work:51820";
          persistentKeepalive = 25;
        }
      ];
    };
  };
}
