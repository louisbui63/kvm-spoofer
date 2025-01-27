// Placeholder S0, S1, S2, S3 and S4 sleep(ing) states. Do not ever try to hibernate with those, they are just there to trick apps who rely on their absence for vm detection
// If you encoounter weird poweron/off issues, consider disabling fast startup on Windows.
DefinitionBlock ("", "SSDT", 2, "INTEL", "INTEL", 0x00000001)
{
    Name (_S0, Package() {0, 0})   // Fully powered on
    Name (_S1, Package() {1, 1})   // Light sleep
    Name (_S2, Package() {2, 2})   // Deeper sleep
    Name (_S3, Package() {3, 3})   // Suspend to RAM
    Name (_S4, Package() {4, 4})   // Hibernate

    Method (_PTS, 1)
    {
        // Prepare to sleep logic
    }

    Method (_TTS, 1)
    {
    }

    Method (_WAK, 1)
    {
        Local0 = Package (0x02) 
            {
                0x0,
                0x0
            }
        Local0[1] = Arg0
        Return (Local0)
    }

    // Device (DEV0)
    // {
    //     Name (_PRW, Package() {0x0D, 0x03}) // GPE and wake level
    // }
}

