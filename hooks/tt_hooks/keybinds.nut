
//----------------------------------------------------------------------------------------------
::ModJimmysTooltips.Mod.Keybinds.addDivider("Keybinds");
::ModJimmysTooltips.Mod.Keybinds.addTitle("KeybindsTitle", "Important - Do Not Change");
//----------------------------------------------------------------------------------------------

::ModJimmysTooltips.Mod.Keybinds.addSQKeybind("updateTooltip", "tab", ::MSU.Key.State.Tactical, function() {
	::Tactical.Entities.getFlags().set("ModJimmysTooltips_ShowLootChance", true);
	::Tooltip.reload();
}, "Switch to see loot chance", ::MSU.Key.KeyState.Press, "Holding the keybind to display the chance to loot item from enemy.\n\n[color=" + ::Const.UI.Color.NegativeValue + "]Do not change this[/color]");

::ModJimmysTooltips.Mod.Keybinds.addSQKeybind("resetTooltip", "tab", ::MSU.Key.State.Tactical, function() {
	::Tactical.Entities.getFlags().set("ModJimmysTooltips_ShowLootChance", false);
	::Tooltip.reload();
}, "XXXXXXXXX", ::MSU.Key.KeyState.Release, "This is used to detect if the keybind is no longer pressed.\n\n[color=" + ::Const.UI.Color.NegativeValue + "]Do not change this[/color]");
