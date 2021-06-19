local entity;

local weapons;
local armors;
local helmets;
local offhands;
local bag;
local accessory;

local function isLegendary(){
	return "Assets" in this.World && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary;
}
//-----------------------------------------------------------------------------------------------------------------
//Rabble
entity = "BanditRabble";

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
				this.m.Items.equip(this.Const.World.Common.pickHelmet([[1, "open_leather_cap"]]));
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

::pushItems(entity, "Mainhand", weapons);
::pushItems(entity, "Body", armors);

::setItemSlotIsValid(entity, "Body", @() this.Math.rand(1, 100) <= 90);

//-----------------------------------------------------------------------------------------------------------------
//Rabble Poacher

entity = "BanditRabblePoacher";

weapons = [
	{
		Script = "scripts/items/weapons/short_bow",
		onChosen = function(i)
		{
			this.m.Items.equip(this.new("scripts/items/ammo/quiver_of_arrows"));
		}
	},
	{Script = "scripts/items/weapons/legend_sling", Weight = 2}
];

armors = [
	"leather_wraps",
	"tattered_sackcloth",
	"legend_rabble_tunic",
	"monk_robe",
	"legend_rabble_fur"
	
];

helmets = [
	"headscarf",
	"mouth_piece"
];

::pushItems(entity, "Mainhand", weapons);
::pushItems(entity, "Body", armors);
::pushItems(entity, "Head", helmets);

::setItemSlotIsValid(entity, "Body", @() this.Math.rand(1, 100) <= 90);
::setItemSlotIsValid(entity, "Head", @() this.Math.rand(1, 100) <= 50);

//-----------------------------------------------------------------------------------------------------------------
//Thug

entity = "BanditThug";

weapons = [
	{
		Script = "scripts/items/weapons/woodcutters_axe",
		onChosen = function(i)
		{
			if (isLegendary()) this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_smashing_shields"));
		}
	},
	{
		Script = "scripts/items/weapons/pitchfork",
		onChosen = function(i)
		{
			if (isLegendary()) this.m.Skills.add(this.new("scripts/skills/perks/perk_coup_de_grace"));
		}
	},
	{
		Script = "scripts/items/weapons/goedendag",
		onChosen = function(i)
		{
			if (isLegendary()) this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_onslaught"));
		}
	},
	{
		Script = "scripts/items/weapons/shortsword",
		Weight = 45,
		onChosen = function(i)
		{
			if (isLegendary()) this.m.Skills.add(this.new("scripts/skills/perks/perk_duelist"));
		}
	},
	{
		Script = "scripts/items/weapons/militia_spear",
		Weight = 45,
		onChosen = function(i)
		{
			if (isLegendary()) this.m.Skills.add(this.new("scripts/skills/perks/perk_overwhelm"));
		}
	},
	{
		Script = "scripts/items/weapons/pickaxe",
		Weight = 45,
		onChosen = function(i)
		{
			if (isLegendary()) this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_smackdown"));
		}
	},
	{
		Script = "scripts/items/weapons/reinforced_wooden_flail",
		Weight = 45,
		onChosen = function(i)
		{
			if (isLegendary()) this.m.Skills.add(this.new("scripts/skills/perks/perk_head_hunter"));
		}
	},
	{
		Script = "scripts/items/weapons/wooden_flail",
		Weight = 45,
		onChosen = function(i)
		{
			if (isLegendary()) this.m.Skills.add(this.new("scripts/skills/perks/perk_head_hunter"));
		}
	},
	{
		Script = "scripts/items/weapons/butchers_cleaver",
		Weight = 45,
		onChosen = function(i)
		{
			if (isLegendary()) this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_bloodbath"));
		}
	},
	{
		Script = "scripts/items/weapons/dagger",
		Weight = 45,
		onChosen = function(i)
		{
			if (isLegendary()) this.m.Skills.add(this.new("scripts/skills/perks/perk_duelist"));
		}
	},
	{
		Script = "scripts/items/weapons/legend_scythe",
		Weight = 45,
		onChosen = function(i)
		{
			if (isLegendary()) this.m.Skills.add(this.new("scripts/skills/perks/perk_coup_de_grace"));
		}
	},
	{
		Script = "scripts/items/weapons/legend_tipstaff",
		Weight = 90,
		onChosen = function(i)
		{
			if (isLegendary())
			{
				if (this.Math.rand(1, 2) == 1) this.m.Skills.add(this.new("scripts/skills/perks/perk_return_favor"));
				else this.m.Skills.add(this.new("scripts/skills/perks/perk_killing_frenzy"));
			}
		}
	},
	{
		Script = "scripts/items/weapons/legend_militia_glaive",
		Weight = 45,
		onChosen = function(i)
		{
			if (isLegendary()) this.m.Skills.add(this.new("scripts/skills/perks/perk_killing_frenzy"));
		}
	},
	{
		Script = "scripts/items/weapons/legend_ranged_wooden_flail",
		Weight = 45,
		onChosen = function(i)
		{
			if (isLegendary()) this.m.Skills.add(this.new("scripts/skills/perks/perk_killing_frenzy"));
		}
	}
];

