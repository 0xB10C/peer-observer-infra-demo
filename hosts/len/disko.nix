let
  # Retreived with
  # lsblk -o NAME,SIZE,TYPE,ID-LINK -d
  id = "scsi-0QEMU_QEMU_HARDDISK_aefdf7b2-eccd-4b3a-b1ca-6d573c022f22";
  swap = "6G";
in
{
  disko.devices = {
    disk = {
      main = {
        type = "disk";
        device = "/dev/disk/by-id/${id}";
        content = {
          type = "gpt";
          partitions = {
            boot = {
              size = "1M";
              type = "EF02"; # for grub MBR
            };
            ESP = {
              size = "512M";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [ "umask=0077" ];
              };
            };
            swap = {
              size = swap;
              type = "8200";
              content = {
                type = "swap";
              };
            };
            root = {
              size = "100%";
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/";
              };
            };
          };
        };
      };
    };
  };
}
