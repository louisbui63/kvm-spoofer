# KVM-QEMU-libvirt VM Spoofer

## Patching QEMU and the EDK2 UEFI
see `spoof-qemu.sh`, then compile your changes with `compile_qemu.sh` and `compile_edk.sh`

## Custom SSDTs
those are used to trick the UEFI into reporting the presence of specialised hardware.
* SSDT1 is a laptop battery (useful if you want to PCIE passthrough a mobile Nvidia GPU or if you just want to masquerade as a laptop)
* SSDT2 is an attempt at providing sleep states. Documentation is extremely sparse on the ASL language and on the internals of the sleep states). S4 is currently detected properly by Windows.
* SSDT3 is a CPU fan. Almost every single physical computer out there has at least battery or some sort of cooling device reported by the UEFI. This will not necessarily work for Windows which will not now what to do with it. See `qemu_fan.patch` for a better solution.
