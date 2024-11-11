// Placeholder S0, S3 and S4 sleep(ing) states. Do not ever try to hibernate with those, they are just there to trick apps who rely on their absence for vm detection
DefinitionBlock ("", "SSDT", 2, "INTEL", "INTEL", 0x00000001)
{
    Name (_S0, Package (0x04)
    {
        Zero, 
        Zero, 
        Zero, 
        Zero
    })

    Name (_S3, Package (0x04)
    {
        0x05, 
        Zero, 
        Zero, 
        Zero
    })

    Name (_S4, Package (0x04)
    {
        0x06, 
        Zero, 
        Zero, 
        Zero
    })
}

