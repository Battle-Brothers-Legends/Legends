this.Const.BeastslayerReplace <- {
	NewIngredients = {},
	ItemsToChange = {},

	function changeBlueprint( _blueprintID, _conditionFunction = null, _ingredients = null, _itemFunction = null, _blueprintScript = null, _blueprintFunction = null )
	{
		if (_ingredients != null) this.NewIngredients[_blueprintID] <- _ingredients;
		if (_itemFunction != null) this.ItemsToChange[_blueprintID] <- _itemFunction;

		::mods_hookBaseClass("crafting/blueprint", function(o) {
			o = o[o.SuperName];

			local getUIData = o.getUIData;
			o.getUIData = function()
			{
				if (_conditionFunction == null || _conditionFunction())
				{      
					local id = this.getID();
					foreach (blueprintID, ingredients in this.Const.BeastslayerReplace.NewIngredients)
					{
						if (id == blueprintID)
						{
							this.m.PreviewComponents.clear();
							this.init(ingredients);
							delete this.Const.BeastslayerReplace.NewIngredients[blueprintID];
							break;
						}
					}

					foreach (blueprintID, func in this.Const.BeastslayerReplace.ItemsToChange)
					{
						if (id == blueprintID)
						{
							func(this.m.PreviewCraftable);
						}
					}
				}
				return getUIData();
			}
		});

		::mods_hookExactClass(_blueprintScript, function(o) {
			local onCraft = o.onCraft;
			o.onCraft = function( _stash )
			{
				if (_conditionFunction == null || _conditionFunction())
				{
					local item = _blueprintFunction();
					_itemFunction(item);
					_stash.add(item);
				}
				else
				{
					onCraft(_stash);
				}
			}
		});
	}
}

//BONE PLATING
this.Const.BeastslayerReplace.changeBlueprint("blueprint.bone_platings_upgrade", 	
	function() { return this.World.Assets.getOrigin().getID() == "scenario.beast_hunters"; }, 
	[

	]
	function(o) { o.m.Condition = 20; o.m.ConditionMax = 20; o.m.ConditionModifier = 20; },
	"crafting/blueprints/bone_platings_upgrade_blueprint", 
	function() { return this.LegendsMod.Configs().LegendArmorsEnabled() ? this.new("scripts/items/legend_armor/armor_upgrades/legend_bone_platings_upgrade") : this.new("scripts/items/armor_upgrades/bone_platings_upgrade"); }
);

//FLASH POT
this.Const.BeastslayerReplace.changeBlueprint("blueprint.daze_bomb", 	
	function() { return this.World.Assets.getOrigin().getID() == "scenario.beast_hunters"; }, 
	[
		{ Script = "scripts/items/misc/glistening_scales_item", Num = 1 },
		{ Script = "scripts/items/misc/petrified_scream_item", Num = 1 },
	]
	"crafting/blueprints/daze_bomb_blueprint", 
	function() { return this.new("scripts/items/tools/daze_bomb_item"); }
);

//DIREWOLF PELT MANTLE
this.Const.BeastslayerReplace.changeBlueprint("blueprint.direwolf_pelt_upgrade", 	
	function() { return this.World.Assets.getOrigin().getID() == "scenario.beast_hunters"; }, 
	[

	]
	function(o) { o.m.Condition = 15; o.m.ConditionMax = 15; o.m.ConditionModifier = 15; },
	"crafting/blueprints/direwolf_pelt_upgrade_blueprint", 
	function() { return this.LegendsMod.Configs().LegendArmorsEnabled() ? this.new("scripts/items/legend_armor/armor_upgrades/legend_direwolf_pelt_upgrade") : this.new("scripts/items/armor_upgrades/direwolf_pelt_upgrade"); }
);

//FERMENTED UNHOLD HEART
this.Const.BeastslayerReplace.changeBlueprint("blueprint.fermented_unhold_heart", 	
	function() { return this.World.Assets.getOrigin().getID() == "scenario.beast_hunters"; }, 
	[

	]
	function(o) { o.m.Amount = 60; },		
	"crafting/blueprints/fermented_unhold_heart_blueprint", 
	function() { return this.new("scripts/items/supplies/fermented_unhold_heart"); }
);

