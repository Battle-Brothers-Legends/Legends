::Const.LegendMod.addSettings <- function()
{

   this.logInfo("Adding settings for LegendMod ");
    local legendsMod = ::Legends.Mod;
    if (!("ModSettings" in legendsMod))
    {
        legendsMod.ModSettings = ::FU.Class.ModSettings(legendsMod);
    }

    local settings = legendsMod.ModSettings;
    this.logInfo("Adding settings for LegendMod ");
    // Create pages
    local mapPage = settings.addPage("MapOptions", "Map Options");
    local campaignPage = settings.addPage("CampaignOptions", "Campaign Options");
    local loggingPage = settings.addPage("Logging", "Logging Options");

    // Helper function to add components
    local function addCampaignComponent(_page, _setting)
    {
        _setting.getData().NewCampaign <- true;
        _setting.getData().NewCampaignOnly <- true;
        _page.addComponent(_setting);
    }

    // Helper function to add settings
    local function addCampaignSetting(_page, _setting)
    {
        _setting.getData().NewCampaign <- true;
        _setting.getData().NewCampaignOnly <- true;
        _page.addSetting(_setting);
    }

// Setting, Default, Min, Max, Step, Name, Description
//  The Land Mass Ratio     
    addCampaignSetting(mapPage, ::FU.Class.SliderSetting("LandRatio", 50, 45, 70, 1, "Land Mass Ratio", "Minimum land to water ratio for an acceptable map. Default is 50. Going either extremes on this slider can result in map never getting generated."));

// The Water Ratio
    addCampaignSetting(mapPage, ::FU.Class.SliderSetting("Water", 38, 28, 48, 1, "Water", "Impacts how much of the map is water. Small value results in patchy water around the corners of the map. Larger numbers can create a single large island given a low enough land mass ratio."));
    addCampaignSetting(mapPage, ::FU.Class.SliderSetting("Snowline", 85, 75, 95, 1, "Snowline", "Determines where the snowline is generated. Default is 90. This value is inverted. A value of 10 would mean the top 90% of the map is snow."));

// Settlements
    addCampaignSetting(mapPage, ::FU.Class.SliderSetting("Settlements", 19, 19, 27, 1, "Settlements", "Maximum number of settlements. Depending on map size, this will try to add the number of settlements on the slider. It will keep the same ratio of settlement types as default Battle Brothers maps. Minimum distance between settlements is 12 tiles. Vanilla default is 19."));

// Factions
    addCampaignSetting(mapPage, ::FU.Class.SliderSetting("Factions", 3, 1, 6, 1, "Factions", "Maximum number of Factions to try and generate. Depending on map size, this may not add all the factions on the slider."));

// Just a divider
 //   addCampaignComponent(mapPage, ::FU.Class.SettingsDivider("MapDivider1"));

// Stack Citadels
    addCampaignSetting(mapPage, ::FU.Class.ToggleSetting("StackCitadels", false, "Decked Out Citadels", "If enabled, every Citadel will start with all those building attachments map scummers are re-rolling for."));

// All trade locations
    addCampaignSetting(mapPage, ::FU.Class.ToggleSetting("AllTradeLocations", false, "All trade buildings available", "If enabled, ensures there is at least one of each trade location building on the map."));

// Debug 
    addCampaignSetting(mapPage, ::FU.Class.ToggleSetting("DebugMap", false, "(Debug) Show Entire Map", "If enabled, the map will start completely revealed and all enemies and camps will be visible."));

   local campaignPage = settings.addPage("Campaign Options");

// Gender
    addCampaignSetting(campaignPage, ::FU.Class.DropdownSetting("GenderEquality", "Enabled", ["Disabled", "Enabled", "Enabled (Cosmetic)"], "Battle Sisters", "When enabled, most backgrounds will be randomly assigned male or female. Some backgrounds will remain exclusively male or female.\n\n[u]Disabled[/u]\nThe vanilla experience. No backgrounds or enemy encounters with females. (Yes, your friend the Hex is still here!)\n\n[u]Enabled[/u]\nBeing female has gameplay effects.\n\n[u]Enabled (Cosmetic)[/u]\nBeing female has no gameplay effects."));

// Divider
//    addCampaignComponent(campaignPage, ::FU.Class.SettingsDivider("ConfigDivider1"));

// Distance Scaling
    addCampaignSetting(campaignPage, ::FU.Class.ToggleSetting("DistanceScaling", false, "Distance Scaling", "If enabled, enemies will be stronger the further they spawn from civilization. \n\n Detail: Begins at 14 tiles from the nearest town, enemies spawned at 28 tiles will be twice as strong. \n\n This is in addition to other difficulty settings."));

// Skip Camp
    addCampaignSetting(campaignPage, ::FU.Class.ToggleSetting("SkipCamp", true, "Skip Camp Tutorial", "If disabled, you will gradually unlock camping activities by visiting towns. Useful for first playthroughs. \n\n Detail: skips the camp unlock events and ambition, you still need to buy upgrades."));
    
// recruit Scaling
 addCampaignSetting(campaignPage, ::FU.Class.ToggleSetting("RecruitScaling", true, "Recruit Scaling", "If enabled, new recruits will gain levels based on the levels in your party and your renown in the world. \n\n  Details: The maximum level of recruits is increased by half the average level of mercs in your company, averaged with your reputation divided by 1,000. \n\n For example: if your company were all level 10, and your renown was 10,000, new recruits could gain up to 7 levels rounded down. \n\n This in addition to normal recruit level variance."));
   
// Bleeds count as kills
 addCampaignSetting(campaignPage, ::FU.Class.ToggleSetting("BleedKiller", true, "Bleeds Count As Kills", "If enabled, kills by bleeding out are granted to the actor who caused the bleed."));
   
// World economy  
    addCampaignSetting(campaignPage, ::FU.Class.ToggleSetting("WorldEconomy", true, "World Economy", "If enabled, Settlements will actively trade items and resources and can grow or decline in value \n\n  Details: The value of a settlement is now a dynamic value that grows and declines with caravan arrivals and departures, contracts fullfilled or failed, good or bad settlement events. \n\n The value of the settlement determines how valuable the caravans it creates are, as well as the strength of local militia. \n\n Very prosperous settlements will continue to grow and potentialy add new locations."));

  //  addCampaignComponent(campaignPage, ::FU.Class.SettingsDivider("ConfigDivider2"));


    local loggingPage = settings.addPage("Logging");
	foreach(f in ::Const.LegendMod.Debug.FlagDefs)
	{
	    local b = loggingPage.addSetting(::FU.Class.ToggleSetting(f.ID, f.Value, f.Name, f.Description));
	    b.getData().FlagID <- f.ID;
	   // TODO sort this out
	   //  b.addCallback(function(_value)
	   // {
	   //	::Legends.Mod.Debug.setFlag(this.getData().FlagID, _value);
	   // });
	}
}
