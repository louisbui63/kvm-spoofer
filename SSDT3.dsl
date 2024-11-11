// CPU fan
DefinitionBlock ("", "SSDT", 3, "INTEL", "INTEL", 0x00000001)
{
    Scope (_SB)
    {
        Device (FAN0)
        {
            Name (_HID, EisaId ("PNP0C0B") )  // _HID: Hardware ID
            Name (_UID, 0x1235)  // _UID: Unique ID

            Method (_FIF, 0, NotSerialized)
            {
                Return (Package(0x04) {
                    Zero, // revision
                    One, // fine grain control
                    0x64, // step size
                    Zero // Low speed notification support
                })
            }

            Method (_FPS, 0, NotSerialized)
            {
                Return (Package (0x3) {
                    Zero, // revision
                    Package (0x5) {
                        Zero,           // Control,     // Integer DWORD
                        Zero,    // TripPoint,   // Integer DWORD
                        Zero,            // Speed,       // Integer DWORD
                        Zero,                // NoiseLevel,  // Integer DWORD (optional)
                        Zero                // Power        // Integer DWORD (optional)
                    },
                    Package (0x5) {
                        0x01,           // Control,     // Integer DWORD
                        0x46,    // TripPoint,   // Integer DWORD
                        0x200,           // Speed,       // Integer DWORD
                        0x10,                // NoiseLevel,  // Integer DWORD (optional)
                        0x3,               // Power        // Integer DWORD (optional)
                    }

                })
            }

            Method (_FSL, 1, NotSerialized)
            {
                Store (Arg0, Local0)
                // this is just a placeholder, we don't really control any fan
            }


            Method (_FST, 0, NotSerialized)
            {
                Return (Package(0x03) {
                    Zero, // revision
                    0x01, // control
                    0x200 // speed
                })
            }

        }
    }
}