//LIVING GREENWOOD TREE SHIELD
this.Const.BeastslayerReplace.changeBlueprint("blueprint.legend_greenwood_schrat_shield", 	
	function() { return this.World.Assets.getOrigin().getID() == "scenario.beast_hunters"; }, 
	[

	]
	function(o) { o.m.StaminaModifier = 12; },
	"crafting/blueprints/legend_greenwood_schrat_shield_blueprint", 
	function() { return this.new("scripts/items/shields/special/legend_craftable_greenwood_schrat_shield"); }
);

//Flask of Heartwood Sap
this.Const.BeastslayerReplace.changeBlueprint("blueprint.legend_heartwood_sap_flask", 	
	function() { return this.World.Assets.getOrigin().getID() == "scenario.beast_hunters"; }, 
	[
		{ Script = "scripts/items/misc/glowing_resin_item", Num = 1 },
	]
	"crafting/blueprints/legend_heartwood_sap_flask_blueprint", 
	function() { return this.new("scripts/items/tools/legend_heartwood_sap_flask_item"); }
);

//Heavy Wardog Armor
this.Const.BeastslayerReplace.changeBlueprint("blueprint.heavy_wardog_armor_upgrade", 	
	function() { return this.World.Assets.getOrigin().getID() == "scenario.beast_hunters"; }, 
	[

	]
	function(o) { o.m.Condition = 110; o.m.ConditionMax = 110; o.m.ConditionModifier = 110; },
	"crafting/blueprints/heavy_wardog_armor_upgrade_blueprint", 
	function() { return this.new("scripts/items/armor/special/wardog_heavy_armor"); }
);

//HYENA FUR MANTLE
this.Const.BeastslayerReplace.changeBlueprint("blueprint.hyena_fur_upgrade", 	
	function() { return this.World.Assets.getOrigin().getID() == "scenario.beast_hunters"; }, 
	[

	]
	function(o) { o.m.Condition = 20; o.m.ConditionMax = 20; o.m.ConditionModifier = 20; },
	"crafting/blueprints/hyena_fur_upgrade_blueprint", 
	function() { return this.LegendsMod.Configs().LegendArmorsEnabled() ? this.new("scripts/items/legend_armor/armor_upgrades/legend_hyena_fur_upgrade") : this.new("scripts/items/armor_upgrades/hyena_fur_upgrade"); }
);

//Kraken Shield
this.Const.BeastslayerReplace.changeBlueprint("blueprint.kraken_shield", 	
	function() { return this.World.Assets.getOrigin().getID() == "scenario.beast_hunters"; }, 
	[

	]
	function(o) { o.m.MeleeDefense = 26; o.m.RangedDefense = 26; o.m.StaminaModifier = 12; o.m.Condition = 62; o.m.ConditionMax = 62; o.m.ConditionModifier = 62; },
	"crafting/blueprints/kraken_shield_blueprint", 
	function() { return this.new("scripts/items/shields/special/craftable_kraken_shield"); }
);

//Lindwurm Scale Cloak
this.Const.BeastslayerReplace.changeBlueprint("blueprint.lindwurm_scales_upgrade", 	
	function() { return this.World.Assets.getOrigin().getID() == "scenario.beast_hunters"; }, 
	[

	]
	function(o) { o.m.Condition = 40; o.m.ConditionMax = 40; o.m.ConditionModifier = 40; },
	"crafting/blueprints/lindwurm_scales_upgrade_blueprint", 
	function() { return this.LegendsMod.Configs().LegendArmorsEnabled() ? this.new("scripts/items/legend_armor/armor_upgrades/legend_lindwurm_scales_upgrade") : this.new("scripts/items/armor_upgrades/lindwurm_scales_upgrade"); }
);

