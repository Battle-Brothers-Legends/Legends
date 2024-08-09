::Legends.debugLog <- function()
{
    this.logInfo("Debug Log for Legends Mod");
   this.logInfo("Legends exists: " + ("Legends" in getroottable()));
   this.logInfo("Legends.Mod exists: " + ("Mod" in ::Legends));
    if ("Mod" in ::Legends)
    {
        this.logInfo("Legends.Mod is null: " + (::Legends.Mod == null));
        this.logInfo("Legends.Mod type: " + typeof ::Legends.Mod);
    }
    this.logInfo("LegendsMod exists: " + ("LegendsMod" in getroottable()));
    if ("LegendsMod" in getroottable())
    {
        this.logInfo("LegendsMod.Mod exists: " + ("Mod" in ::LegendsMod));
        if ("Mod" in ::LegendsMod)
        {
            this.logInfo("LegendsMod.Mod is null: " + (::LegendsMod.Mod == null));
            this.logInfo("LegendsMod.Mod type: " + typeof ::LegendsMod.Mod);
        }
    }
}
