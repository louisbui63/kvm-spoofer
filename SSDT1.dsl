/*
 * Intel ACPI Component Architecture
 * AML/ASL+ Disassembler version 20240827 (64-bit version)
 * Copyright (c) 2000 - 2023 Intel Corporation
 * 
 * Disassembling to symbolic ASL+ operators
 *
 * Disassembly of SSDT1.aml
 *
 * Original Table Header:
 *     Signature        "SSDT"
 *     Length           0x000000A1 (161)
 *     Revision         0x01
 *     Checksum         0xE2
 *     OEM ID           "BOCHS"
 *     OEM Table ID     "BXPCSSDT"
 *     OEM Revision     0x00000001 (1)
 *     Compiler ID      "INTL"
 *     Compiler Version 0x20240827 (539232295)
 */
// A battery, to trick the Nvidia rivers into actually working (if you have a mobile GPU and hide/disable the HyperV CPUID interface)
// Based on the one available on the ArchWiki / https://www.reddit.com/r/VFIO/comments/ebo2uk/nvidia_geforce_rtx_2060_mobile_success_qemu_ovmf/
DefinitionBlock ("", "SSDT", 1, "INTEL", "INTEL", 0x00000001)
{
    External (_SB_.PCI0, DeviceObj)

    Scope (_SB.PCI0)
    {
        Device (BAT0)
        {
            Name (_HID, EisaId ("PNP0C0A") /* Control Method Battery */)  // _HID: Hardware ID
            Name (_UID, Zero)  // _UID: Unique ID
            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                Return (0x1F)
            }

            Method (_BIF, 0, NotSerialized)  // _BIF: Battery Information
            {
                Return (Package (0x0D)
                {
                    One, 
                    0x1770, 
                    0x1770, 
                    One, 
                    0x39D0, 
                    0x0258, 
                    0x012C, 
                    0x3C, 
                    0x3C, 
                    "", 
                    "", 
                    "LION", 
                    ""
                })
            }

            Method (_BST, 0, NotSerialized)  // _BST: Battery Status
            {
                Return (Package (0x04)
                {
                    Zero, 
                    Zero, 
                    0x1770, 
                    0x39D0
                })
            }
        }
    }
}