offhands = [
	"scripts/items/shields/wooden_shield",
	"scripts/items/shields/buckler_shield"
];

armors = [
	{
		Scripts = [
			"blotched_gambeson",
			"ragged_surcoat",
			"padded_surcoat",
			"gambeson"
		]
	},
	{
		Scripts = [
			"leather_wraps",
			"thick_tunic",
			"monk_robe",
			"tattered_sackcloth",
			"leather_tunic"
		],
		isValid = @(i) !isLegendary()
	}
];

helmets = [
	"hood",
	"open_leather_cap",
	"headscarf",
	"mouth_piece",
	"full_leather_cap",
	"aketon_cap" 
];

::pushItems(entity, "Mainhand", weapons);
::pushItems(entity, "Offhand", offhands);
::pushItems(entity, "Body", armors);
::pushItems(entity, "Head", helmets);

::setItemSlotIsValid(entity, "Offhand", function()
{
	local chance = 33;
	if (isLegendary()) chance = 100;
	return (this.Math.rand(1, 100) <= chance);
});
::setItemSlotIsValid(entity, "Head", function()
{
	local chance = 40;
	if (isLegendary()) chance = 100;
	return (this.Math.rand(1,100) <= chance)
});

//-----------------------------------------------------------------------------------------------------------------
//Poacher

entity = "BanditPoacher";

weapons = [
	{Script = "scripts/items/weapons/short_bow", onChosen = @(i) this.m.Items.equip(this.new("scripts/items/ammo/quiver_of_arrows"))},
	"scripts/items/weapons/legend_sling"
];

bag = [
	"scripts/items/weapons/legend_shiv",
	"scripts/items/weapons/knife"
];

armors = [
	"leather_wraps"
];

helmets = [
	"headscarf",
	"mouth_piece"
]

::pushItems(entity, "Mainhand", weapons);
::pushItems(entity, "Bag", bag);
::pushItems(entity, "Body", armors);
::pushItems(entity, "Head", helmets);

::setItemSlotIsValid(entity, "Head", @() this.Math.rand(1, 100) <= 50)

//-----------------------------------------------------------------------------------------------------------------
//Raider

entity = "BanditRaider";

