::Legends <- {
	ID = "mod_legends",
	Version = "18.2.7",
	Name = "Legends Mod",
	BuildName = "Chickens & Demons"
};

if (!("MSU" in this.getroottable()) || ::MSU.SemVer.compare(::MSU.SemVer.getTable(::MSU.Version), ::MSU.SemVer.getTable("1.3.0")) >= 0 && !("Hooks" in this.getroottable()))
	::mods_registerMod(::Legends.ID, 18, ::Legends.Name);
else
	::mods_registerMod(::Legends.ID, ::Legends.Version, ::Legends.Name);

::mods_queue(::Legends.ID, "mod_msu(>=1.2.6), vanilla(>=1.5.0-15), dlc_lindwurm, dlc_unhold, dlc_wildmen, dlc_desert, dlc_paladins", function()
{
	::Legends.Mod <- ::MSU.Class.Mod(::Legends.ID, ::Legends.Version, ::Legends.Name);

	::LegendsMod <- this.new("scripts/mods/legends_mod")
	::Legends.Mod.Registry.addModSource(::MSU.System.Registry.ModSourceDomain.GitHub, "https://github.com/Battle-Brothers-Legends/Legends-Bugs");
    ::Legends.Mod.Registry.setUpdateSource(::MSU.System.Registry.ModSourceDomain.GitHub);

    // loading mod files
    ::include("mod_legends/load.nut");
    
	::Const.LegendMod.registerUI();
	::Const.Perks.updatePerkGroupTooltips();
});
