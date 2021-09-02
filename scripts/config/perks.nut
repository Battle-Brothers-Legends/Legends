local gt = this.getroottable();

if (!("Perks" in gt.Const))
{
	gt.Const.Perks <- {};
}

gt.Const.Perks.Perks <- [
	[
		{
			ID = "perk.fast_adaption",
			Script = "scripts/skills/perks/perk_fast_adaption",
			Name = this.Const.Strings.PerkName.FastAdaption,
			Tooltip = this.Const.Strings.PerkDescription.FastAdaption,
			Icon = "ui/perks/perk_33.png",
			IconDisabled = "ui/perks/perk_33_sw.png"
		},
		{
			ID = "perk.crippling_strikes",
			Script = "scripts/skills/perks/perk_crippling_strikes",
			Name = this.Const.Strings.PerkName.CripplingStrikes,
			Tooltip = this.Const.Strings.PerkDescription.CripplingStrikes,
			Icon = "ui/perks/perk_57.png",
			IconDisabled = "ui/perks/perk_57_sw.png"
		},
		{
			ID = "perk.colossus",
			Script = "scripts/skills/perks/perk_colossus",
			Name = this.Const.Strings.PerkName.Colossus,
			Tooltip = this.Const.Strings.PerkDescription.Colossus,
			Icon = "ui/perks/perk_06.png",
			IconDisabled = "ui/perks/perk_06_sw.png"
		},
		{
			ID = "perk.nine_lives",
			Script = "scripts/skills/perks/perk_nine_lives",
			Name = this.Const.Strings.PerkName.NineLives,
			Tooltip = this.Const.Strings.PerkDescription.NineLives,
			Icon = "ui/perks/perk_07.png",
			IconDisabled = "ui/perks/perk_07_sw.png"
		},
		{
			ID = "perk.bags_and_belts",
			Script = "scripts/skills/perks/perk_bags_and_belts",
			Name = this.Const.Strings.PerkName.BagsAndBelts,
			Tooltip = this.Const.Strings.PerkDescription.BagsAndBelts,
			Icon = "ui/perks/perk_20.png",
			IconDisabled = "ui/perks/perk_20_sw.png"
		},
		{
			ID = "perk.pathfinder",
			Script = "scripts/skills/perks/perk_pathfinder",
			Name = this.Const.Strings.PerkName.Pathfinder,
			Tooltip = this.Const.Strings.PerkDescription.Pathfinder,
			Icon = "ui/perks/perk_23.png",
			IconDisabled = "ui/perks/perk_23_sw.png"
		},
		{
			ID = "perk.adrenaline",
			Script = "scripts/skills/perks/perk_adrenalin",
			Name = this.Const.Strings.PerkName.Adrenalin,
			Tooltip = this.Const.Strings.PerkDescription.Adrenalin,
			Icon = "ui/perks/perk_37.png",
			IconDisabled = "ui/perks/perk_37_sw.png"
		},
		{
			ID = "perk.recover",
			Script = "scripts/skills/perks/perk_recover",
			Name = this.Const.Strings.PerkName.Recover,
			Tooltip = this.Const.Strings.PerkDescription.Recover,
			Icon = "ui/perks/perk_54.png",
			IconDisabled = "ui/perks/perk_54_sw.png"
		},
		{
			ID = "perk.student",
			Script = "scripts/skills/perks/perk_student",
			Name = this.Const.Strings.PerkName.Student,
			Tooltip = this.Const.Strings.PerkDescription.Student,
			Icon = "ui/perks/perk_21.png",
			IconDisabled = "ui/perks/perk_21_sw.png"
		}
	],
	[
		{
			ID = "perk.coup_de_grace",
			Script = "scripts/skills/perks/perk_coup_de_grace",
			Name = this.Const.Strings.PerkName.CoupDeGrace,
			Tooltip = this.Const.Strings.PerkDescription.CoupDeGrace,
			Icon = "ui/perks/perk_16.png",
			IconDisabled = "ui/perks/perk_16_sw.png"
		},
		{
			ID = "perk.bullseye",
			Script = "scripts/skills/perks/perk_bullseye",
			Name = this.Const.Strings.PerkName.Bullseye,
			Tooltip = this.Const.Strings.PerkDescription.Bullseye,
			Icon = "ui/perks/perk_17.png",
			IconDisabled = "ui/perks/perk_17_sw.png"
		},
		{
			ID = "perk.dodge",
			Script = "scripts/skills/perks/perk_dodge",
			Name = this.Const.Strings.PerkName.Dodge,
			Tooltip = this.Const.Strings.PerkDescription.Dodge,
			Icon = "ui/perks/perk_01.png",
			IconDisabled = "ui/perks/perk_01_sw.png"
		},
		{
			ID = "perk.fortified_mind",
			Script = "scripts/skills/perks/perk_fortified_mind",
			Name = this.Const.Strings.PerkName.FortifiedMind,
			Tooltip = this.Const.Strings.PerkDescription.FortifiedMind,
			Icon = "ui/perks/perk_08.png",
			IconDisabled = "ui/perks/perk_08_sw.png"
		},
		{
			ID = "perk.hold_out",
			Script = "scripts/skills/perks/perk_hold_out",
			Name = this.Const.Strings.PerkName.HoldOut,
			Tooltip = this.Const.Strings.PerkDescription.HoldOut,
			Icon = "ui/perks/perk_04.png",
			IconDisabled = "ui/perks/perk_04_sw.png"
		},
		{
			ID = "perk.steel_brow",
			Script = "scripts/skills/perks/perk_steel_brow",
			Name = this.Const.Strings.PerkName.SteelBrow,
			Tooltip = this.Const.Strings.PerkDescription.SteelBrow,
			Icon = "ui/perks/perk_09.png",
			IconDisabled = "ui/perks/perk_09_sw.png"
		},
		{
			ID = "perk.quick_hands",
			Script = "scripts/skills/perks/perk_quick_hands",
			Name = this.Const.Strings.PerkName.QuickHands,
			Tooltip = this.Const.Strings.PerkDescription.QuickHands,
			Icon = "ui/perks/perk_39.png",
			IconDisabled = "ui/perks/perk_39_sw.png"
		},
		{
			ID = "perk.gifted",
			Script = "scripts/skills/perks/perk_gifted",
			Name = this.Const.Strings.PerkName.Gifted,
			Tooltip = this.Const.Strings.PerkDescription.Gifted,
			Icon = "ui/perks/perk_56.png",
			IconDisabled = "ui/perks/perk_56_sw.png"
		}
	],
	[
		{
			ID = "perk.backstabber",
			Script = "scripts/skills/perks/perk_backstabber",
			Name = this.Const.Strings.PerkName.Backstabber,
			Tooltip = this.Const.Strings.PerkDescription.Backstabber,
			Icon = "ui/perks/perk_59.png",
			IconDisabled = "ui/perks/perk_59_sw.png"
		},
		{
			ID = "perk.anticipation",
			Script = "scripts/skills/perks/perk_anticipation",
			Name = this.Const.Strings.PerkName.Anticipation,
			Tooltip = this.Const.Strings.PerkDescription.Anticipation,
			Icon = "ui/perks/perk_10.png",
			IconDisabled = "ui/perks/perk_10_sw.png"
		},
		{
			ID = "perk.shield_expert",
			Script = "scripts/skills/perks/perk_shield_expert",
			Name = this.Const.Strings.PerkName.ShieldExpert,
			Tooltip = this.Const.Strings.PerkDescription.ShieldExpert,
			Icon = "ui/perks/perk_05.png",
			IconDisabled = "ui/perks/perk_05_sw.png"
		},
		{
			ID = "perk.brawny",
			Script = "scripts/skills/perks/perk_brawny",
			Name = this.Const.Strings.PerkName.Brawny,
			Tooltip = this.Const.Strings.PerkDescription.Brawny,
			Icon = "ui/perks/perk_40.png",
			IconDisabled = "ui/perks/perk_40_sw.png"
		},
		{
			ID = "perk.relentless",
			Script = "scripts/skills/perks/perk_relentless",
			Name = this.Const.Strings.PerkName.Relentless,
			Tooltip = this.Const.Strings.PerkDescription.Relentless,
			Icon = "ui/perks/perk_26.png",
			IconDisabled = "ui/perks/perk_26_sw.png"
		},
		{
			ID = "perk.rotation",
			Script = "scripts/skills/perks/perk_rotation",
			Name = this.Const.Strings.PerkName.Rotation,
			Tooltip = this.Const.Strings.PerkDescription.Rotation,
			Icon = "ui/perks/perk_11.png",
			IconDisabled = "ui/perks/perk_11_sw.png"
		},
		{
			ID = "perk.rally_the_troops",
			Script = "scripts/skills/perks/perk_rally_the_troops",
			Name = this.Const.Strings.PerkName.RallyTheTroops,
			Tooltip = this.Const.Strings.PerkDescription.RallyTheTroops,
			Icon = "ui/perks/perk_42.png",
			IconDisabled = "ui/perks/perk_42_sw.png"
		},
		{
			ID = "perk.taunt",
			Script = "scripts/skills/perks/perk_taunt",
			Name = this.Const.Strings.PerkName.Taunt,
			Tooltip = this.Const.Strings.PerkDescription.Taunt,
			Icon = "ui/perks/perk_38.png",
			IconDisabled = "ui/perks/perk_38_sw.png"
		}
	],
	[
		{
			ID = "perk.mastery.mace",
			Script = "scripts/skills/perks/perk_mastery_mace",
			Name = this.Const.Strings.PerkName.SpecMace,
			Tooltip = this.Const.Strings.PerkDescription.SpecMace,
			Icon = "ui/perks/perk_43.png",
			IconDisabled = "ui/perks/perk_43_sw.png"
		},
		{
			ID = "perk.mastery.flail",
			Script = "scripts/skills/perks/perk_mastery_flail",
			Name = this.Const.Strings.PerkName.SpecFlail,
			Tooltip = this.Const.Strings.PerkDescription.SpecFlail,
			Icon = "ui/perks/perk_47.png",
			IconDisabled = "ui/perks/perk_47_sw.png"
		},
		{
			ID = "perk.mastery.hammer",
			Script = "scripts/skills/perks/perk_mastery_hammer",
			Name = this.Const.Strings.PerkName.SpecHammer,
			Tooltip = this.Const.Strings.PerkDescription.SpecHammer,
			Icon = "ui/perks/perk_53.png",
			IconDisabled = "ui/perks/perk_53_sw.png"
		},
		{
			ID = "perk.mastery.axe",
			Script = "scripts/skills/perks/perk_mastery_axe",
			Name = this.Const.Strings.PerkName.SpecAxe,
			Tooltip = this.Const.Strings.PerkDescription.SpecAxe,
			Icon = "ui/perks/perk_44.png",
			IconDisabled = "ui/perks/perk_44_sw.png"
		},
		{
			ID = "perk.mastery.cleaver",
			Script = "scripts/skills/perks/perk_mastery_cleaver",
			Name = this.Const.Strings.PerkName.SpecCleaver,
			Tooltip = this.Const.Strings.PerkDescription.SpecCleaver,
			Icon = "ui/perks/perk_52.png",
			IconDisabled = "ui/perks/perk_52_sw.png"
		},
		{
			ID = "perk.mastery.sword",
			Script = "scripts/skills/perks/perk_mastery_sword",
			Name = this.Const.Strings.PerkName.SpecSword,
			Tooltip = this.Const.Strings.PerkDescription.SpecSword,
			Icon = "ui/perks/perk_46.png",
			IconDisabled = "ui/perks/perk_46_sw.png"
		},
		{
			ID = "perk.mastery.dagger",
			Script = "scripts/skills/perks/perk_mastery_dagger",
			Name = this.Const.Strings.PerkName.SpecDagger,
			Tooltip = this.Const.Strings.PerkDescription.SpecDagger,
			Icon = "ui/perks/perk_51.png",
			IconDisabled = "ui/perks/perk_51_sw.png"
		},
		{
			ID = "perk.mastery.polearm",
			Script = "scripts/skills/perks/perk_mastery_polearm",
			Name = this.Const.Strings.PerkName.SpecPolearm,
			Tooltip = this.Const.Strings.PerkDescription.SpecPolearm,
			Icon = "ui/perks/perk_58.png",
			IconDisabled = "ui/perks/perk_58_sw.png"
		},
		{
			ID = "perk.mastery.spear",
			Script = "scripts/skills/perks/perk_mastery_spear",
			Name = this.Const.Strings.PerkName.SpecSpear,
			Tooltip = this.Const.Strings.PerkDescription.SpecSpear,
			Icon = "ui/perks/perk_45.png",
			IconDisabled = "ui/perks/perk_45_sw.png"
		},
		{
			ID = "perk.mastery.crossbow",
			Script = "scripts/skills/perks/perk_mastery_crossbow",
			Name = this.Const.Strings.PerkName.SpecCrossbow,
			Tooltip = this.Const.Strings.PerkDescription.SpecCrossbow,
			Icon = "ui/perks/perk_48.png",
			IconDisabled = "ui/perks/perk_48_sw.png"
		},
		{
			ID = "perk.mastery.bow",
			Script = "scripts/skills/perks/perk_mastery_bow",
			Name = this.Const.Strings.PerkName.SpecBow,
			Tooltip = this.Const.Strings.PerkDescription.SpecBow,
			Icon = "ui/perks/perk_49.png",
			IconDisabled = "ui/perks/perk_49_sw.png"
		},
		{
			ID = "perk.mastery.throwing",
			Script = "scripts/skills/perks/perk_mastery_throwing",
			Name = this.Const.Strings.PerkName.SpecThrowing,
			Tooltip = this.Const.Strings.PerkDescription.SpecThrowing,
			Icon = "ui/perks/perk_50.png",
			IconDisabled = "ui/perks/perk_50_sw.png"
		}
	],
	[
		{
			ID = "perk.reach_advantage",
			Script = "scripts/skills/perks/perk_reach_advantage",
			Name = this.Const.Strings.PerkName.ReachAdvantage,
			Tooltip = this.Const.Strings.PerkDescription.ReachAdvantage,
			Icon = "ui/perks/perk_19.png",
			IconDisabled = "ui/perks/perk_19_sw.png"
		},
		{
			ID = "perk.overwhelm",
			Script = "scripts/skills/perks/perk_overwhelm",
			Name = this.Const.Strings.PerkName.Overwhelm,
			Tooltip = this.Const.Strings.PerkDescription.Overwhelm,
			Icon = "ui/perks/perk_62.png",
			IconDisabled = "ui/perks/perk_62_sw.png"
		},
		{
			ID = "perk.lone_wolf",
			Script = "scripts/skills/perks/perk_lone_wolf",
			Name = this.Const.Strings.PerkName.LoneWolf,
			Tooltip = this.Const.Strings.PerkDescription.LoneWolf,
			Icon = "ui/perks/perk_61.png",
			IconDisabled = "ui/perks/perk_61_sw.png"
		},
		{
			ID = "perk.underdog",
			Script = "scripts/skills/perks/perk_underdog",
			Name = this.Const.Strings.PerkName.Underdog,
			Tooltip = this.Const.Strings.PerkDescription.Underdog,
			Icon = "ui/perks/perk_60.png",
			IconDisabled = "ui/perks/perk_60_sw.png"
		},
		{
			ID = "perk.footwork",
			Script = "scripts/skills/perks/perk_footwork",
			Name = this.Const.Strings.PerkName.Footwork,
			Tooltip = this.Const.Strings.PerkDescription.Footwork,
			Icon = "ui/perks/perk_25.png",
			IconDisabled = "ui/perks/perk_25_sw.png"
		}
	],
	[
		{
			ID = "perk.berserk",
			Script = "scripts/skills/perks/perk_berserk",
			Name = this.Const.Strings.PerkName.Berserk,
			Tooltip = this.Const.Strings.PerkDescription.Berserk,
			Icon = "ui/perks/perk_35.png",
			IconDisabled = "ui/perks/perk_35_sw.png"
		},
		{
			ID = "perk.head_hunter",
			Script = "scripts/skills/perks/perk_head_hunter",
			Name = this.Const.Strings.PerkName.HeadHunter,
			Tooltip = this.Const.Strings.PerkDescription.HeadHunter,
			Icon = "ui/perks/perk_15.png",
			IconDisabled = "ui/perks/perk_15_sw.png"
		},
		{
			ID = "perk.nimble",
			Script = "scripts/skills/perks/perk_nimble",
			Name = this.Const.Strings.PerkName.Nimble,
			Tooltip = this.Const.Strings.PerkDescription.Nimble,
			Icon = "ui/perks/perk_29.png",
			IconDisabled = "ui/perks/perk_29_sw.png"
		},
		{
			ID = "perk.battle_forged",
			Script = "scripts/skills/perks/perk_battle_forged",
			Name = this.Const.Strings.PerkName.BattleForged,
			Tooltip = this.Const.Strings.PerkDescription.BattleForged,
			Icon = "ui/perks/perk_03.png",
			IconDisabled = "ui/perks/perk_03_sw.png"
		}
	],
	[
		{
			ID = "perk.fearsome",
			Script = "scripts/skills/perks/perk_fearsome",
			Name = this.Const.Strings.PerkName.Fearsome,
			Tooltip = this.Const.Strings.PerkDescription.Fearsome,
			Icon = "ui/perks/perk_27.png",
			IconDisabled = "ui/perks/perk_27_sw.png"
		},
		{
			ID = "perk.duelist",
			Script = "scripts/skills/perks/perk_duelist",
			Name = this.Const.Strings.PerkName.Duelist,
			Tooltip = this.Const.Strings.PerkDescription.Duelist,
			Icon = "ui/perks/perk_41.png",
			IconDisabled = "ui/perks/perk_41_sw.png"
		},
		{
			ID = "perk.killing_frenzy",
			Script = "scripts/skills/perks/perk_killing_frenzy",
			Name = this.Const.Strings.PerkName.KillingFrenzy,
			Tooltip = this.Const.Strings.PerkDescription.KillingFrenzy,
			Icon = "ui/perks/perk_36.png",
			IconDisabled = "ui/perks/perk_36_sw.png"
		},
		{
			ID = "perk.indomitable",
			Script = "scripts/skills/perks/perk_indomitable",
			Name = this.Const.Strings.PerkName.Indomitable,
			Tooltip = this.Const.Strings.PerkDescription.Indomitable,
			Icon = "ui/perks/perk_30.png",
			IconDisabled = "ui/perks/perk_30_sw.png"
		}
	],
	[],
	[],
	[],
	[]
];
gt.Const.Perks.LookupMap <- {};

for( local row = 0; row < this.Const.Perks.Perks.len(); row = ++row )
{
	for( local i = 0; i < this.Const.Perks.Perks[row].len(); i = ++i )
	{
		local perk = this.Const.Perks.Perks[row][i];
		perk.Row <- row; // This
		perk.Unlocks <- row; // And this seems to be clutter, never used anywhere
		gt.Const.Perks.LookupMap[perk.ID] <- perk;
	}
}

gt.Const.Perks.findById <- function ( _perkID )
{
	if (_perkID != null && _perkID in this.Const.Perks.LookupMap)
	{
		return this.Const.Perks.LookupMap[_perkID];
	}

	return null;
};

