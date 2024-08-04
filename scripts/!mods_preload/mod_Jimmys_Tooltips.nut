::ModJimmysTooltips <- {
	ID = "mod_Jimmys_Tooltips",
	Name = "ModJimmysTooltips",
	Version = "1.0.5"
}
::ModJimmysTooltips.ModHook <- ::Hooks.register(::ModJimmysTooltips.ID, ::ModJimmysTooltips.Version, ::ModJimmysTooltips.Name);
::ModJimmysTooltips.ModHook.require("mod_legends >= 18.2.5", "mod_modern_hooks >= 0.4.10");
::ModJimmysTooltips.ModHook.queue(">mod_legends",function()
{
	::ModJimmysTooltips.Mod <- Mod(::ModJimmysTooltips.ID, ::ModJimmysTooltips.Version, ::ModJimmysTooltips.Name);
	local page = ::ModJimmysTooltips.Mod.ModSettings.addPage("page_one", "Jimmy's Tactical Tooltip");
	page.addTitle("title", "You can edit what you see on the Tactical Tooltip");
	page.addDivider("divider");
	page.addBooleanSetting("DefaultTooltip", false);
	page.addBooleanSetting("ProgressBarValues", true);
	page.addBooleanSetting("Items", true);
	page.addBooleanSetting("ItemDurability", true);
	page.addBooleanSetting("Skills", true);
	page.addBooleanSetting("Stats", true);

	foreach (file in ::IO.enumerateFiles("hooks/tt_hooks/config"))
	{
		::include(file);
	}

	// load keybinds
	::include("hooks/tt_hooks/keybinds.nut");

	foreach (file in ::IO.enumerateFiles("hooks/tt_hooks/hooks"))
	{
		::include(file);
	}
});