weapons = [
	{
		Script = "scripts/items/weapons/legend_infantry_axe",
		Weight = 3,
		isValid = @(i) !this.m.isLow,
		onChosen = function(i)
		{
			if (isLegendary()) this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_smashing_shields"));
		}
	},
	{
		Script = "scripts/items/weapons/hooked_blade",
		isValid = function(i) 
		{
			i.Weight = this.m.isLow ? 1 : 3;
			return true;
		},
		onChosen = function(i)
		{
			if (isLegendary()) this.m.Skills.add(this.new("scripts/skills/perks/perk_crippling_strikes"));
		}
	},
	{
		Script = "scripts/items/weapons/pike",
		isValid = function(i) 
		{
			i.Weight = this.m.isLow ? 1 : 3;
			return true;
		},
		onChosen = function(i)
		{
			if (isLegendary()) this.m.Skills.add(this.new("scripts/skills/perks/perk_reach_advantage"));
		}
	},
	{
		Script = "scripts/items/weapons/warbrand",
		Weight = 3,
		isValid = @(i) !this.m.isLow,
		onChosen = function(i)
		{
			if (isLegendary()) this.m.Skills.add(this.new("scripts/skills/perks/perk_bloody_harvest"));
		}
	},
	{
		Script = "scripts/items/weapons/longaxe",
		Weight = 3,
		isValid = @(i) !this.m.isLow,
		onChosen = function(i)
		{
			if (isLegendary()) this.m.Skills.add(this.new("scripts/skills/perks/perk_killing_frenzy"));
		}
	},
	{
		Script = "scripts/items/weapons/two_handed_wooden_hammer",
		isValid = function(i) 
		{
			i.Weight = this.m.isLow ? 1 : 3;
			return true;
		},
		onChosen = function(i)
		{
			if (isLegendary()) this.m.Skills.add(this.new("scripts/skills/perks/perk_sundering_strikes"));
		}
	},
	{
		Scripts = [
		"scripts/items/weapons/two_handed_wooden_flail",
		"scripts/items/weapons/legend_ranged_flail",
		"scripts/items/weapons/legend_reinforced_flail"
		],
		isValid = @(i) !this.m.isLow,
		onChosen = function(i)
		{
			if (isLegendary()) this.m.Skills.add(this.new("scripts/skills/perks/perk_head_hunter"));
		}
	},
	{
		Script = "scripts/items/weapons/two_handed_mace",
		Weight = 3,
		isValid = @(i) !this.m.isLow,
		onChosen = function(i)
		{
			if (isLegendary()) this.m.Skills.add(this.new("scripts/skills/perks/perk_colossus"));
		}
	},
	{
		Script = "scripts/items/weapons/longsword",
		Weight = 3,
		isValid = @(i) !this.m.isLow,
		onChosen = function(i)
		{
			if (isLegendary()) this.m.Skills.add(this.new("scripts/skills/perks/perk_vengeance"));
		}
	},
	{
		Script = "scripts/items/weapons/legend_bastardsword",
		Weight = 3,
		isValid = @(i) !this.m.isLow,
		onChosen = function(i)
		{
			if (isLegendary()) this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_forceful_swing"));
		}
	},
	{
		Script = "scripts/items/weapons/shortsword",
		isValid = function(i) 
		{
			i.Weight = this.m.isLow ? 3 : 12;
			return true;
		},
		onChosen = function(i)
		{
			if (isLegendary()) this.m.Skills.add(this.new("scripts/skills/perks/perk_duelist"));
		}
	},
	{
		Script = "scripts/items/weapons/hand_axe",
		isValid = function(i) 
		{
			i.Weight = this.m.isLow ? 3 : 12;
			return true;
		},
		onChosen = function(i)
		{
			if (isLegendary()) this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_smashing_shields"));
		}
	},
	{
		Script = "scripts/items/weapons/boar_spear",
		isValid = function(i) 
		{
			i.Weight = this.m.isLow ? 3 : 12;
			return true;
		},
		onChosen = function(i)
		{
			if (isLegendary()) this.m.Skills.add(this.new("scripts/skills/perks/perk_overwhelm"));
		}
	},
	{
		Script = "scripts/items/weapons/morning_star",
		Weight = 12,
		isValid = function(i) 
		{
			i.Weight = this.m.isLow ? 3 : 12;
			return true;
		},
		onChosen = function(i)
		{
			if (isLegendary()) this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_onslaught"));
		}
	},
	{
		Script = "scripts/items/weapons/falchion",
		isValid = function(i) 
		{
			i.Weight = this.m.isLow ? 3 : 12;
			return true;
		},
		onChosen = function(i)
		{
			if (isLegendary()) this.m.Skills.add(this.new("scripts/skills/perks/perk_duelist"));
		}
	},
	{
		Script = "scripts/items/weapons/arming_sword",
		Weight = 12,
		isValid = @(i) !this.m.isLow,
		onChosen = function(i)
		{
			if (isLegendary()) this.m.Skills.add(this.new("scripts/skills/perks/perk_feint"));
		}
	},
	{
		Script = "scripts/items/weapons/flail",
		isValid = function(i) 
		{
			i.Weight = this.m.isLow ? 3 : 12;
			return true;
		},
		onChosen = function(i)
		{
			if (isLegendary()) this.m.Skills.add(this.new("scripts/skills/perks/perk_head_hunter"));
		}
	},
	{
		Script = "scripts/items/weapons/scramasax",
		Weight = 12,
		isValid = @(i) !this.m.isLow,
		onChosen = function(i)
		{
			if (isLegendary()) this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_bloodbath"));
		}
	},
	{
		Script = "scripts/items/weapons/military_pick",
		Weight = 12,
		isValid = @(i) !this.m.isLow,
		onChosen = function(i)
		{
			if (isLegendary()) this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_smackdown"));
		}
	},
	{
		Script = "scripts/items/weapons/legend_glaive",
		Weight = 12,
		isValid = @(i) !this.m.isLow,
		onChosen = function(i)
		{
			if (isLegendary()) this.m.Skills.add(this.new("scripts/skills/perks/perk_killing_frenzy"));
		}
	},
	{
		Script = "scripts/items/weapons/woodcutters_axe",
		Weight = 1,
		isValid = @(i) this.m.isLow
	}

];