//Redback Silk Cloak
this.Const.BeastslayerReplace.changeBlueprint("blueprint.legend_armor_redback_cloak_upgrade", 	
	function() { return this.World.Assets.getOrigin().getID() == "scenario.beast_hunters"; }, 
	[

	]
	function(o) { o.m.StaminaModifier = 0; },
	"crafting/blueprints/legend_armor_redback_cloak_upgrade_blueprint", 
	function() { return this.LegendsMod.Configs().LegendArmorsEnabled() ? this.new("scripts/items/legend_armor/armor_upgrades/legend_armor_redback_cloak_upgrade") : this.new("scripts/items/armor_upgrades/legend_redback_cloak_upgrade"); }
);

//Serpent Skin Mantle
this.Const.BeastslayerReplace.changeBlueprint("blueprint.serpent_skin_upgrade", 	
	function() { return this.World.Assets.getOrigin().getID() == "scenario.beast_hunters"; }, 
	[

	]
	function(o) { o.m.Condition = 40; o.m.ConditionMax = 40; o.m.ConditionModifier = 40;  },
	"crafting/blueprints/serpent_skin_upgrade_blueprint", 
	function() { return this.LegendsMod.Configs().LegendArmorsEnabled() ? this.new("scripts/items/legend_armor/armor_upgrades/legend_serpent_skin_upgrade") : this.new("scripts/items/armor_upgrades/serpent_skin_upgrade"); }
);

//Smoke Bomb
this.Const.BeastslayerReplace.changeBlueprint("blueprint.smoke_bomb", 	
	function() { return this.World.Assets.getOrigin().getID() == "scenario.beast_hunters"; }, 
	[
		{ Script = "scripts/items/misc/acidic_saliva_item", Num = 1 },
		{ Script = "scripts/items/misc/ghoul_brain_item", Num = 1 },
	]
	"crafting/blueprints/smoke_bomb_blueprint", 
	function() { return this.new("scripts/items/tools/smoke_bomb_item"); }
);

//Stollwurm Scale Cloak
this.Const.BeastslayerReplace.changeBlueprint("blueprint.legend_stollwurm_scales_upgrade", 	
	function() { return this.World.Assets.getOrigin().getID() == "scenario.beast_hunters"; }, 
	[

	]
	function(o) { o.m.Condition = 60; o.m.ConditionMax = 60; o.m.ConditionModifier = 60;  },
	"crafting/blueprints/legend_stollwurm_scales_upgrade_blueprint", 
	function() { return this.LegendsMod.Configs().LegendArmorsEnabled() ? this.new("scripts/items/legend_armor/armor_upgrades/legend_armor_stollwurm_scales_upgrade") : this.new("scripts/items/armor_upgrades/legend_stollwurm_scales_upgrade"); }
);

//Unhold Fur Cloak
this.Const.BeastslayerReplace.changeBlueprint("blueprint.unhold_fur_upgrade", 	
	function() { return this.World.Assets.getOrigin().getID() == "scenario.beast_hunters"; }, 
	[

	]
	function(o) { o.m.Condition = 15; o.m.ConditionMax = 15; o.m.ConditionModifier = 15;  },
	"crafting/blueprints/unhold_fur_upgrade_blueprint", 
	function() { return this.LegendsMod.Configs().LegendArmorsEnabled() ? this.new("scripts/items/legend_armor/armor_upgrades/legend_unhold_fur_upgrade") : this.new("scripts/items/armor_upgrades/unhold_fur_upgrade"); }
);

//White Wolf Pelt Mantle
this.Const.BeastslayerReplace.changeBlueprint("blueprint.legend_white_wolf_pelt_upgrade", 	
	function() { return this.World.Assets.getOrigin().getID() == "scenario.beast_hunters"; }, 
	[

	]
	function(o) { o.m.Condition = 40; o.m.ConditionMax = 40; o.m.ConditionModifier = 40;  },
	"crafting/blueprints/legend_white_wolf_pelt_upgrade_blueprint", 
	function() { return this.LegendsMod.Configs().LegendArmorsEnabled() ? this.new("scripts/items/legend_armor/armor_upgrades/legend_white_wolf_pelt_upgrade") : this.new("scripts/items/armor_upgrades/legend_armor_white_wolf_pelt_upgrade"); }
);
