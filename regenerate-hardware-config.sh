 #!/usr/var/env bash
 sudo rm -f hardware-configuration.nix
 sudo nixos-generate-config --show-hardware-config > hardware-configuration.nix
 echo "Hardware configuration regenerated"
 