offhands = [
	{
		Script = "scripts/items/shields/wooden_shield",
		isValid = function(i) 
		{
			i.Weight = this.m.isLow ? 2 : 3;
			return true;
		}
	},
	{
		Script = "scripts/items/shields/kite_shield",
		isValid = @(i) !this.m.isLow
	},
	{
		Script = "scripts/items/shields/buckler_shield",
		isValid = @(i) this.m.isLow
	}
];

bag = [
	{
		Script = "scripts/items/weapons/throwing_spear",
		isValid = @(i) !this.m.isLow
	}
	"scripts/items/weapons/throwing_axe",
	"scripts/items/weapons/javelin"
];

armors = [
	"ragged_surcoat",
	"padded_leather",
	"worn_mail_shirt",
	"patched_mail_shirt",
	{
		Script = "leather_lamellar",
		isValid = @(i) this.m.isLow
	}
	
];

helmets = [
	"nasal_helmet",
	"dented_nasal_helmet",
	"rusty_mail_coif",
	"headscarf",
	{
		Scripts = [
			"rondel_helm",
			"scale_helm",
			"nasal_helmet_with_rusty_mail"
		],
		isValid = @(i) !this.m.isLow
	}
];

::pushItems(entity, "Mainhand", weapons);
::pushItems(entity, "Offhand", offhands);
::pushItems(entity, "Bag", bag);
::pushItems(entity, "Body", armors);
::pushItems(entity, "Head", helmets);

::setItemSlotIsValid(entity, "Offhand", @(i) this.Math.rand(1, 100) <= this.m.isLow ? 66 : 75);
::setItemSlotIsValid(entity, "Bag", @(i) this.getIdealRange() == 1 && this.Math.rand(1, 100) <= this.m.isLow ? 25 : 35);

::setItemSlotOnChosen(entity, "Body", function(i)
{
	if (this.m.Name == "Disguised Bandit")
	{
		i.setUpgrade(this.new("scripts/items/" +
			(this.LegendsMod.Configs().LegendArmorsEnabled() ? "legend_armor/armor_upgrades/legend_direwolf_pelt_upgrade" : "armor_upgrades/direwolf_pelt_upgrade")));
	}
});

