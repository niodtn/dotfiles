# Driver for ITE IT8613E
{config, ...}: {
  boot = {
    kernelParams = ["acpi_enforce_resources=lax"];

    # IT87
    extraModulePackages = with config.boot.kernelPackages; [
      it87
    ];
    kernelModules = ["it87"];
    extraModprobeConfig = ''
      options it87 ignore_resource_conflict=1 force_id=0x8613
    '';
  };
}
