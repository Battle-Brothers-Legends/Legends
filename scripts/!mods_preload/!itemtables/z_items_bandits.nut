local entity;

local weapons;
local armors;
local helmets;
local offhands;
local bag;
local accessory;

local function isOffhandEmpty(){
	return this.m.Items.getItemAtSlot(this.Const.ItemSlot.Offhand) == null
}
local function hasWOTN(i){
	return this.Const.DLC.Unhold
}
local function isLegendary(){
	return "Assets" in this.World && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary;
}
//-----------------------------------------------------------------------------------------------------------------
//Rabble
entity = this.Const.EntityType.BanditRabble;

weapons = [
	{
		Script = "scripts/items/weapons/legend_wooden_pitchfork",
		onChosen = function(i)
		{
			if (isLegendary())
			{
				this.m.Skills.add(this.new("scripts/skills/perks/perk_coup_de_grace"));
				this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_specialist_pitchfork_skill"));
				this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_specialist_pitchfork_damage"));
				this.m.Items.equip(this.Const.World.Common.pickHelmet([[1, "straw_hat"]]));
				this["skip" + this.Const.ItemSlot.Head] <- true;
			}
		}
	},
	{
		Script = "scripts/items/weapons/legend_wooden_spear",
		onChosen = function(i)
		{
			if (isLegendary())
			{
				this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_specialist_militia_skill"));
				this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_specialist_militia_damage"));
				this.m.Items.equip(this.new("scripts/items/shields/buckler_shield"));
				//this.m.Items.equip(this.new("scripts/items/armor/leather_tunic"));
				this.m.Items.equip(this.Const.World.Common.pickHelmet([[1, "open_leather_cap"]]));
				this["skip" + this.Const.ItemSlot.Head] <- true;
			}
		}
	},
	{
		Script = "scripts/items/weapons/legend_sickle",
		onChosen = function(i)
		{
			if (isLegendary())
			{
				this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_specialist_sickle_skill"));
				this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_specialist_sickle_damage"));
				this.m.Items.equip(this.Const.World.Common.pickHelmet([[1, "hood"]]));
				this["skip" + this.Const.ItemSlot.Head] <- true;
			}
		}
	},
	{
		Script = "scripts/items/weapons/legend_staff",
		onChosen = function(i)
		{
			if (isLegendary())
			{
				this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_specialist_staff_skill"));
				this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_mastery_staff_stun"));
				this.m.Skills.add(this.new("scripts/skills/perks/perk_fortified_mind"));
				this.m.Items.equip(this.Const.World.Common.pickHelmet([[1, "hood"]]));
				this["skip" + this.Const.ItemSlot.Head] <- true;
			}
		}
	},
	{
		Script = "scripts/items/weapons/legend_shovel",
		onChosen = function(i)
		{
			if (isLegendary())
			{
				this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_specialist_shovel_skill"));
				this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_specialist_shovel_damage"));
				this.m.Items.equip(this.Const.World.Common.pickHelmet([[1, "hood"]]));
				this["skip" + this.Const.ItemSlot.Head] <- true;
			}
		}
	},
	{
		Script = "scripts/items/weapons/wooden_stick",
		onChosen = function(i)
		{
			if (isLegendary())
			{
				this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_onslaught"));
				this.m.Skills.add(this.new("scripts/skills/perks/perk_overwhelm"));
				this.m.Skills.add(this.new("scripts/skills/perks/perk_colossus"));
				this.m.Skills.add(this.new("scripts/skills/perks/perk_recover"));
				this.m.Skills.add(this.new("scripts/skills/perks/perk_rebound"));
				this.m.Items.equip(this.Const.World.Common.pickHelmet([[1, "straw_hat"]]));
				this["skip" + this.Const.ItemSlot.Head] <- true;
			}
		}
	},
	{
		Script = "scripts/items/weapons/legend_hammer",
		onChosen = function(i)
		{
			if (isLegendary())
			{
				this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_specialist_hammer_skill"));
				this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_specialist_hammer_damage"));
				this.m.Skills.add(this.new("scripts/skills/perks/perk_colossus"));
				this.m.Items.equip(this.Const.World.Common.pickHelmet([[1, "mouth_piece"]]));
				this["skip" + this.Const.ItemSlot.Head] <- true;
			}
		}
	},
	{
		Script = "scripts/items/weapons/legend_shiv",
		onChosen = function(i)
		{
			if (isLegendary())
			{
				this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_specialist_knife_skill"));
				this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_specialist_knife_damage"));
				this.m.Skills.add(this.new("scripts/skills/perks/perk_duelist"));
				this.m.Items.equip(this.Const.World.Common.pickHelmet([[1, "headscarf"]]));
				this["skip" + this.Const.ItemSlot.Head] <- true;
			}
		}
	},
	{
		Script = "scripts/items/weapons/lute",
		onChosen = function(i)
		{
			if (isLegendary())
			{
				this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_specialist_lute_damage"));
				this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_mind_over_body"));
				this.m.Skills.add(this.new("scripts/skills/perks/perk_recover"));
				this.m.Items.equip(this.Const.World.Common.pickHelmet([[1, "feathered_hat"]]));
				this["skip" + this.Const.ItemSlot.Head] <- true;
			}
		}
	},
	{
		Script = "scripts/items/weapons/butchers_cleaver",
		onChosen = function(i)
		{
			if (isLegendary())
			{
				this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_bloodbath"));
				this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_specialist_butcher_skill"));
				this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_specialist_butcher_damage"));
				this.m.Items.equip(this.Const.World.Common.pickHelmet([[1, "mouth_piece"]]));
				this["skip" + this.Const.ItemSlot.Head] <- true;
			}
		}
	},
	{
		Script = "scripts/items/weapons/legend_saw",
		onChosen = function(i)
		{
			if (isLegendary())
			{
				this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_smashing_shields"));
				this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_specialist_woodaxe_skill"));
				this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_specialist_woodaxe_damage"));
				this.m.Items.equip(this.Const.World.Common.pickHelmet([[1, "headscarf"]]));
				this["skip" + this.Const.ItemSlot.Head] <- true;
			}
		}
	},
	{
		Script = "scripts/items/weapons/legend_hoe",
		onChosen = function(i)
		{
			if (isLegendary())
			{
				this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_smackdown"));
				this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_specialist_pitchfork_skill"));
				this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_specialist_pitchfork_damage"));
				this.m.Items.equip(this.Const.World.Common.pickHelmet([[1, "straw_hat"]]));
				this["skip" + this.Const.ItemSlot.Head] <- true;
			}
		}
	},
	{
		Script = "scripts/items/weapons/wooden_flail",
		onChosen = function(i)
		{
			if (isLegendary())
			{
				this.m.Skills.add(this.new("scripts/skills/perks/perk_head_hunter"));
				this.m.Skills.add(this.new("scripts/skills/perks/perk_battle_flow"));
				this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_specialist_pitchfork_skill"));
				this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_specialist_pitchfork_damage"));
				this.m.Items.equip(this.Const.World.Common.pickHelmet([[1, "cultist_hood"]]));
				this["skip" + this.Const.ItemSlot.Head] <- true;
			}
		}
	},
];

armors = [
	"leather_wraps",
	"tattered_sackcloth",
	"legend_rabble_tunic",
	"monk_robe",
	"legend_rabble_fur"
];

::pushItems(entity, weapons, "Mainhand");
::pushItems(entity, armors, "Body");

::setItemSlotIsValid(entity, "Body", function()
{
	return this.Math.rand(1, 100) <= 90;
});