//-----------------------------------------------------------------------------------------------------------------
//Marksman
entity = "BanditMarksman";

weapons = [
	{
		Script = "scripts/items/weapons/short_bow",
		isValid = function(i)
		{
			i.Weight = this.m.isLow ? 2 : 1
		},
		onChosen = @(i) this.m.Items.equip(this.new("scripts/items/ammo/quiver_of_arrows"))
	},
	{
		Script = "scripts/items/weapons/hunting_bow",
		isValid = @(i) !this.m.isLow,
		onChosen = @(i) this.m.Items.equip(this.new("scripts/items/ammo/quiver_of_arrows"))
	},
	{
		Script = "scripts/items/weapons/light_crossbow",
		onChosen = @(i) this.m.Items.equip(this.new("scripts/items/ammo/quiver_of_bolts"))
	},
	{
		Script = "scripts/items/weapons/crossbow",
		isValid = @(i) !this.m.isLow,
		onChosen = @(i) this.m.Items.equip(this.new("scripts/items/ammo/quiver_of_bolts"))
	}
];

bag = [
	{
		Scripts = [
			"scripts/items/weapons/dagger",
			"scripts/items/weapons/hatchet",
			"scripts/items/weapons/bludgeon"
		],
		isValid = @(i) !this.m.isLow
	},
	"scripts/items/weapons/knife"
];

armors = [
	{
		Scripts = [
			"thick_tunic",
			"padded_surcoat",
			"blotched_gambeson"
		],
		isValid = @(i) !this.m.isLow
	},
	"leather_wraps"
];

helmets = [
	{
		Scripts = [
			"hood",
			"open_leather_cap",
			"full_leather_cap"
		],
		isValid = @(i) !this.m.isLow
	},
	"headscarf",
	"mouth_piece"
];

::pushItems(entity, "Mainhand", weapons);
::pushItems(entity, "Bag", bag);
::pushItems(entity, "Body", armors);
::pushItems(entity, "Head", helmets);

::setItemSlotIsValid(entity, "Head", @(i) this.Math.rand(1, 100) <= 50);

//-----------------------------------------------------------------------------------------------------------------
//Veteran

entity = "BanditVeteran";

