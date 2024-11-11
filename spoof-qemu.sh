#!/bin/env bash
# patch QEMU sourcecode for spoofing. Tested with QEMU 9.9.1
# be careful if you want to put # in one of thoses strings, it is used as the seperator for sed
# this is probably somewhat incomplete, and besides, you would have to take other steps to completely spoof your vm (eg. manage vm_exit on rdstc in your kernel)
# Dependencies: bash, sed (works with GNU sed 4.9), find, install
# If you did something wrong reset the qemu repo with `git reverse .` and then `git submodule foreach git reset --hard`

# this one is 80GB, try to match your vm
export harddisk="Toshiba MK8026GAX"
export dvdrom_man="Plextor"
export dvdrom="Plextor PX-891SAF"
export cdrom="Plextor PX-891SAF"
export microdrive="Ge Jasho97930"

# probably must be 12 bytes
export kvm_sign="UWUUWUUWUUWU"

# max 32 bytes
export bochs="UwU Virtual HD Image"
# this is a false NIC adapter so...
export bochs_nic="Intel E810XXVDA2 NIC Adaptor"

# those are essentially the motherboard manufacturer
export biosbochs="DELL"
export bxpc="DELL"
export bxpc_lower="dell"
export bochs_display="vga-display"

export bios_bld_date="12/03/11"
export bios_name="Dell Inc."
export bios_date="09/12/2023"
export bios_release_date="08/07/2011"
export bios_version="1.3.8"

export bios_vendor="Dell Inc."
export bios_revision="0x08000400"
export bios_oem_table="0x30405030324B8440"

# They must be 6 and 8 bytes in lengh respectivelly
export aml_appname6="INTEL "
export aml_appname8="INTEL   "

export acpi_vendor_id_6="INTEL "
export acpi_vendor_id_8="0x2020204c45544e49"
export asl_compiler_id="0x4c544e49"
export asl_compiler_revision="0x20160527"

# for those, try to keep the same size in bytes, just to be sure
export neoqemu="UWUc"
export neoqemu_camel="Uwuc"
export neoqemu_lower="uwuc"

export neobochs="SEGFA"
export neobochs_camel="Segfa"
export neobochs_lower="segfa"

export neokvm="UWU"
export neokvm_camel="Uwu"
export neokvm_lower="uwu"

### GENERAL QEMU
# Here we make sure there is no hardware that's explicitely marked as being QEMU and try to replace it with believeable replacements (eg. the names should match the capabilities as much as possible (just google it))
echo "General QEMU spoofing..."
sed -i "s#\"QEMU HARDDISK\"#\"$harddisk\"#g" ../qemu/hw/ide/core.c
sed -i "s#\"QEMU HARDDISK\"#\"$harddisk\"#g" ../qemu/hw/scsi/scsi-disk.c

sed -i "s#\"QEMU DVD-ROM\"#\"$dvdrom\"#g" ../qemu/hw/ide/core.c
sed -i "s#\"QEMU DVD-ROM\"#\"$dvdrom\"#g" ../qemu/hw/ide/atapi.c

sed -i "s#\"QEMU CD-ROM\"#\"$cdrom\"#g" ../qemu/hw/ide/core.c
sed -i "s#\"QEMU CD-ROM\"#\"$cdrom\"#g" ../qemu/hw/scsi/scsi-disk.c

sed -i "s#\"QEMU MICRODRIVE\"#\"$microdrive\"#g" ../qemu/hw/ide/core.c

sed -i "s#\"QEMU PenPartner Tablet\"#\"$tablet\"#g" ../qemu/hw/usb/dev-wacom.c

sed -i "s#\"QEMU\"#\"$dvdrom_man\"#g" ../qemu/hw/ide/atapi.c

sed -i "s#\"Bochs Virtual HD Image\"#\"$bochs\"#g" ../qemu/block/bochs.c
sed -i "s#\"Bochs Pseudo NIC Adaptor\"#\"$bochs_nic\"#g" ../qemu/roms/ipxe/src/drivers/net/pnic.c

sed -i "s#\"KVMKVMKVM......\"#\"$kvm_sign\"#g" ../qemu/target/i386/kvm/kvm.c

sed -i "s#\"BOCHS \"#\"$aml_appname6\"#g" ../qemu/include/hw/acpi/aml-build.h
sed -i "s#\"BXPC    \"#\"$aml_appname8\"#g" ../qemu/include/hw/acpi/aml-build.h

# maybe we could spoof the model here too
# sed -i "s###g" ../qemu/hw/i386/pc_q35.c

### SEABIOS
# For the BIOS, we want to change its name and the dates involved to some random stuff
echo "SEABIOS spoofing..."
sed -i "s#\"bochs#\"$biosbochs#ig" ../qemu/roms/seabios/src/config.h
sed -i "s#\"BXPC\"#\"$bxpc\"#g" ../qemu/roms/seabios/src/config.h

sed -i "s#\"QEMU/Bochs#\"$bxpc#g" ../qemu/roms/seabios/vgasrc/Kconfig
sed -i "s#\"QEMU#\"$bxpc#g" ../qemu/roms/seabios/vgasrc/Kconfig
sed -i "s#\"qemu#\"$bxpc_lower#g" ../qemu/roms/seabios/vgasrc/Kconfig
sed -i "s#\"bochs#\"$bxpc_lower#g" ../qemu/roms/seabios/vgasrc/Kconfig
sed -i "s#bochs-display#$bochs_display#g" ../qemu/roms/seabios/vgasrc/Kconfig

