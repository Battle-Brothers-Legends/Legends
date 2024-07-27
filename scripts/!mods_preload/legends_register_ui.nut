::Const.LegendMod.registerUI <- function()
{
	// formations
	::mods_registerJS("screens/character/modules/character_screen_right_panel/character_screen_formations_module.js");
	::mods_registerCSS("screens/character/modules/character_screen_right_panel/character_screen_formations_module.css");

	// camp screen
	::mods_registerJS("screens/world/modules/camp/camp_screen_main_dialog_module.js");
	::mods_registerJS("screens/world/modules/camp/camp_screen_commander_dialog_module.js");
	::mods_registerJS("screens/world/modules/camp/camp_screen_crafting_dialog_module.js");
	::mods_registerJS("screens/world/modules/camp/camp_screen_fletcher_dialog_module.js");
	::mods_registerJS("screens/world/modules/camp/camp_screen_gatherer_dialog_module.js");
	::mods_registerJS("screens/world/modules/camp/camp_screen_healer_dialog_module.js");
	::mods_registerJS("screens/world/modules/camp/camp_screen_hunter_dialog_module.js");
	::mods_registerJS("screens/world/modules/camp/camp_screen_painter_dialog_module.js");
	::mods_registerJS("screens/world/modules/camp/camp_screen_repair_dialog_module.js");
	::mods_registerJS("screens/world/modules/camp/camp_screen_rest_dialog_module.js");
	::mods_registerJS("screens/world/modules/camp/camp_screen_scout_dialog_module.js");
	::mods_registerJS("screens/world/modules/camp/camp_screen_training_dialog_module.js");
	::mods_registerJS("screens/world/modules/camp/camp_screen_workshop_dialog_module.js");
	::mods_registerJS("screens/world/modules/camp/camp_screen_trader_dialog_module.js");
	::mods_registerJS("screens/world/modules/camp/camp_screen_recruit_dialog_module.js");
	::mods_registerJS("screens/world/camp_screen.js");

	::mods_registerCSS("screens/world/modules/camp/camp_screen_commander_dialog_module.css");
	::mods_registerCSS("screens/world/modules/camp/camp_screen_crafting_dialog_module.css");
	::mods_registerCSS("screens/world/modules/camp/camp_screen_fletcher_dialog_module.css");
	::mods_registerCSS("screens/world/modules/camp/camp_screen_gatherer_dialog_module.css");
	::mods_registerCSS("screens/world/modules/camp/camp_screen_healer_dialog_module.css");
	::mods_registerCSS("screens/world/modules/camp/camp_screen_hunter_dialog_module.css");
	::mods_registerCSS("screens/world/modules/camp/camp_screen_painter_dialog_module.css");
	::mods_registerCSS("screens/world/modules/camp/camp_screen_repair_dialog_module.css");
	::mods_registerCSS("screens/world/modules/camp/camp_screen_rest_dialog_module.css");
	::mods_registerCSS("screens/world/modules/camp/camp_screen_scout_dialog_module.css");
	::mods_registerCSS("screens/world/modules/camp/camp_screen_training_dialog_module.css");
	::mods_registerCSS("screens/world/modules/camp/camp_screen_workshop_dialog_module.css");
	::mods_registerCSS("screens/world/modules/camp/camp_screen_main_dialog_module.css");
	::mods_registerCSS("screens/world/modules/camp/camp_screen_trader_module.css");
	::mods_registerCSS("screens/world/modules/camp/camp_screen_recruit_module.css");
	::mods_registerCSS("screens/world/camp_screen.css");

	delete ::Const.LegendMod.registerUI;
}