weapons = [
	{
		Script = "scripts/items/weapons/legend_infantry_axe",
		Weight = 2,
		onChosen = function(i)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_smashing_shields"));
			if (isLegendary()) this.m.Skills.add(this.new("scripts/skills/perks/perk_killing_frenzy"));
		}
	},
	{
		Script = "scripts/items/weapons/hooked_blade",
		Weight = 2,
		onChosen = function(i)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_crippling_strikes"));
			if (isLegendary()) this.m.Skills.add(this.new("scripts/skills/perks/perk_fearsome"));
		}
	},
	{
		Script = "scripts/items/weapons/pike",
		Weight = 2,
		onChosen = function(i)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_reach_advantage"));
			if (isLegendary()) this.m.Skills.add(this.new("scripts/skills/perks/perk_backstabber"));
		}
	},
	{
		Script = "scripts/items/weapons/warbrand",
		Weight = 2,
		onChosen = function(i)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_bloody_harvest"));
			if (isLegendary()) this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_forceful_swing"));
		}
	},
	{
		Script = "scripts/items/weapons/longaxe",
		Weight = 2,
		onChosen = function(i)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_killing_frenzy"));
			if (isLegendary()) this.m.Skills.add(this.new("scripts/skills/perks/perk_backstabber"));
		}
	},
	{
		Script = "scripts/items/weapons/two_handed_wooden_hammer",
		Weight = 2,
		onChosen = function(i)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_sundering_strikes"));
			if (isLegendary()) this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_smackdown"));
		}
	},
	{
		Scripts = [
			"scripts/items/weapons/two_handed_wooden_flail",
			"scripts/items/weapons/legend_reinforced_flail"
		],
		onChosen = function(i)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_head_hunter"));
			if (isLegendary()) this.m.Skills.add(this.new("scripts/skills/perks/perk_battle_flow"));
		}
	},
	{
		Script = "scripts/items/weapons/two_handed_mace",
		Weight = 2,
		onChosen = function(i)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_colossus"));
			if (isLegendary()) this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_onslaught"));
		}
	},
	{
		Script = "scripts/items/weapons/longsword",
		Weight = 2,
		onChosen = function(i)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_vengeance"));
			if (isLegendary()) this.m.Skills.add(this.new("scripts/skills/perks/perk_feint"));
		}
	},
	{
		Script = "scripts/items/weapons/legend_bastardsword",
		Weight = 2,
		onChosen = function(i)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_forceful_swing"));
			if (isLegendary()) this.m.Skills.add(this.new("scripts/skills/perks/perk_bloody_harvest"));
		}
	},
	{
		Script = "scripts/items/weapons/shortsword",
		Weight = 8,
		onChosen = function(i)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_duelist"));
			if (isLegendary()) this.m.Skills.add(this.new("scripts/skills/perks/perk_feint"));
		}
	},
	{
		Script = "scripts/items/weapons/hand_axe",
		Weight = 8,
		onChosen = function(i)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_smashing_shields"));
			if (isLegendary()) this.m.Skills.add(this.new("scripts/skills/perks/perk_killing_frenzy"));
		}
	},
	{
		Script = "scripts/items/weapons/boar_spear",
		Weight = 8,
		onChosen = function(i)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_overwhelm"));
			if (isLegendary()) this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_specialist_spearthrust"));
		}
	},
	{
		Script = "scripts/items/weapons/morning_star",
		Weight = 8,
		onChosen = function(i)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_onslaught"));
			if (isLegendary()) this.m.Skills.add(this.new("scripts/skills/perks/perk_head_hunter"));
		}
	},
	{
		Script = "scripts/items/weapons/falchion",
		Weight = 8,
		onChosen = function(i)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_duelist"));
			if (isLegendary()) this.m.Skills.add(this.new("scripts/skills/perks/perk_fearsome"));
		}
	},
	{
		Script = "scripts/items/weapons/arming_sword",
		Weight = 8,
		onChosen = function(i)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_feint"));
			if (isLegendary()) this.m.Skills.add(this.new("scripts/skills/perks/perk_duelist"));
		}
	},
	{
		Script = "scripts/items/weapons/flail",
		Weight = 8,
		onChosen = function(i)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_head_hunter"));
			if (isLegendary()) this.m.Skills.add(this.new("scripts/skills/perks/perk_battle_flow"));
		}
	},
	{
		Script = "scripts/items/weapons/scramasax",
		Weight = 8,
		onChosen = function(i)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_bloodbath"));
			if (isLegendary()) this.m.Skills.add(this.new("scripts/skills/perks/perk_fearsome"));
		}
	},
	{
		Script = "scripts/items/weapons/military_pick",
		Weight = 8,
		onChosen = function(i)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_sundering_strikes"));
			if (isLegendary()) this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_smackdown"));
		}
	},
	{
		Script = "scripts/items/weapons/legend_glaive",
		Weight = 8,
		onChosen = function(i)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_killing_frenzy"));
			if (isLegendary()) this.m.Skills.add(this.new("scripts/skills/perks/perk_fearsome"));
		}
	},
];

offhands = [
	{
		Scripts = [
			"scripts/items/shields/kite_shield",
			"scripts/items/shields/legend_tower_shield"
		],
		Weights = [3, 1]
	}
];

bag = [
	"scripts/items/weapons/throwing_axe",
	"scripts/items/weapons/javelin",
	"scripts/items/weapons/throwing_spear"
];