sed -i "s#\"06/23/99\"#\"$bios_bld_date\"#g" ../qemu/roms/seabios/src/misc.c
sed -i "s#\"SeaBIOS\"#\"$bios_name\"#g" ../qemu/roms/seabios/src/fw/biostables.c
sed -i "s#\"04/01/2014\"#\"$bios_date\"#g" ../qemu/roms/seabios/src/fw/biostables.c
sed -i "s#\"01/01/2011\"#\"$bios_release_date\"#g" ../qemu/roms/seabios/src/fw/smbios.c

### OVMF
# Same thing, different bios
# I spent the whole day trying to debug that, turns out qemu doesn't compile them, and just pull them from the internet pre-compiled, so you will have to do it yourself (see ./compile-edk.sh)
echo "OVMF spoofing..."
sed -i '/^\[build\.ovmf\.i386\]/a pcds = commonopt' ../qemu/roms/edk2-build.config
sed -i '/^\[build\.ovmf\.i386\.secure\]/a pcds = commonopt' ../qemu/roms/edk2-build.config
sed -i '/^\[build\.ovmf\.x86_64\]/a pcds = commonopt' ../qemu/roms/edk2-build.config
sed -i '/^\[build\.ovmf\.x86_64\.secure\]/a pcds = commonopt' ../qemu/roms/edk2-build.config
sed -i '/^\[build\.ovmf\.i386\]/a tgts = RELEASE' ../qemu/roms/edk2-build.config
sed -i '/^\[build\.ovmf\.i386\.secure\]/a tgts = RELEASE' ../qemu/roms/edk2-build.config
sed -i '/^\[build\.ovmf\.x86_64\]/a tgts = RELEASE' ../qemu/roms/edk2-build.config
sed -i '/^\[build\.ovmf\.x86_64\.secure\]/a tgts = RELEASE' ../qemu/roms/edk2-build.config


# See MdeModulePkg.dec for the Pcd handles
echo ""                                                             >> ../qemu/roms/edk2-build.config
echo "[pcds.commonopt]"                                             >> ../qemu/roms/edk2-build.config
echo "PcdFirmwareVendor             = L$bios_vendor\\0"             >> ../qemu/roms/edk2-build.config
echo "PcdFirmwareVersionString      = L$bios_version\\0"            >> ../qemu/roms/edk2-build.config
echo "PcdFirmwareRevision           = $bios_revision"               >> ../qemu/roms/edk2-build.config
echo "PcdFirmwareReleaseDateString  = L$bios_release_date\\0"       >> ../qemu/roms/edk2-build.config
echo "PcdAcpiDefaultOemId           = $acpi_appname6"               >> ../qemu/roms/edk2-build.config #uggnienviev
echo "PcdAcpiDefaultOemTableId      = $acpi_vendor_id_8"            >> ../qemu/roms/edk2-build.config
echo "PcdAcpiDefaultCreatorId       = $asl_compiler_id"             >> ../qemu/roms/edk2-build.config
echo "PcdAcpiDefaultCreatorRevision = $asl_compiler_revision"       >> ../qemu/roms/edk2-build.config

# sed -i "s#\"EFI Development Kit II / OVMF#\"$bios_name#g" ../qemu/roms/edk2/OvmfPkg/Bhyve/SmbiosPlatformDxe/SmbiosPlatformDxe.c
# sed -i "s#\"0.0.0#\"$bios_version#g" ../qemu/roms/edk2/OvmfPkg/Bhyve/SmbiosPlatformDxe/SmbiosPlatformDxe.c
# sed -i "s#\"02/06/2015#\"$bios_release_date#g" ../qemu/roms/edk2/OvmfPkg/Bhyve/SmbiosPlatformDxe/SmbiosPlatformDxe.c
# The (default) PCD is defined in the .dec file
# sed -i "s#\"EDK II\"#\"$bios_vendor\"#g" ../qemu/roms/edk2/MdeModulePkg/MdeModulePkg.dec
# sed -i "s#PcdFirmwareRevision|0x00010000#PcdFirmwareRevision|$bios_revision#g" ../qemu/roms/edk2/MdeModulePkg/MdeModulePkg.dec
# sed -i "s#PcdFirmwareVersionString|L\"\"#PcdFirmwareVersionString|L\"$bios_version\"#g" ../qemu/roms/edk2/MdeModulePkg/MdeModulePkg.dec
# sed -i "s#PcdFirmwareReleaseDateString|L\"\"#PcdFirmwareReleaseDateString|L\"$bios_release_date\"#g" ../qemu/roms/edk2/MdeModulePkg/MdeModulePkg.dec
#
# sed -i "s#PcdAcpiDefaultOemTableId|0x20202020324B4445#PcdAcpiDefaultOemTableId|$bios_oem_table#g" ../qemu/roms/edk2/MdeModulePkg/MdeModulePkg.dec
# OvmfPkg/QemuVideoDxe/ComponentName.c
# ../qemu/roms/edk2/OvmfPkg/OvmfPkg.dec
# https://gitlab.com/DonnerPartyOf1/kvm-hidden/-/blob/master/edk2.patch?ref_type=heads
# Also apparently we add --pcd entries to the call to ./build

### Bruteforce, essentially
# this currently breaks uefi(somehow), do not use
echo "Remove most references to QEMU"
modif_files() {
  ext=${1##*.}
  if [[ "$ext" == "c" ]] || [[ "$ext" == "h" ]]; then
    sed -i "s#\"QEMU\"#\"$neoqemu\"#g" "$1"
    sed -i "s#\"QEMU #\"$neoqemu #g" "$1"
  fi
}
export -f modif_files
# find ../qemu -depth -type f -exec bash -c 'modif_files "{}"' \;
