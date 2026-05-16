{ lib, config, ... }:
with lib;
{
  options.patchBtfKernelOption = {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = "Enable CONFIG_DEBUG_INFO_BTF kernel option";
    };
  };

  config = mkIf config.patchBtfKernelOption.enable {
    boot.kernelPatches = [
      {
        # BTF(BTF Type Format) を有効にする
        name = "btf";
        patch = null;
        extraConfig = ''
          DEBUG_INFO_BTF y
        '';
      }
    ];
  };
}