armors = [
	"worn_mail_shirt",
	"patched_mail_shirt",
	"leather_lamellar",
	"basic_mail_shirt"
];

helmets = [
	"nasal_helmet",
	"rondel_helm",
	"legend_enclave_vanilla_skullcap_01",
	"legend_enclave_vanilla_kettle_sallet_01",
	"scale_helm",
	"deep_sallet",
	"dented_nasal_helmet",
	"nasal_helmet_with_rusty_mail",
	"rusty_mail_coif",
	"headscarf"
];

::pushItems(entity, "Mainhand", weapons);
::pushItems(entity, "Offhand", offhands);
::pushItems(entity, "Bag", bag);
::pushItems(entity, "Body", armors);
::pushItems(entity, "Head", helmets);

::setItemSlotIsValid(entity, "Offhand", @(i) this.Math.rand(1, 100) <= 75);
::setItemSlotIsValid(entity, "Bag", @(i) this.getIdealRange() == 1 && this.Math.rand(1, 100) <= 35);
::setItemSlotIsValid(entity, "Head", @(i) this.Math.rand(1, 100) <= 85);

//-----------------------------------------------------------------------------------------------------------------
//Master Archer

entity = "MasterArcher"

weapons = [
	{
		Script = "scripts/items/weapons/war_bow",
		Weight = 2,
		onChosen = @(i) this.m.Items.equip(this.new("scripts/items/ammo/quiver_of_arrows"))
	},
	{
		Script = "scripts/items/weapons/heavy_crossbow",
		onChosen = @(i) this.m.Items.equip(this.new("scripts/items/ammo/quiver_of_bolts"))
	}
];

bag = [
	"scripts/items/weapons/dagger",
	"scripts/items/weapons/scramasax",
	"scripts/items/weapons/hatchet"
];

armors = [
	"thick_tunic",
	"padded_surcoat",
	"leather_lamellar",
	"basic_mail_shirt",
	"ragged_surcoat",
	"basic_mail_shirt"
];

helmets = [
	"hood",
	"headscarf"
];

::pushItems(entity, "Mainhand", weapons);
::pushItems(entity, "Bag", bag);
::pushItems(entity, "Body", armors);
::pushItems(entity, "Head", helmets);

::setItemSlotIsValid(entity, "Head", @(i)this.Math.rand(1, 100) <= 50);

//-----------------------------------------------------------------------------------------------------------------
//Leader

entity = "BanditLeader";

weapons = [
	"scripts/items/weapons/noble_sword",
	"scripts/items/weapons/fighting_axe",
	"scripts/items/weapons/warhammer",
	"scripts/items/weapons/legend_glaive",
	"scripts/items/weapons/fighting_spear",
	"scripts/items/weapons/winged_mace",
	"scripts/items/weapons/arming_sword",
	"scripts/items/weapons/military_cleaver",
	"scripts/items/weapons/greatsword",
	"scripts/items/weapons/greataxe",
	"scripts/items/weapons/legend_swordstaff",
	"scripts/items/weapons/legend_bastardsword",
	"scripts/items/weapons/warbrand",
	"scripts/items/weapons/legend_estoc"
];

offhands = [
	"shields/wooden_shield",
	"shields/heater_shield",
	"shields/kite_shield"
];

bag = [
	"weapons/throwing_axe",
	"weapons/javelin"
];

armors = [
	"reinforced_mail_hauberk",
	"worn_mail_shirt",
	"patched_mail_shirt",
	"mail_shirt",
	"footman_armor",
	"leather_scale_armor",
	"light_scale_armor",
	"red_bandit_leader_armor"
];

helmets = [
	"closed_mail_coif",
	"padded_kettle_hat",
	"kettle_hat_with_closed_mail",
	"kettle_hat_with_mail",
	"padded_flat_top_helmet",
	"nasal_helmet_with_mail",
	"flat_top_with_mail",
	"padded_nasal_helmet",
	"bascinet_with_mail",
	"red_bandit_leader_helmet"
];
