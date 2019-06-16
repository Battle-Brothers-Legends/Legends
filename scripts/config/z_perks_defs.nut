local gt = this.getroottable();

if (!("Perks" in gt.Const))
{
	gt.Const.Perks <- {};
}

gt.Const.Perks.PerkDefObjects <- [
	{
		ID = "perk.fast_adaption",
		Script = "scripts/skills/perks/perk_fast_adaption",
		Name = this.Const.Strings.PerkName.FastAdaption,
		Tooltip = this.Const.Strings.PerkDescription.FastAdaption,
		Icon = "ui/perks/perk_33.png",
		IconDisabled = "ui/perks/perk_33_sw.png",
		Const = "FastAdaption"
	},
	{
		ID = "perk.crippling_strikes",
		Script = "scripts/skills/perks/perk_crippling_strikes",
		Name = this.Const.Strings.PerkName.CripplingStrikes,
		Tooltip = this.Const.Strings.PerkDescription.CripplingStrikes,
		Icon = "ui/perks/perk_57.png",
		IconDisabled = "ui/perks/perk_57_sw.png",
		Const = "CripplingStrikes"
	},
	{
		ID = "perk.colossus",
		Script = "scripts/skills/perks/perk_colossus",
		Name = this.Const.Strings.PerkName.Colossus,
		Tooltip = this.Const.Strings.PerkDescription.Colossus,
		Icon = "ui/perks/perk_06.png",
		IconDisabled = "ui/perks/perk_06_sw.png",
		Const = "Colossus"
	},
	{
		ID = "perk.nine_lives",
		Script = "scripts/skills/perks/perk_nine_lives",
		Name = this.Const.Strings.PerkName.NineLives,
		Tooltip = this.Const.Strings.PerkDescription.NineLives,
		Icon = "ui/perks/perk_07.png",
		IconDisabled = "ui/perks/perk_07_sw.png",
		Const = "NineLives"
	},
	{
		ID = "perk.bags_and_belts",
		Script = "scripts/skills/perks/perk_bags_and_belts",
		Name = this.Const.Strings.PerkName.BagsAndBelts,
		Tooltip = this.Const.Strings.PerkDescription.BagsAndBelts,
		Icon = "ui/perks/perk_20.png",
		IconDisabled = "ui/perks/perk_20_sw.png",
		Const = "BagsAndBelts"
	},
	{
		ID = "perk.pathfinder",
		Script = "scripts/skills/perks/perk_pathfinder",
		Name = this.Const.Strings.PerkName.Pathfinder,
		Tooltip = this.Const.Strings.PerkDescription.Pathfinder,
		Icon = "ui/perks/perk_23.png",
		IconDisabled = "ui/perks/perk_23_sw.png",
		Const = "Pathfinder"
	},
	{
		ID = "perk.adrenaline",
		Script = "scripts/skills/perks/perk_adrenalin",
		Name = this.Const.Strings.PerkName.Adrenalin,
		Tooltip = this.Const.Strings.PerkDescription.Adrenalin,
		Icon = "ui/perks/perk_37.png",
		IconDisabled = "ui/perks/perk_37_sw.png"
		Const = "Adrenalin"
	},
	{
		ID = "perk.recover",
		Script = "scripts/skills/perks/perk_recover",
		Name = this.Const.Strings.PerkName.Recover,
		Tooltip = this.Const.Strings.PerkDescription.Recover,
		Icon = "ui/perks/perk_54.png",
		IconDisabled = "ui/perks/perk_54_sw.png",
		Const = "Recover"
	},
	{
		ID = "perk.student",
		Script = "scripts/skills/perks/perk_student",
		Name = this.Const.Strings.PerkName.Student,
		Tooltip = this.Const.Strings.PerkDescription.Student,
		Icon = "ui/perks/perk_21.png",
		IconDisabled = "ui/perks/perk_21_sw.png",
		Const = "Student"
	},
	{
		ID = "perk.coup_de_grace",
		Script = "scripts/skills/perks/perk_coup_de_grace",
		Name = this.Const.Strings.PerkName.CoupDeGrace,
		Tooltip = this.Const.Strings.PerkDescription.CoupDeGrace,
		Icon = "ui/perks/perk_16.png",
		IconDisabled = "ui/perks/perk_16_sw.png",
		Const = "CoupDeGrace"
	},
	{
		ID = "perk.bullseye",
		Script = "scripts/skills/perks/perk_bullseye",
		Name = this.Const.Strings.PerkName.Bullseye,
		Tooltip = this.Const.Strings.PerkDescription.Bullseye,
		Icon = "ui/perks/perk_17.png",
		IconDisabled = "ui/perks/perk_17_sw.png",
		Const = "Bullseye"
	},
	{
		ID = "perk.dodge",
		Script = "scripts/skills/perks/perk_dodge",
		Name = this.Const.Strings.PerkName.Dodge,
		Tooltip = this.Const.Strings.PerkDescription.Dodge,
		Icon = "ui/perks/perk_01.png",
		IconDisabled = "ui/perks/perk_01_sw.png",
		Const = "Dodge"
	},
	{
		ID = "perk.fortified_mind",
		Script = "scripts/skills/perks/perk_fortified_mind",
		Name = this.Const.Strings.PerkName.FortifiedMind,
		Tooltip = this.Const.Strings.PerkDescription.FortifiedMind,
		Icon = "ui/perks/perk_08.png",
		IconDisabled = "ui/perks/perk_08_sw.png",
		Const = "FortifiedMind"
	},
	{
		ID = "perk.hold_out",
		Script = "scripts/skills/perks/perk_hold_out",
		Name = this.Const.Strings.PerkName.HoldOut,
		Tooltip = this.Const.Strings.PerkDescription.HoldOut,
		Icon = "ui/perks/perk_04.png",
		IconDisabled = "ui/perks/perk_04_sw.png",
		Const = "HoldOut"
	},
	{
		ID = "perk.steel_brow",
		Script = "scripts/skills/perks/perk_steel_brow",
		Name = this.Const.Strings.PerkName.SteelBrow,
		Tooltip = this.Const.Strings.PerkDescription.SteelBrow,
		Icon = "ui/perks/perk_09.png",
		IconDisabled = "ui/perks/perk_09_sw.png",
		Const = "SteelBrow"
	},
	{
		ID = "perk.quick_hands",
		Script = "scripts/skills/perks/perk_quick_hands",
		Name = this.Const.Strings.PerkName.QuickHands,
		Tooltip = this.Const.Strings.PerkDescription.QuickHands,
		Icon = "ui/perks/perk_39.png",
		IconDisabled = "ui/perks/perk_39_sw.png",
		Const = "QuickHands"
	},
	{
		ID = "perk.gifted",
		Script = "scripts/skills/perks/perk_gifted",
		Name = this.Const.Strings.PerkName.Gifted,
		Tooltip = this.Const.Strings.PerkDescription.Gifted,
		Icon = "ui/perks/perk_56.png",
		IconDisabled = "ui/perks/perk_56_sw.png",
		Const = "Gifted"
	},
	{
		ID = "perk.backstabber",
		Script = "scripts/skills/perks/perk_backstabber",
		Name = this.Const.Strings.PerkName.Backstabber,
		Tooltip = this.Const.Strings.PerkDescription.Backstabber,
		Icon = "ui/perks/perk_59.png",
		IconDisabled = "ui/perks/perk_59_sw.png",
		Const = "Backstabber"
	},
	{
		ID = "perk.anticipation",
		Script = "scripts/skills/perks/perk_anticipation",
		Name = this.Const.Strings.PerkName.Anticipation,
		Tooltip = this.Const.Strings.PerkDescription.Anticipation,
		Icon = "ui/perks/perk_10.png",
		IconDisabled = "ui/perks/perk_10_sw.png",
		Const = "Anticipation"
	},
	{
		ID = "perk.shield_expert",
		Script = "scripts/skills/perks/perk_shield_expert",
		Name = this.Const.Strings.PerkName.ShieldExpert,
		Tooltip = this.Const.Strings.PerkDescription.ShieldExpert,
		Icon = "ui/perks/perk_05.png",
		IconDisabled = "ui/perks/perk_05_sw.png",
		Const = "ShieldExpert"
	},
	{
		ID = "perk.brawny",
		Script = "scripts/skills/perks/perk_brawny",
		Name = this.Const.Strings.PerkName.Brawny,
		Tooltip = this.Const.Strings.PerkDescription.Brawny,
		Icon = "ui/perks/perk_40.png",
		IconDisabled = "ui/perks/perk_40_sw.png",
		Const = "Brawny"
	},
	{
		ID = "perk.rotation",
		Script = "scripts/skills/perks/perk_rotation",
		Name = this.Const.Strings.PerkName.Rotation,
		Tooltip = this.Const.Strings.PerkDescription.Rotation,
		Icon = "ui/perks/perk_11.png",
		IconDisabled = "ui/perks/perk_11_sw.png",
		Const = "Rotation"
	},
	{
		ID = "perk.rally_the_troops",
		Script = "scripts/skills/perks/perk_rally_the_troops",
		Name = this.Const.Strings.PerkName.RallyTheTroops,
		Tooltip = this.Const.Strings.PerkDescription.RallyTheTroops,
		Icon = "ui/perks/perk_42.png",
		IconDisabled = "ui/perks/perk_42_sw.png",
		Const = "RallyTheTroops"
	},
	{
		ID = "perk.taunt",
		Script = "scripts/skills/perks/perk_taunt",
		Name = this.Const.Strings.PerkName.Taunt,
		Tooltip = this.Const.Strings.PerkDescription.Taunt,
		Icon = "ui/perks/perk_38.png",
		IconDisabled = "ui/perks/perk_38_sw.png",
		Const = "Taunt"
	},
	{
		ID = "perk.mastery.mace",
		Script = "scripts/skills/perks/perk_mastery_mace",
		Name = this.Const.Strings.PerkName.SpecMace,
		Tooltip = this.Const.Strings.PerkDescription.SpecMace,
		Icon = "ui/perks/perk_43.png",
		IconDisabled = "ui/perks/perk_43_sw.png",
		Const = "SpecMace"
	},
	{
		ID = "perk.mastery.flail",
		Script = "scripts/skills/perks/perk_mastery_flail",
		Name = this.Const.Strings.PerkName.SpecFlail,
		Tooltip = this.Const.Strings.PerkDescription.SpecFlail,
		Icon = "ui/perks/perk_47.png",
		IconDisabled = "ui/perks/perk_47_sw.png",
		Const = "SpecFlail"
	},
	{
		ID = "perk.mastery.hammer",
		Script = "scripts/skills/perks/perk_mastery_hammer",
		Name = this.Const.Strings.PerkName.SpecHammer,
		Tooltip = this.Const.Strings.PerkDescription.SpecHammer,
		Icon = "ui/perks/perk_53.png",
		IconDisabled = "ui/perks/perk_53_sw.png",
		Const = "SpecHammer"
	},
	{
		ID = "perk.mastery.axe",
		Script = "scripts/skills/perks/perk_mastery_axe",
		Name = this.Const.Strings.PerkName.SpecAxe,
		Tooltip = this.Const.Strings.PerkDescription.SpecAxe,
		Icon = "ui/perks/perk_44.png",
		IconDisabled = "ui/perks/perk_44_sw.png",
		Const = "SpecAxe"
	},
	{
		ID = "perk.mastery.cleaver",
		Script = "scripts/skills/perks/perk_mastery_cleaver",
		Name = this.Const.Strings.PerkName.SpecCleaver,
		Tooltip = this.Const.Strings.PerkDescription.SpecCleaver,
		Icon = "ui/perks/perk_52.png",
		IconDisabled = "ui/perks/perk_52_sw.png",
		Const = "SpecCleaver"
	},
	{
		ID = "perk.mastery.sword",
		Script = "scripts/skills/perks/perk_mastery_sword",
		Name = this.Const.Strings.PerkName.SpecSword,
		Tooltip = this.Const.Strings.PerkDescription.SpecSword,
		Icon = "ui/perks/perk_46.png",
		IconDisabled = "ui/perks/perk_46_sw.png",
		Const = "SpecSword"
	},
	{
		ID = "perk.mastery.dagger",
		Script = "scripts/skills/perks/perk_mastery_dagger",
		Name = this.Const.Strings.PerkName.SpecDagger,
		Tooltip = this.Const.Strings.PerkDescription.SpecDagger,
		Icon = "ui/perks/perk_51.png",
		IconDisabled = "ui/perks/perk_51_sw.png",
		Const = "SpecDagger"
	},
	{
		ID = "perk.mastery.polearm",
		Script = "scripts/skills/perks/perk_mastery_polearm",
		Name = this.Const.Strings.PerkName.SpecPolearm,
		Tooltip = this.Const.Strings.PerkDescription.SpecPolearm,
		Icon = "ui/perks/perk_58.png",
		IconDisabled = "ui/perks/perk_58_sw.png",
		Const = "SpecPolearm"
	},
	{
		ID = "perk.mastery.spear",
		Script = "scripts/skills/perks/perk_mastery_spear",
		Name = this.Const.Strings.PerkName.SpecSpear,
		Tooltip = this.Const.Strings.PerkDescription.SpecSpear,
		Icon = "ui/perks/perk_45.png",
		IconDisabled = "ui/perks/perk_45_sw.png",
		Const = "SpecSpear"
	},
	{
		ID = "perk.mastery.crossbow",
		Script = "scripts/skills/perks/perk_mastery_crossbow",
		Name = this.Const.Strings.PerkName.SpecCrossbow,
		Tooltip = this.Const.Strings.PerkDescription.SpecCrossbow,
		Icon = "ui/perks/perk_48.png",
		IconDisabled = "ui/perks/perk_48_sw.png",
		Const = "SpecCrossbow"
	},
	{
		ID = "perk.mastery.bow",
		Script = "scripts/skills/perks/perk_mastery_bow",
		Name = this.Const.Strings.PerkName.SpecBow,
		Tooltip = this.Const.Strings.PerkDescription.SpecBow,
		Icon = "ui/perks/perk_49.png",
		IconDisabled = "ui/perks/perk_49_sw.png",
		Const = "SpecBow"
	},
	{
		ID = "perk.mastery.throwing",
		Script = "scripts/skills/perks/perk_mastery_throwing",
		Name = this.Const.Strings.PerkName.SpecThrowing,
		Tooltip = this.Const.Strings.PerkDescription.SpecThrowing,
		Icon = "ui/perks/perk_50.png",
		IconDisabled = "ui/perks/perk_50_sw.png",
		Const = "SpecThrowing"
	},
	{
		ID = "perk.reach_advantage",
		Script = "scripts/skills/perks/perk_reach_advantage",
		Name = this.Const.Strings.PerkName.ReachAdvantage,
		Tooltip = this.Const.Strings.PerkDescription.ReachAdvantage,
		Icon = "ui/perks/perk_19.png",
		IconDisabled = "ui/perks/perk_19_sw.png",
		Const = "ReachAdvantage"
	},
	{
		ID = "perk.overwhelm",
		Script = "scripts/skills/perks/perk_overwhelm",
		Name = this.Const.Strings.PerkName.Overwhelm,
		Tooltip = this.Const.Strings.PerkDescription.Overwhelm,
		Icon = "ui/perks/perk_62.png",
		IconDisabled = "ui/perks/perk_62_sw.png",
		Const = "Overwhelm"
	},
	{
		ID = "perk.lone_wolf",
		Script = "scripts/skills/perks/perk_lone_wolf",
		Name = this.Const.Strings.PerkName.LoneWolf,
		Tooltip = this.Const.Strings.PerkDescription.LoneWolf,
		Icon = "ui/perks/perk_61.png",
		IconDisabled = "ui/perks/perk_61_sw.png",
		Const = "LoneWolf"
	},
	{
		ID = "perk.underdog",
		Script = "scripts/skills/perks/perk_underdog",
		Name = this.Const.Strings.PerkName.Underdog,
		Tooltip = this.Const.Strings.PerkDescription.Underdog,
		Icon = "ui/perks/perk_60.png",
		IconDisabled = "ui/perks/perk_60_sw.png",
		Const = "Underdog"
	},
	{
		ID = "perk.footwork",
		Script = "scripts/skills/perks/perk_footwork",
		Name = this.Const.Strings.PerkName.Footwork,
		Tooltip = this.Const.Strings.PerkDescription.Footwork,
		Icon = "ui/perks/perk_25.png",
		IconDisabled = "ui/perks/perk_25_sw.png",
		Const = "Footwork"
	},
	{
		ID = "perk.berserk",
		Script = "scripts/skills/perks/perk_berserk",
		Name = this.Const.Strings.PerkName.Berserk,
		Tooltip = this.Const.Strings.PerkDescription.Berserk,
		Icon = "ui/perks/perk_35.png",
		IconDisabled = "ui/perks/perk_35_sw.png",
		Const = "Berserk"
	},
	{
		ID = "perk.head_hunter",
		Script = "scripts/skills/perks/perk_head_hunter",
		Name = this.Const.Strings.PerkName.HeadHunter,
		Tooltip = this.Const.Strings.PerkDescription.HeadHunter,
		Icon = "ui/perks/perk_15.png",
		IconDisabled = "ui/perks/perk_15_sw.png",
		Const = "HeadHunter"
	},
	{
		ID = "perk.nimble",
		Script = "scripts/skills/perks/perk_nimble",
		Name = this.Const.Strings.PerkName.Nimble,
		Tooltip = this.Const.Strings.PerkDescription.Nimble,
		Icon = "ui/perks/perk_29.png",
		IconDisabled = "ui/perks/perk_29_sw.png",
		Const = "Nimble"
	},
	{
		ID = "perk.battle_forged",
		Script = "scripts/skills/perks/perk_battle_forged",
		Name = this.Const.Strings.PerkName.BattleForged,
		Tooltip = this.Const.Strings.PerkDescription.BattleForged,
		Icon = "ui/perks/perk_03.png",
		IconDisabled = "ui/perks/perk_03_sw.png",
		Const = "BattleForged"
	},
	{
		ID = "perk.fearsome",
		Script = "scripts/skills/perks/perk_fearsome",
		Name = this.Const.Strings.PerkName.Fearsome,
		Tooltip = this.Const.Strings.PerkDescription.Fearsome,
		Icon = "ui/perks/perk_27.png",
		IconDisabled = "ui/perks/perk_27_sw.png",
		Const = "Fearsome"
	},
	{
		ID = "perk.duelist",
		Script = "scripts/skills/perks/perk_duelist",
		Name = this.Const.Strings.PerkName.Duelist,
		Tooltip = this.Const.Strings.PerkDescription.Duelist,
		Icon = "ui/perks/perk_41.png",
		IconDisabled = "ui/perks/perk_41_sw.png",
		Const = "Duelist"
	},
	{
		ID = "perk.killing_frenzy",
		Script = "scripts/skills/perks/perk_killing_frenzy",
		Name = this.Const.Strings.PerkName.KillingFrenzy,
		Tooltip = this.Const.Strings.PerkDescription.KillingFrenzy,
		Icon = "ui/perks/perk_36.png",
		IconDisabled = "ui/perks/perk_36_sw.png",
		Const = "KillingFrenzy"
	},
	{
		ID = "perk.indomitable",
		Script = "scripts/skills/perks/perk_indomitable",
		Name = this.Const.Strings.PerkName.Indomitable,
		Tooltip = this.Const.Strings.PerkDescription.Indomitable,
		Icon = "ui/perks/perk_30.png",
		IconDisabled = "ui/perks/perk_30_sw.png",
		Const = "Indomitable"
	},
	{
		ID = "perk.legend_daze",
		Script = "scripts/skills/perks/perk_legend_daze",
		Name = this.Const.Strings.PerkName.LegendDaze,
		Tooltip = this.Const.Strings.PerkDescription.LegendDaze,
		Icon = "ui/perks/daze56_circle.png",
		IconDisabled = "ui/perks/daze56_circle_bw.png",
		Const = "LegendDaze"
	},
	{
		ID = "perk.legend_roster_1",
		Script = "scripts/skills/perks/perk_legend_roster_1",
		Name = this.Const.Strings.PerkName.LegendRoster1,
		Tooltip = this.Const.Strings.PerkDescription.LegendRoster1,
		Icon = "ui/perks/recruit1.png",
		IconDisabled = "ui/perks/recruit1_bw.png",
		Const = "LegendRoster1"
	},
	{
		ID = "perk.legend_roster_2",
		Script = "scripts/skills/perks/perk_legend_roster_2",
		Name = this.Const.Strings.PerkName.LegendRoster2,
		Tooltip = this.Const.Strings.PerkDescription.LegendRoster2,
		Icon = "ui/perks/recruit2.png",
		IconDisabled = "ui/perks/recruit2_bw.png",
		Const = "LegendRoster2"
	},			
	{
		ID = "perk.legend_roster_3",
		Script = "scripts/skills/perks/perk_legend_roster_3",
		Name = this.Const.Strings.PerkName.LegendRoster3,
		Tooltip = this.Const.Strings.PerkDescription.LegendRoster3,
		Icon = "ui/perks/recruit3.png",
		IconDisabled = "ui/perks/recruit3_bw.png",
		Const = "LegendRoster3"
	},
	{
		ID = "perk.legend_roster_4",
		Script = "scripts/skills/perks/perk_legend_roster_4",
		Name = this.Const.Strings.PerkName.LegendRoster4,
		Tooltip = this.Const.Strings.PerkDescription.LegendRoster4,
		Icon = "ui/perks/recruit4.png",
		IconDisabled = "ui/perks/recruit4_bw.png",
		Const = "LegendRoster4"
	},
	{
		ID = "perk.legend_roster_5",
		Script = "scripts/skills/perks/perk_legend_roster_5",
		Name = this.Const.Strings.PerkName.LegendRoster5,
		Tooltip = this.Const.Strings.PerkDescription.LegendRoster5,
		Icon = "ui/perks/recruit5.png",
		IconDisabled = "ui/perks/recruit5_bw.png",
		Const = "LegendRoster5"
	},
	{
		ID = "perk.legend_roster_6",
		Script = "scripts/skills/perks/perk_legend_roster_6",
		Name = this.Const.Strings.PerkName.LegendRoster6,
		Tooltip = this.Const.Strings.PerkDescription.LegendRoster6,
		Icon = "ui/perks/recruit6.png",
		IconDisabled = "ui/perks/recruit6_bw.png",
		Const = "LegendRoster6"
	},
	{
		ID = "perk.legend_roster_7",
		Script = "scripts/skills/perks/perk_legend_roster_7",
		Name = this.Const.Strings.PerkName.LegendRoster7,
		Tooltip = this.Const.Strings.PerkDescription.LegendRoster7,
		Icon = "ui/perks/recruit7.png",
		IconDisabled = "ui/perks/recruit7_bw.png",
		Const = "LegendRoster7"
	},
	{
		ID = "perk.legend_stun",
		Script = "scripts/skills/perks/perk_legend_stun",
		Name = this.Const.Strings.PerkName.LegendStunned,
		Tooltip = this.Const.Strings.PerkDescription.LegendStunned,
		Icon = "ui/perks/stun56_circle.png",
		IconDisabled = "ui/perks/stun56_circle_bw.png",
		Const = "LegendStunned"
	},
	{
		ID = "perk.legend_horrify",
		Script = "scripts/skills/perks/perk_legend_horrify",
		Name = this.Const.Strings.PerkName.LegendHorrify,
		Tooltip = this.Const.Strings.PerkDescription.LegendHorrify,
		Icon = "ui/perks/horrify56_circle.png",
		IconDisabled = "ui/perks/horrify56_circle_bw.png",
		Const = "LegendHorrify"
	},
	{
		ID = "perk.legend_entice",
		Script = "scripts/skills/perks/perk_legend_entice",
		Name = this.Const.Strings.PerkName.LegendEntice,
		Tooltip = this.Const.Strings.PerkDescription.LegendEntice,
		Icon = "ui/perks/entice_circle_56.png",
		IconDisabled = "ui/perks/entice_circle_56_bw.png",
		Const = "LegendEntice"
	},
	{
		ID = "perk.legend_push",
		Script = "scripts/skills/perks/perk_legend_push",
		Name = this.Const.Strings.PerkName.LegendPush,
		Tooltip = this.Const.Strings.PerkDescription.LegendPush,
		Icon = "ui/perks/revolt56_circle.png",
		IconDisabled = "ui/perks/revolt56_circle_bw.png",
		Const = "LegendPush"
	},
	{
		ID = "perk.legend_perfect_focus",
		Script = "scripts/skills/perks/perk_legend_perfect_focus",
		Name = this.Const.Strings.PerkName.PerfectFocus,
		Tooltip = this.Const.Strings.PerkDescription.PerfectFocus,
		Icon = "ui/perks/perfectfocus_circle.png",
		IconDisabled = "ui/perks/perfectfocus_circle_bw.png",
		Const = "PerfectFocus"
	},
	{
		ID = "perk.legend_firefield",
		Script = "scripts/skills/perks/perk_legend_firefield",
		Name = this.Const.Strings.PerkName.LegendFirefield,
		Tooltip = this.Const.Strings.PerkDescription.LegendFirefield,
		Icon = "ui/perks/fire_circle.png",
		IconDisabled = "ui/perks/fire_circle_bw.png",
		Const = "LegendFirefield"
	},
	{
		ID = "perk.legend_sleep",
		Script = "scripts/skills/perks/perk_legend_sleep",
		Name = this.Const.Strings.PerkName.LegendSleep,
		Tooltip = this.Const.Strings.PerkDescription.LegendSleep,
		Icon = "ui/perks/sleep_56.png",
		IconDisabled = "ui/perks/sleep_56_bw.png",
		Const = "LegendSleep"
	},
	{
		ID = "perk.full_force",
		Script = "scripts/skills/perks/perk_full_force",
		Name = this.Const.Strings.PerkName.FullForce,
		Tooltip = this.Const.Strings.PerkDescription.FullForce,
		Icon = "ui/perks/fullforce_circle.png",
		IconDisabled = "ui/perks/fullforce_circle_bw.png",
		Const = "FullForce"
	},
	{
		ID = "perk.return_favor",
		Script = "scripts/skills/perks/perk_return_favor",
		Name = this.Const.Strings.PerkName.ReturnFavor,
		Tooltip = this.Const.Strings.PerkDescription.ReturnFavor,
		Icon = "ui/perks/return_favor_circle.png",
		IconDisabled = "ui/perks/return_favor_circle_bw.png",
		Const = "ReturnFavor"
	},
		{
		ID = "perk.steadfast",
		Script = "scripts/skills/perks/perk_steadfast",
		Name = this.Const.Strings.PerkName.Steadfast,
		Tooltip = this.Const.Strings.PerkDescription.Steadfast,
		Icon = "ui/perks/steadfast_circle.png",
		IconDisabled = "ui/perks/steadfast_circle_bw.png",
		Const = "Steadfast"
		},
	{
		ID = "perk.sundering_strikes",
		Script = "scripts/skills/perks/perk_sundering_strikes",
		Name = this.Const.Strings.PerkName.SunderingStrikes,
		Tooltip = this.Const.Strings.PerkDescription.SunderingStrikes,
		Icon = "ui/perks/sunderingstrikes_circle.png",
		IconDisabled = "ui/perks/sunderingstrikes_circle_bw.png",
		Const = "SunderingStrikes"
	},
	{
		ID = "perk.stalwart",
		Script = "scripts/skills/perks/perk_stalwart",
		Name = this.Const.Strings.PerkName.Stalwart,
		Tooltip = this.Const.Strings.PerkDescription.Stalwart,
		Icon = "ui/perks/stalwart.png",
		IconDisabled = "ui/perks/stalwart_bw.png",
		Const = "Stalwart"
	},
	{
		ID = "perk.battle_flow",
		Script = "scripts/skills/perks/perk_battle_flow",
		Name = this.Const.Strings.PerkName.BattleFlow,
		Tooltip = this.Const.Strings.PerkDescription.BattleFlow,
		Icon = "ui/perks/battle_flow56_circle.png",
		IconDisabled = "ui/perks/battle_flow56_circle_bw.png",
		Const = "BattleFlow"
	},
	{
		ID = "perk.lookout",
		Script = "scripts/skills/perks/perk_lookout",
		Name = this.Const.Strings.PerkName.Lookout,
		Tooltip = this.Const.Strings.PerkDescription.Lookout,
		Icon = "ui/perks/lookout_circle.png",
		IconDisabled = "ui/perks/lookout_circle_bw.png",
		Const = "Lookout"
	},
	{
		ID = "perk.sprint",
		Script = "scripts/skills/perks/perk_sprint",
		Name = this.Const.Strings.PerkName.Sprint,
		Tooltip = this.Const.Strings.PerkDescription.Sprint,
		Icon = "ui/perks/perk_sprint.png",
		IconDisabled = "ui/perks/perk_sprint_sw.png",
		Const = "Sprint"
	},
	{
		ID = "perk.double_strike",
		Script = "scripts/skills/perks/perk_double_strike",
		Name = this.Const.Strings.PerkName.DoubleStrike,
		Tooltip = this.Const.Strings.PerkDescription.DoubleStrike,
		Icon = "ui/perks/doublestrike_circle.png",
		IconDisabled = "ui/perks/doublestrike_circle_bw.png",
		Const = "DoubleStrike"
	},
	{
		ID = "perk.legend_mastery_poison",
		Script = "scripts/skills/perks/perk_legend_mastery_poison",
		Name = this.Const.Strings.PerkName.LegendSpecPoison,
		Tooltip = this.Const.Strings.PerkDescription.LegendSpecPoison,
		Icon = "ui/perks/mastery_poison.png",
		IconDisabled = "ui/perks/mastery_poison_bw.png",
		Const = "LegendSpecPoison"
	},
	{
		ID = "perk.close_combat_archer",
		Script = "scripts/skills/perks/perk_close_combat_archer",
		Name = this.Const.Strings.PerkName.CloseCombatArcher,
		Tooltip = this.Const.Strings.PerkDescription.CloseCombatArcher,
		Icon = "ui/perks/closecombat56.png",
		IconDisabled = "ui/perks/closecombat56_bw.png",
		Const = "CloseCombatArcher"
	},
	{
		ID = "perk.ballistics",
		Script = "scripts/skills/perks/perk_ballistics",
		Name = this.Const.Strings.PerkName.Ballistics,
		Tooltip = this.Const.Strings.PerkDescription.Ballistics,
		Icon = "ui/perks/ballistics56_circle.png",
		IconDisabled = "ui/perks/ballistics56_circle_bw.png",
		Const = "Ballistics"
	},
	{
		ID = "perk.legend_cascade",
		Script = "scripts/skills/perks/perk_legend_cascade",
		Name = this.Const.Strings.PerkName.LegendCascade,
		Tooltip = this.Const.Strings.PerkDescription.LegendCascade,
		Icon = "ui/perks/triplestrike56.png",
		IconDisabled = "ui/perks/triplestrike56_bw.png",
		Const = "LegendCascade"
	},
	{
		ID = "perk.legend_evasion",
		Script = "scripts/skills/perks/perk_legend_evasion",
		Name = this.Const.Strings.PerkName.LegendEvasion,
		Tooltip = this.Const.Strings.PerkDescription.LegendEvasion,
		Icon = "ui/perks/evasion_circle.png",
		IconDisabled = "ui/perks/evasion_circle_bw.png",
		Const = "LegendEvasion"
	},
	{
		ID = "perk.legend_rust",
		Script = "scripts/skills/perks/perk_legend_rust",
		Name = this.Const.Strings.PerkName.LegendRust,
		Tooltip = this.Const.Strings.PerkDescription.LegendRust,
		Icon = "ui/perks/rust56_circle.png",
		IconDisabled = "ui/perks/rust56_circle_bw.png",
		Const = "LegendRust",
	},
	{
		ID = "perk.legend_deathtouch",
		Script = "scripts/skills/perks/perk_legend_deathtouch",
		Name = this.Const.Strings.PerkName.LegendDeathtouch,
		Tooltip = this.Const.Strings.PerkDescription.LegendDeathtouch,
		Icon = "ui/perks/deathtouch_circle.png",
		IconDisabled = "ui/perks/deathtouch_circle_bw.png",
		Const = "LegendDeathtouch"
	},
	{
		ID = "perk.legend_possess_undead",
		Script = "scripts/skills/perks/perk_legend_possess_undead",
		Name = this.Const.Strings.PerkName.LegendPossessUndead,
		Tooltip = this.Const.Strings.PerkDescription.LegendPossessUndead,
		Icon = "ui/perks/possess56.png",
		IconDisabled = "ui/perks/possess56_bw.png",
		Const = "LegendPossessUndead"
	},
	{
		ID = "perk.legend_miasma",
		Script = "scripts/skills/perks/perk_legend_miasma",
		Name = this.Const.Strings.PerkName.LegendMiasma,
		Tooltip = this.Const.Strings.PerkDescription.LegendMiasma,
		Icon = "ui/perks/miasma_circle.png",
		IconDisabled = "ui/perks/miasma_circle_bw.png",
		Const = "LegendMiasma"
	},
	{
		ID = "perk.legend_hex",
		Script = "scripts/skills/perks/perk_legend_hex",
		Name = this.Const.Strings.PerkName.LegendHex,
		Tooltip = this.Const.Strings.PerkDescription.LegendHex,
		Icon = "ui/perks/hex_circle.png",
		IconDisabled = "ui/perks/hex_circle_bw.png",
		Const = "LegendHex"
	},
	{
		ID = "perk.legend_darkflight",
		Script = "scripts/skills/perks/perk_legend_darkflight",
		Name = this.Const.Strings.PerkName.LegendDarkflight,
		Tooltip = this.Const.Strings.PerkDescription.LegendDarkflight,
		Icon = "ui/perks/darkflight_circle.png",
		IconDisabled = "ui/perks/darkflight_circle_bw.png",
		Const = "LegendDarkflight"
	},
	{
		ID = "perk.inspiring_presence",
		Script = "scripts/skills/perks/perk_inspiring_presence",
		Name = this.Const.Strings.PerkName.InspiringPresence,
		Tooltip = this.Const.Strings.PerkDescription.InspiringPresence,
		Icon = "ui/perks/perk_28.png",
		IconDisabled = "ui/perks/perk_28_sw.png",
		Const = "InspiringPresence"
	},
	{
		ID = "perk.legend_mastery_bandage",
		Script = "scripts/skills/perks/perk_legend_mastery_bandage",
		Name = this.Const.Strings.PerkName.LegendSpecBandage,
		Tooltip = this.Const.Strings.PerkDescription.LegendSpecBandage,
		Icon = "ui/perks/bandage_circle.png",
		IconDisabled = "ui/perks/bandage_circle_bw.png",
		Const = "LegendSpecBandage"
	},
	{
		ID = "perk.legend_hold_the_line",
		Script = "scripts/skills/perks/perk_legend_hold_the_line",
		Name = this.Const.Strings.PerkName.LegendHoldTheLine,
		Tooltip = this.Const.Strings.PerkDescription.LegendHoldTheLine,
		Icon = "ui/perks/holdtheline_circle.png",
		IconDisabled = "ui/perks/holdtheline_circle_bw.png",
		Const = "LegendHoldTheLine"
	},
	{
		ID = "perk.inspire",
		Script = "scripts/skills/perks/perk_inspire",
		Name = this.Const.Strings.PerkName.Inspire,
		Tooltip = this.Const.Strings.PerkDescription.Inspire,
		Icon = "ui/perks/inspire_circle.png",
		IconDisabled = "ui/perks/inspire_circle_bw.png",
		Const = "Inspire"
	},
	{
		ID = "perk.bloody_harvest",
		Script = "scripts/skills/perks/perk_bloody_harvest",
		Name = this.Const.Strings.PerkName.BloodyHarvest,
		Tooltip = this.Const.Strings.PerkDescription.BloodyHarvest,
		Icon = "ui/perks/bloody_harvest.png",
		IconDisabled = "ui/perks/bloody_harvest_bw.png",
		Const = "BloodyHarvest"
	},
	{
		ID = "perk.devastating_strikes",
		Script = "scripts/skills/perks/perk_devastating_strikes",
		Name = this.Const.Strings.PerkName.DevastatingStrikes,
		Tooltip = this.Const.Strings.PerkDescription.DevastatingStrikes,
		Icon = "ui/perks/devastating_strikes.png",
		IconDisabled = "ui/perks/devastating_strikes_bw.png",
		Const = "DevastatingStrikes"
	},
	{
		ID = "perk.debilitate",
		Script = "scripts/skills/perks/perk_debilitate",
		Name = this.Const.Strings.PerkName.Debilitate,
		Tooltip = this.Const.Strings.PerkDescription.Debilitate,
		Icon = "ui/perks/debilitate_circle_56.png",
		IconDisabled = "ui/perks/debilitate_circle_56_bw.png",
		Const = "Debilitate"
	},
	{
		ID = "perk.slaughterer",
		Script = "scripts/skills/perks/perk_slaughterer",
		Name = this.Const.Strings.PerkName.Slaughterer,
		Tooltip = this.Const.Strings.PerkDescription.Slaughterer,
		Icon = "ui/perks/slaughterer_circle.png",
		IconDisabled = "ui/perks/slaughterer_circle_bw.png",
		Const = "Slaughterer"
	},
	{
		ID = "perk.vengeance",
		Script = "scripts/skills/perks/perk_vengeance",
		Name = this.Const.Strings.PerkName.Vengeance,
		Tooltip = this.Const.Strings.PerkDescription.Vengeance,
		Icon = "ui/perks/vengeance_circle.png",
		IconDisabled = "ui/perks/vengeance_circle_bw.png",
		Const = "Vengeance"
	},
	{
		ID = "perk.ironside",
		Script = "scripts/skills/perks/perk_ironside",
		Name = this.Const.Strings.PerkName.Ironside,
		Tooltip = this.Const.Strings.PerkDescription.Ironside,
		Icon = "ui/perks/perk_101.png",
		IconDisabled = "ui/perks/perk_101_sw.png",
		Const = "Ironside"
	},
	{
		ID = "perk.last_stand",
		Script = "scripts/skills/perks/perk_last_stand",
		Name = this.Const.Strings.PerkName.LastStand,
		Tooltip = this.Const.Strings.PerkDescription.LastStand,
		Icon = "ui/perks/laststand_circle.png",
		IconDisabled = "ui/perks/laststand_circle_bw.png",
		Const = "LastStand"
	},
	{
		ID = "perk.legend_raise_undead",
		Script = "scripts/skills/perks/perk_legend_raise_undead",
		Name = this.Const.Strings.PerkName.LegendRaiseUndead,
		Tooltip = this.Const.Strings.PerkDescription.LegendRaiseUndead,
		Icon = "ui/perks/raisedead2_circle.png",
		IconDisabled = "ui/perks/raisedead2_circle_bw.png",
		Const = "LegendRaiseUndead"
	},
	{
		ID = "perk.legend_wither",
		Script = "scripts/skills/perks/perk_legend_wither",
		Name = this.Const.Strings.PerkName.LegendWither,
		Tooltip = this.Const.Strings.PerkDescription.LegendWither,
		Icon = "ui/perks/wither56.png",
		IconDisabled = "ui/perks/wither56_bw.png",
		Const = "LegendWither"
	},
	{
		ID = "perk.rebound",
		Script = "scripts/skills/perks/perk_rebound",
		Name = this.Const.Strings.PerkName.Rebound,
		Tooltip = this.Const.Strings.PerkDescription.Rebound,
		Icon = "ui/perks/rebound_circle.png",
		IconDisabled = "ui/perks/rebound_circle_bw.png",
		Const = "Rebound"
	},
	{
		ID = "perk.legend_coordinated_volleys",
		Script = "scripts/skills/perks/perk_legend_coordinated_volleys",
		Name = this.Const.Strings.PerkName.LegendCoordinatedVolleys,
		Tooltip = this.Const.Strings.PerkDescription.LegendCoordinatedVolleys,
		Icon = "ui/perks/coordinated_volleys_circle.png",
		IconDisabled = "ui/perks/coordinated_volleys_circle_bw.png",
		Const = "LegendCoordinatedVolleys"
	},
	{
		ID = "perk.legend_push_forward",
		Script = "scripts/skills/perks/perk_legend_push_forward",
		Name = this.Const.Strings.PerkName.LegendForwardPush,
		Tooltip = this.Const.Strings.PerkDescription.LegendForwardPush,
		Icon = "ui/perks/spears_circle.png",
		IconDisabled = "ui/perks/spears_circle_bw.png",
		Const = "LegendForwardPush"
	},
	{
		ID = "perk.legend_insects",
		Script = "scripts/skills/perks/perk_legend_insects",
		Name = this.Const.Strings.PerkName.LegendInsects,
		Tooltip = this.Const.Strings.PerkDescription.LegendInsects,
		Icon = "ui/perks/insects_circle.png",
		IconDisabled = "ui/perks/insects_circle_bw.png",
		Const = "LegendInsects"
	},
	{
		ID = "perk.legend_chain_lightning",
		Script = "scripts/skills/perks/perk_legend_chain_lightning",
		Name = this.Const.Strings.PerkName.LegendChainLightning,
		Tooltip = this.Const.Strings.PerkDescription.LegendChainLightning,
		Icon = "ui/perks/lightning_circle.png",
		IconDisabled = "ui/perks/lightning_circle_bw.png",
		Const = "LegendChainLightning"
	},
	{
		ID = "perk.legend_composure",
		Script = "scripts/skills/perks/perk_legend_composure",
		Name = this.Const.Strings.PerkName.LegendComposure,
		Tooltip = this.Const.Strings.PerkDescription.LegendComposure,
		Icon = "ui/perks/composed_circle.png",
		IconDisabled = "ui/perks/composed_circle_bw.png",
		Const = "LegendComposure"
	},
	{
		ID = "perk.legend_nightvision",
		Script = "scripts/skills/perks/perk_legend_nightvision",
		Name = this.Const.Strings.PerkName.LegendNightvision,
		Tooltip = this.Const.Strings.PerkDescription.LegendNightvision,
		Icon = "ui/perks/nightvision_circle.png",
		IconDisabled = "ui/perks/nightvision_circle_bw.png",
		Const = "LegendNightvision"
	},
	{
		ID = "perk.legend_mastery_staves",
		Script = "scripts/skills/perks/perk_legend_mastery_staves",
		Name = this.Const.Strings.PerkName.LegendMasteryStaves,
		Tooltip = this.Const.Strings.PerkDescription.LegendMasteryStaves,
		Icon = "ui/perks/staffmastery.png",
		IconDisabled = "ui/perks/staffmastery_bw.png",
		Const = "LegendMasteryStaves"
	},
	{
		ID = "perk.legend_relax",
		Script = "scripts/skills/perks/perk_legend_relax",
		Name = this.Const.Strings.PerkName.LegendRelax,
		Tooltip = this.Const.Strings.PerkDescription.LegendRelax,
		Icon = "ui/perks/relax_circle.png",
		IconDisabled = "ui/perks/relax_circle_bw.png",
		Const = "LegendRelax"
	},
	{
		ID = "perk.legend_gruesome_feast",
		Script = "scripts/skills/perks/perk_legend_gruesome_feast",
		Name = this.Const.Strings.PerkName.LegendGruesomeFeast,
		Tooltip = this.Const.Strings.PerkDescription.LegendGruesomeFeast,
		Icon = "ui/perks/gruesome_circle.png",
		IconDisabled = "ui/perks/gruesome_circle_bw.png",
		Const = "LegendGruesomeFeast"
	},
	{
		ID = "perk.legend_ubernimble",
		Script = "scripts/skills/perks/perk_legend_ubernimble",
		Name = this.Const.Strings.PerkName.LegendUberNimble,
		Tooltip = this.Const.Strings.PerkDescription.LegendUberNimble,
		Icon = "ui/perks/ubernimble_circle.png",
		IconDisabled = "ui/perks/ubernimble_circle_bw.png",
		Const = "LegendUberNimble"
	},
	{
		ID = "perk.legend_muscularity",
		Script = "scripts/skills/perks/perk_legend_muscularity",
		Name = this.Const.Strings.PerkName.LegendMuscularity,
		Tooltip = this.Const.Strings.PerkDescription.LegendMuscularity,
		Icon = "ui/perks/muscularity_circle.png",
		IconDisabled = "ui/perks/muscularity_circle_bw.png",
		Const = "LegendMuscularity"
	},
	{
		ID = "perk.legend_battleheart",
		Script = "scripts/skills/perks/perk_legend_battleheart",
		Name = this.Const.Strings.PerkName.LegendBattleheart,
		Tooltip = this.Const.Strings.PerkDescription.LegendBattleheart,
		Icon = "ui/perks/battlheart_circle.png",
		IconDisabled = "ui/perks/battlheart_circle_bw.png",
		Const = "LegendBattleheart"
	},
	{
		ID = "perk.legend_true_believer",
		Script = "scripts/skills/perks/perk_legend_true_believer",
		Name = this.Const.Strings.PerkName.LegendTrueBeliever,
		Tooltip = this.Const.Strings.PerkDescription.LegendTrueBeliever,
		Icon = "ui/perks/true_believer_circle.png",
		IconDisabled = "ui/perks/true_believer_circle_bw.png",
		Const = "LegendTrueBeliever"
	},
	{
		ID = "perk.legend_poison_immunity",
		Script = "scripts/skills/perks/perk_legend_poison_immunity",
		Name = this.Const.Strings.PerkName.LegendPoisonImmunity,
		Tooltip = this.Const.Strings.PerkDescription.LegendPoisonImmunity,
		Icon = "ui/perks/poison_immunity.png",
		IconDisabled = "ui/perks/poison_immunity_bw.png",
		Const = "LegendPoisonImmunity"
	},
	{
		ID = "perk.legend_summon_cat",
		Script = "scripts/skills/perks/perk_legend_summon_cat",
		Name = this.Const.Strings.PerkName.LegendSummonCat,
		Tooltip = this.Const.Strings.PerkDescription.LegendSummonCat,
		Icon = "ui/perks/cat_circle.png",
		IconDisabled = "ui/perks/cat_circle_bw.png",
		Const = "LegendSummonCat"
	},
	{
		ID = "perk.legend_spawn_zombie_low",
		Script = "scripts/skills/perks/perk_legend_spawn_zombie_low",
		Name = this.Const.Strings.PerkName.LegendSpawnZombieLow,
		Tooltip = this.Const.Strings.PerkDescription.LegendSpawnZombieLow,
		Icon = "ui/perks/mold_carrion_circle.png",
		IconDisabled = "ui/perks/mold_carrion_circle_bw.png",
		Const = "LegendSpawnZombieLow"
	},
	{
		ID = "perk.legend_spawn_zombie_med",
		Script = "scripts/skills/perks/perk_legend_spawn_zombie_med",
		Name = this.Const.Strings.PerkName.LegendSpawnZombieMed,
		Tooltip = this.Const.Strings.PerkDescription.LegendSpawnZombieMed,
		Icon = "ui/perks/fashion_body_circle.png",
		IconDisabled = "ui/perks/fashion_body_circle_bw.png",
		Const = "LegendSpawnZombieMed"
	},
	{
		ID = "perk.legend_spawn_zombie_high",
		Script = "scripts/skills/perks/perk_legend_spawn_zombie_high",
		Name = this.Const.Strings.PerkName.LegendSpawnZombieHigh,
		Tooltip = this.Const.Strings.PerkDescription.LegendSpawnZombieHigh,
		Icon = "ui/perks/remake_man_circle.png",
		IconDisabled = "ui/perks/remake_man_circle_bw.png",
		Const = "LegendSpawnZombieHigh"
	},
	{
		ID = "perk.legend_spawn_skeleton_low",
		Script = "scripts/skills/perks/perk_legend_spawn_skeleton_low",
		Name = this.Const.Strings.PerkName.LegendSpawnSkeletonLow,
		Tooltip = this.Const.Strings.PerkDescription.LegendSpawnSkeletonLow,
		Icon = "ui/perks/arrange_bones_circle.png",
		IconDisabled = "ui/perks/arrange_bones_circle_bw.png",
		Const = "LegendSpawnSkeletonLow"
	},
	{
		ID = "perk.legend_spawn_skeleton_med",
		Script = "scripts/skills/perks/perk_legend_spawn_skeleton_med",
		Name = this.Const.Strings.PerkName.LegendSpawnSkeletonMed,
		Tooltip = this.Const.Strings.PerkDescription.LegendSpawnSkeletonMed,
		Icon = "ui/perks/align_joints_circle.png",
		IconDisabled = "ui/perks/align_joints_circle_bw.png",
		Const = "LegendSpawnSkeletonMed"
	},
	{
		ID = "perk.legend_spawn_skeleton_high",
		Script = "scripts/skills/perks/perk_legend_spawn_skeleton_high",
		Name = this.Const.Strings.PerkName.LegendSpawnSkeletonHigh,
		Tooltip = this.Const.Strings.PerkDescription.LegendSpawnSkeletonHigh,
		Icon = "ui/perks/rebuild_skeleton_circle.png",
		IconDisabled = "ui/perks/rebuild_skeleton_circle_bw.png",
		Const = "LegendSpawnSkeletonHigh"
	},
	{
		ID = "perk.legend_extended_aura",
		Script = "scripts/skills/perks/perk_legend_extended_aura",
		Name = this.Const.Strings.PerkName.LegendExtendendAura,
		Tooltip = this.Const.Strings.PerkDescription.LegendExtendendAura,
		Icon = "ui/perks/extended_aura_circle.png",
		IconDisabled = "ui/perks/extended_aura_circle_bw.png",
		Const = "LegendExtendendAura"
	},
	{
		ID = "perk.legend_channeled_power",
		Script = "scripts/skills/perks/perk_legend_channeled_power",
		Name = this.Const.Strings.PerkName.LegendChanneledPower,
		Tooltip = this.Const.Strings.PerkDescription.LegendChanneledPower,
		Icon = "ui/perks/channeled_power_circle.png",
		IconDisabled = "ui/perks/channeled_power_circle_bw.png",
		Const = "LegendChanneledPower"
	},
	{
		ID = "perk.legend_reclamation",
		Script = "scripts/skills/perks/perk_legend_reclamation",
		Name = this.Const.Strings.PerkName.LegendReclamation,
		Tooltip = this.Const.Strings.PerkDescription.LegendReclamation,
		Icon = "ui/perks/reclamation_circle.png",
		IconDisabled = "ui/perks/reclamation_circle_bw.png",
		Const = "LegendReclamation"
	},
	{
		ID = "perk.legend_conservation",
		Script = "scripts/skills/perks/perk_legend_conservation",
		Name = this.Const.Strings.PerkName.LegendConservation,
		Tooltip = this.Const.Strings.PerkDescription.LegendConservation,
		Icon = "ui/perks/conservation_circle.png",
		IconDisabled = "ui/perks/conservation_circle_bw.png",
		Const = "LegendConservation"
	},
	{
		ID = "perk.legend_enthrall",
		Script = "scripts/skills/perks/perk_legend_enthrall",
		Name = this.Const.Strings.PerkName.LegendEnthrall,
		Tooltip = this.Const.Strings.PerkDescription.LegendEnthrall,
		Icon = "ui/perks/enthrall_circle.png",
		IconDisabled = "ui/perks/enthrall_circle_bw.png",
		Const = "LegendEnthrall"
	},
	{
		ID = "perk.legend_violent_decomposition",
		Script = "scripts/skills/perks/perk_legend_violent_decomposition",
		Name = this.Const.Strings.PerkName.LegendViolentDecomposition,
		Tooltip = this.Const.Strings.PerkDescription.LegendViolentDecomposition,
		Icon = "ui/perks/violent_decomposition_circle.png",
		IconDisabled = "ui/perks/violent_decomposition_circle_bw.png",
		Const = "LegendViolentDecomposition"
	},
	{
		ID = "perk.legend_possession",
		Script = "scripts/skills/perks/perk_legend_possession",
		Name = this.Const.Strings.PerkName.LegendPossession,
		Tooltip = this.Const.Strings.PerkDescription.LegendPossession,
		Icon = "ui/perks/possession_circle_56.png",
		IconDisabled = "ui/perks/possession_circle_56_bw.png",
		Const = "LegendPossession"
	},
	{
		ID = "perk.legend_siphon",
		Script = "scripts/skills/perks/perk_legend_siphon",
		Name = this.Const.Strings.PerkName.LegendSiphon,
		Tooltip = this.Const.Strings.PerkDescription.LegendSiphon,
		Icon = "ui/perks/siphon_circle.png",
		IconDisabled = "ui/perks/siphon_circle_bw.png",
		Const = "LegendSiphon"
	},
	{
		ID = "perk.legend_vala_inscribe_weapon",
		Script = "scripts/skills/perks/legend_vala_inscribe_weapon",
		Name = this.Const.Strings.PerkName.LegendValaInscribeWeapon,
		Tooltip = this.Const.Strings.PerkDescription.LegendValaInscribeWeapon,
		Icon = "ui/perks/legend_vala_inscribe_weapon.png",
		IconDisabled = "ui/perks/legend_vala_inscribe_weapon_sw.png",
		Const = "LegendValaInscribeWeapon"
	},
	{
		ID = "perk.legend_vala_inscribe_helmet",
		Script = "scripts/skills/perks/legend_vala_inscribe_helmet",
		Name = this.Const.Strings.PerkName.LegendValaInscribeHelmet,
		Tooltip = this.Const.Strings.PerkDescription.LegendValaInscribeHelmet,
		Icon = "ui/perks/legend_vala_inscribe_helmet.png",
		IconDisabled = "ui/perks/legend_vala_inscribe_helmet_sw.png",
		Const = "LegendValaInscribeHelmet"
	},
	{
		ID = "perk.legend_vala_inscribe_armor",
		Script = "scripts/skills/perks/legend_vala_inscribe_armor",
		Name = this.Const.Strings.PerkName.LegendValaInscribeArmor,
		Tooltip = this.Const.Strings.PerkDescription.LegendValaInscribeArmor,
		Icon = "ui/perks/legend_vala_inscribe_armor.png",
		IconDisabled = "ui/perks/legend_vala_inscribe_armor_sw.png",
		Const = "LegendValaInscribeArmor"
	},
	{
		ID = "perk.legend_vala_inscribe_shield",
		Script = "scripts/skills/perks/legend_vala_inscribe_shield",
		Name = this.Const.Strings.PerkName.LegendValaInscribeShield,
		Tooltip = this.Const.Strings.PerkDescription.LegendValaInscribeShield,
		Icon = "ui/perks/legend_vala_inscribe_shield.png",
		IconDisabled = "ui/perks/legend_vala_inscribe_shield_sw.png",
		Const = "LegendValaInscribeShield"
	},
	{
		ID = "perk.legend_guide_steps",
		Script = "scripts/skills/perks/perk_legend_guide_steps",
		Name = this.Const.Strings.PerkName.LegendGuideSteps,
		Tooltip = this.Const.Strings.PerkDescription.LegendGuideSteps,
		Icon = "ui/perks/guided_steps_circle.png",
		IconDisabled = "ui/perks/guided_steps_circle_bw.png",
		Const = "LegendGuideSteps"
	},
	{
		ID = "perk.legend_berserker_rage",
		Script = "scripts/skills/perks/perk_legend_berserker_rage",
		Name = this.Const.Strings.PerkName.LegendBerserkerRage,
		Tooltip = this.Const.Strings.PerkDescription.LegendBerserkerRage,
		Icon = "ui/perks/berserker_rage_circle.png",
		IconDisabled = "ui/perks/berserker_rage_circle_bw.png",
		Const = "LegendBerserkerRage"
	},
	{
		ID = "perk.legend_become_berserker",
		Script = "scripts/skills/perks/perk_legend_become_berserker",
		Name = this.Const.Strings.PerkName.LegendBecomeBerserker,
		Tooltip = this.Const.Strings.PerkDescription.LegendBecomeBerserker,
		Icon = "ui/perks/berserker_rage_circle.png",
		IconDisabled = "ui/perks/berserker_rage_circle_bw.png",
		Const = "LegendBecomeBerserker"
	},
	{
		ID = "perk.legend_skillful_stacking",
		Script = "scripts/skills/perks/perk_legend_skillful_stacking",
		Name = this.Const.Strings.PerkName.LegendSkillfulStacking,
		Tooltip = this.Const.Strings.PerkDescription.LegendSkillfulStacking,
		Icon = "ui/perks/MaxStashT2.png",
		IconDisabled = "ui/perks/MaxStashT2_bw.png",
		Const = "LegendSkillfulStacking"
	},
	{
		ID = "perk.legend_efficient_packing",
		Script = "scripts/skills/perks/perk_legend_efficient_packing",
		Name = this.Const.Strings.PerkName.LegendEfficientPacking,
		Tooltip = this.Const.Strings.PerkDescription.LegendEfficientPacking,
		Icon = "ui/perks/MaxStashT1.png",
		IconDisabled = "ui/perks/MaxStashT1_bw.png",
		Const = "LegendEfficientPacking"
	},
	{
		ID = "perk.legend_ammo_binding",
		Script = "scripts/skills/perks/perk_legend_ammo_binding",
		Name = this.Const.Strings.PerkName.LegendAmmoBinding,
		Tooltip = this.Const.Strings.PerkDescription.LegendAmmoBinding,
		Icon = "ui/perks/MaxAmmoT1.png",
		IconDisabled = "ui/perks/MaxAmmoT1_bw.png",
		Const = "LegendAmmoBinding"
	},
	{
		ID = "perk.legend_ammo_bundles",
		Script = "scripts/skills/perks/perk_legend_ammo_bundles",
		Name = this.Const.Strings.PerkName.LegendAmmoBundles,
		Tooltip = this.Const.Strings.PerkDescription.LegendAmmoBundles,
		Icon = "ui/perks/MaxAmmoT2.png",
		IconDisabled = "ui/perks/MaxAmmoT2_bw.png",
		Const = "LegendAmmoBundles"
	},
	{
		ID = "perk.legend_med_packages",
		Script = "scripts/skills/perks/perk_legend_med_packages",
		Name = this.Const.Strings.PerkName.LegendMedPackages,
		Tooltip = this.Const.Strings.PerkDescription.LegendMedPackages,
		Icon = "ui/perks/MaxMedsT1.png",
		IconDisabled = "ui/perks/MaxMedsT1_bw.png",
		Const = "LegendMedPackages"
	},
	{
		ID = "perk.legend_med_ingredients",
		Script = "scripts/skills/perks/perk_legend_med_ingredients",
		Name = this.Const.Strings.PerkName.LegendMedIngredients,
		Tooltip = this.Const.Strings.PerkDescription.LegendMedIngredients,
		Icon = "ui/perks/MaxMedsT2.png",
		IconDisabled = "ui/perks/MaxMedsT2_bw.png",
		Const = "LegendMedIngredients"
	},
	{
		ID = "perk.legend_tools_drawers",
		Script = "scripts/skills/perks/perk_legend_tools_drawers",
		Name = this.Const.Strings.PerkName.LegendToolsDrawers,
		Tooltip = this.Const.Strings.PerkDescription.LegendToolsDrawers,
		Icon = "ui/perks/MaxToolsT1.png",
		IconDisabled = "ui/perks/MaxToolsT1_bw.png",
		Const = "LegendToolsDrawers"
	},
	{
		ID = "perk.legend_tools_spares",
		Script = "scripts/skills/perks/perk_legend_tools_spares",
		Name = this.Const.Strings.PerkName.LegendToolsSpares,
		Tooltip = this.Const.Strings.PerkDescription.LegendToolsSpares,
		Icon = "ui/perks/MaxToolsT2.png",
		IconDisabled = "ui/perks/MaxToolsT2_bw.png",
		Const = "LegendToolsSpares"
	},
	{
		ID = "perk.legend_barter_convincing",
		Script = "scripts/skills/perks/perk_legend_barter_convincing",
		Name = this.Const.Strings.PerkName.LegendBarterConvincing,
		Tooltip = this.Const.Strings.PerkDescription.LegendBarterConvincing,
		Icon = "ui/perks/BarterT1.png",
		IconDisabled = "ui/perks/BarterT1_bw.png",
		Const = "LegendBarterConvincing"
	},
	{
		ID = "perk.legend_barter_trustworthy",
		Script = "scripts/skills/perks/perk_legend_barter_trustworthy",
		Name = this.Const.Strings.PerkName.LegendBarterTrustworthy,
		Tooltip = this.Const.Strings.PerkDescription.LegendBarterTrustworthy,
		Icon = "ui/perks/BarterT2.png",
		IconDisabled = "ui/perks/BarterT2_bw.png",
		Const = "LegendBarterTrustworthy"
	},
	{
		ID = "perk.legend_bribe",
		Script = "scripts/skills/perks/perk_legend_bribe",
		Name = this.Const.Strings.PerkName.LegendBribe,
		Tooltip = this.Const.Strings.PerkDescription.LegendBribe,
		Icon = "ui/perks/coins_circle.png",
		IconDisabled = "ui/perks/coins_circle_bw.png",
		Const = "LegendBribe"
	},
	{
		ID = "perk.legend_specialist_butcher_damage",
		Script = "scripts/skills/perks/perk_legend_specialist_butcher_damage",
		Name = this.Const.Strings.PerkName.LegendSpecialistButcherDamage,
		Tooltip = this.Const.Strings.PerkDescription.LegendSpecialistButcherDamage,
		Icon = "ui/perks/cleaver_01.png",
		IconDisabled = "ui/perks/cleaver_bw.png",
		Const = "LegendSpecialistButcherDamage"
	},
	{
		ID = "perk.legend_specialist_butcher_skill",
		Script = "scripts/skills/perks/perk_legend_specialist_butcher_skill",
		Name = this.Const.Strings.PerkName.LegendSpecialistButcherSkill,
		Tooltip = this.Const.Strings.PerkDescription.LegendSpecialistButcherSkill,
		Icon = "ui/perks/cleaver_02.png",
		IconDisabled = "ui/perks/cleaver_bw.png",
		Const = "LegendSpecialistButcherSkill"
	},
	{
		ID = "perk.legend_specialist_hammer_damage",
		Script = "scripts/skills/perks/perk_legend_specialist_hammer_damage",
		Name = this.Const.Strings.PerkName.LegendSpecialistHammerDamage,
		Tooltip = this.Const.Strings.PerkDescription.LegendSpecialistHammerDamage,
		Icon = "ui/perks/hammer_01.png",
		IconDisabled = "ui/perks/hammer_bw.png",
		Const = "LegendSpecialistHammerDamage"
	},
	{
		ID = "perk.legend_specialist_hammer_skill",
		Script = "scripts/skills/perks/perk_legend_specialist_hammer_skill",
		Name = this.Const.Strings.PerkName.LegendSpecialistHammerSkill,
		Tooltip = this.Const.Strings.PerkDescription.LegendSpecialistHammerSkill,
		Icon = "ui/perks/hammer_02.png",
		IconDisabled = "ui/perks/hammer_bw.png",
		Const = "LegendSpecialistHammerSkill"
	},
	{
		ID = "perk.legend_specialist_knife_damage",
		Script = "scripts/skills/perks/perk_legend_specialist_knife_damage",
		Name = this.Const.Strings.PerkName.LegendSpecialistKnifeDamage,
		Tooltip = this.Const.Strings.PerkDescription.LegendSpecialistKnifeDamage,
		Icon = "ui/perks/knife_01.png",
		IconDisabled = "ui/perks/knife_bw.png",
		Const = "LegendSpecialistKnifeDamage"
	},
	{
		ID = "perk.legend_specialist_knife_skill",
		Script = "scripts/skills/perks/perk_legend_specialist_knife_skill",
		Name = this.Const.Strings.PerkName.LegendSpecialistKnifeSkill,
		Tooltip = this.Const.Strings.PerkDescription.LegendSpecialistKnifeSkill,
		Icon = "ui/perks/knife_02.png",
		IconDisabled = "ui/perks/knife_bw.png",
		Const = "LegendSpecialistKnifeSkill"
	},
	{
		ID = "perk.legend_specialist_lute_damage",
		Script = "scripts/skills/perks/perk_legend_specialist_lute_damage",
		Name = this.Const.Strings.PerkName.LegendSpecialistLuteDamage,
		Tooltip = this.Const.Strings.PerkDescription.LegendSpecialistLuteDamage,
		Icon = "ui/perks/lute_01.png",
		IconDisabled = "ui/perks/lute_bw.png",
		Const = "LegendSpecialistLuteDamage"
	},
	{
		ID = "perk.legend_specialist_lute_skill",
		Script = "scripts/skills/perks/perk_legend_specialist_lute_skill",
		Name = this.Const.Strings.PerkName.LegendSpecialistLuteSkill,
		Tooltip = this.Const.Strings.PerkDescription.LegendSpecialistLuteSkill,
		Icon = "ui/perks/lute_02.png",
		IconDisabled = "ui/perks/lute_bw.png",
		Const = "LegendSpecialistLuteSkill"
	},
	{
		ID = "perk.legend_specialist_militia_damage",
		Script = "scripts/skills/perks/perk_legend_specialist_militia_damage",
		Name = this.Const.Strings.PerkName.LegendSpecialistMilitiaDamage,
		Tooltip = this.Const.Strings.PerkDescription.LegendSpecialistMilitiaDamage,
		Icon = "ui/perks/spear_01.png",
		IconDisabled = "ui/perks/spear_bw.png",
		Const = "LegendSpecialistMilitiaDamage"
	},
	{
		ID = "perk.legend_specialist_militia_skill",
		Script = "scripts/skills/perks/perk_legend_specialist_militia_skill",
		Name = this.Const.Strings.PerkName.LegendSpecialistMilitiaSkill,
		Tooltip = this.Const.Strings.PerkDescription.LegendSpecialistMilitiaSkill,
		Icon = "ui/perks/spear_02.png",
		IconDisabled = "ui/perks/spear_bw.png",
		Const = "LegendSpecialistMilitiaSkill"
	},
	{
		ID = "perk.legend_specialist_pickaxe_damage",
		Script = "scripts/skills/perks/perk_legend_specialist_pickaxe_damage",
		Name = this.Const.Strings.PerkName.LegendSpecialistPickaxeDamage,
		Tooltip = this.Const.Strings.PerkDescription.LegendSpecialistPickaxeDamage,
		Icon = "ui/perks/pickaxe_01.png",
		IconDisabled = "ui/perks/pickaxe_bw.png",
		Const = "LegendSpecialistPickaxeDamage"
	},
	{
		ID = "perk.legend_specialist_pickaxe_skill",
		Script = "scripts/skills/perks/perk_legend_specialist_pickaxe_skill",
		Name = this.Const.Strings.PerkName.LegendSpecialistPickaxeSkill,
		Tooltip = this.Const.Strings.PerkDescription.LegendSpecialistPickaxeSkill,
		Icon = "ui/perks/pickaxe_02.png",
		IconDisabled = "ui/perks/pickaxe_bw.png",
		Const = "LegendSpecialistPickaxeSkill"
	},
	{
		ID = "perk.legend_specialist_pitchfork_damage",
		Script = "scripts/skills/perks/perk_legend_specialist_pitchfork_damage",
		Name = this.Const.Strings.PerkName.LegendSpecialistPitchforkDamage,
		Tooltip = this.Const.Strings.PerkDescription.LegendSpecialistPitchforkDamage,
		Icon = "ui/perks/pitchfork_01.png",
		IconDisabled = "ui/perks/pitchfork_bw.png",
		Const = "LegendSpecialistPitchforkDamage"
	},
	{
		ID = "perk.legend_specialist_pitchfork_skill",
		Script = "scripts/skills/perks/perk_legend_specialist_pitchfork_skill",
		Name = this.Const.Strings.PerkName.LegendSpecialistPitchforkSkill,
		Tooltip = this.Const.Strings.PerkDescription.LegendSpecialistPitchforkSkill,
		Icon = "ui/perks/pitchfork_02.png",
		IconDisabled = "ui/perks/pitchfork_bw.png",
		Const = "LegendSpecialistPitchforkSkill"
	},
	{
		ID = "perk.legend_specialist_shortbow_damage",
		Script = "scripts/skills/perks/perk_legend_specialist_shortbow_damage",
		Name = this.Const.Strings.PerkName.LegendSpecialistShortbowDamage,
		Tooltip = this.Const.Strings.PerkDescription.LegendSpecialistShortbowDamage,
		Icon = "ui/perks/shortbow_01.png",
		IconDisabled = "ui/perks/shortbow_bw.png",
		Const = "LegendSpecialistShortbowDamage"
	},
	{
		ID = "perk.legend_specialist_shortbow_skill",
		Script = "scripts/skills/perks/perk_legend_specialist_shortbow_skill",
		Name = this.Const.Strings.PerkName.LegendSpecialistShortbowSkill,
		Tooltip = this.Const.Strings.PerkDescription.LegendSpecialistShortbowSkill,
		Icon = "ui/perks/shortbow_02.png",
		IconDisabled = "ui/perks/shortbow_bw.png",
		Const = "LegendSpecialistShortbowSkill"
	},
	{
		ID = "perk.legend_specialist_shovel_damage",
		Script = "scripts/skills/perks/perk_legend_specialist_shovel_damage",
		Name = this.Const.Strings.PerkName.LegendSpecialistShovelDamage,
		Tooltip = this.Const.Strings.PerkDescription.LegendSpecialistShovelDamage,
		Icon = "ui/perks/shovel_01.png",
		IconDisabled = "ui/perks/shovel_bw.png",
		Const = "LegendSpecialistShovelDamage"
	},
	{
		ID = "perk.legend_specialist_shovel_skill",
		Script = "scripts/skills/perks/perk_legend_specialist_shovel_skill",
		Name = this.Const.Strings.PerkName.LegendSpecialistShovelSkill,
		Tooltip = this.Const.Strings.PerkDescription.LegendSpecialistShovelSkill,
		Icon = "ui/perks/shovel_02.png",
		IconDisabled = "ui/perks/shovel_bw.png",
		Const = "LegendSpecialistShovelSkill"
	},
	{
		ID = "perk.legend_specialist_woodaxe_damage",
		Script = "scripts/skills/perks/perk_legend_specialist_woodaxe_damage",
		Name = this.Const.Strings.PerkName.LegendSpecialistWoodaxeDamage,
		Tooltip = this.Const.Strings.PerkDescription.LegendSpecialistWoodaxeDamage,
		Icon = "ui/perks/woodaxe_01.png",
		IconDisabled = "ui/perks/woodaxe_bw.png",
		Const = "LegendSpecialistWoodaxeDamage"
	},
	{
		ID = "perk.legend_specialist_woodaxe_skill",
		Script = "scripts/skills/perks/perk_legend_specialist_woodaxe_skill",
		Name = this.Const.Strings.PerkName.LegendSpecialistWoodaxeSkill,
		Tooltip = this.Const.Strings.PerkDescription.LegendSpecialistWoodaxeSkill,
		Icon = "ui/perks/woodaxe_02.png",
		IconDisabled = "ui/perks/woodaxe_bw.png",
		Const = "LegendSpecialistWoodaxeSkill"
	},
	{
		ID = "perk.legend_specialist_sickle_damage",
		Script = "scripts/skills/perks/perk_legend_specialist_sickle_damage",
		Name = this.Const.Strings.PerkName.LegendSpecialistSickleDamage,
		Tooltip = this.Const.Strings.PerkDescription.LegendSpecialistSickleDamage,
		Icon = "ui/perks/sickle_01.png",
		IconDisabled = "ui/perks/sickle_bw.png",
		Const = "LegendSpecialistSickleDamage"
	},
	{
		ID = "perk.legend_specialist_sickle_skill",
		Script = "scripts/skills/perks/perk_legend_specialist_sickle_skill",
		Name = this.Const.Strings.PerkName.LegendSpecialistSickleSkill,
		Tooltip = this.Const.Strings.PerkDescription.LegendSpecialistSickleSkill,
		Icon = "ui/perks/sickle_02.png",
		IconDisabled = "ui/perks/sickle_bw.png",
		Const = "LegendSpecialistSickleSkill"
	},
	{
		ID = "perk.legend_specialist_sling_damage",
		Script = "scripts/skills/perks/perk_legend_specialist_sling_damage",
		Name = this.Const.Strings.PerkName.LegendSpecialistSlingDamage,
		Tooltip = this.Const.Strings.PerkDescription.LegendSpecialistSlingDamage,
		Icon = "ui/perks/sling_01.png",
		IconDisabled = "ui/perks/sling_bw.png",
		Const = "LegendSpecialistSlingDamage"
	},
	{
		ID = "perk.legend_specialist_sling_skill",
		Script = "scripts/skills/perks/perk_legend_specialist_sling_skill",
		Name = this.Const.Strings.PerkName.LegendSpecialistSlingSkill,
		Tooltip = this.Const.Strings.PerkDescription.LegendSpecialistSlingSkill,
		Icon = "ui/perks/sling_02.png",
		IconDisabled = "ui/perks/sling_bw.png",
		Const = "LegendSpecialistSlingSkill"
	},
	{
		ID = "perk.legend_big_game_hunter",
		Script = "scripts/skills/perks/perk_legend_big_game_hunter",
		Name = this.Const.Strings.PerkName.LegendBigGameHunter,
		Tooltip = this.Const.Strings.PerkDescription.LegendBigGameHunter,
		Icon = "ui/perks/BigGameHunterPerk.png",
		IconDisabled = "ui/perks/BigGameHunterPerk_bw.png",
		Const = "LegendBigGameHunter"
	},
	{
		ID = "perk.legend_second_wind",
		Script = "scripts/skills/perks/perk_legend_second_wind",
		Name = this.Const.Strings.PerkName.LegendSecondWind,
		Tooltip = this.Const.Strings.PerkDescription.LegendSecondWind,
		Icon = "ui/perks/SecondWindPerk.png",
		IconDisabled = "ui/perks/SecondWindPerk_bw.png",
		Const = "LegendSecondWind"
	},
	{
		ID = "perk.legend_mark_target",
		Script = "scripts/skills/perks/perk_legend_mark_target",
		Name = this.Const.Strings.PerkName.LegendMarkTarget,
		Tooltip = this.Const.Strings.PerkDescription.LegendMarkTarget,
		Icon = "ui/perks/MarkTargetPerk.png",
		IconDisabled = "ui/perks/MarkTargetPerk_bw.png",
		Const = "LegendMarkTarget"
	},
	{
		ID = "perk.legend_field_triage",
		Script = "scripts/skills/perks/perk_legend_field_triage",
		Name = this.Const.Strings.PerkName.LegendFieldTriage,
		Tooltip = this.Const.Strings.PerkDescription.LegendFieldTriage,
		Icon = "ui/perks/MaxMedsT2.png",
		IconDisabled = "ui/perks/MaxMedsT2_bw.png",
		Const = "LegendFieldTriage"
	},
	{
		ID = "perk.legend_field_repairs",
		Script = "scripts/skills/perks/perk_legend_field_repairs",
		Name = this.Const.Strings.PerkName.LegendFieldRepairs,
		Tooltip = this.Const.Strings.PerkDescription.LegendFieldRepairs,
		Icon = "ui/perks/MaxToolsT2.png",
		IconDisabled = "ui/perks/MaxToolsT2_bw.png",
		Const = "LegendFieldRepairs"
	},
	{
		ID = "perk.legend_danger_pay",
		Script = "scripts/skills/perks/perk_legend_danger_pay",
		Name = this.Const.Strings.PerkName.LegendDangerPay,
		Tooltip = this.Const.Strings.PerkDescription.LegendDangerPay,
		Icon = "ui/perks/coins_circle.png",
		IconDisabled = "ui/perks/coins_circle_bw.png",
		Const = "LegendDangerPay"
	},															
	{
		ID = "perk.legend_vala_inscription_mastery",
		Script = "scripts/skills/perks/legend_vala_inscription_mastery",
		Name = this.Const.Strings.PerkName.LegendValaInscriptionMastery,
		Tooltip = this.Const.Strings.PerkDescription.LegendValaInscriptionMastery,
		Icon = "ui/perks/legend_vala_inscription_mastery.png",
		IconDisabled = "ui/perks/legend_vala_inscription_mastery_sw.png",
		Const = "LegendValaInscriptionMastery"
	},	
	{
		ID = "perk.legend_vala_warden",
		Script = "scripts/skills/perks/legend_vala_warden",
		Name = this.Const.Strings.PerkName.LegendValaWarden,
		Tooltip = this.Const.Strings.PerkDescription.LegendValaWarden,
		Icon = "ui/perks/legend_vala_warden.png",
		IconDisabled = "ui/perks/legend_vala_warden_sw.png",
		Const = "LegendValaWarden"
	},
	{
		ID = "perk.legend_vala_threads",
		Script = "scripts/skills/perks/legend_vala_threads",
		Name = this.Const.Strings.PerkName.LegendValaThreads,
		Tooltip = this.Const.Strings.PerkDescription.LegendValaThreads,
		Icon = "ui/perks/legend_vala_threads.png",
		IconDisabled = "ui/perks/legend_vala_threads_sw.png",
		Const = "LegendValaThreads"
	},
	{
		ID = "perk.legend_vala_premonition",
		Script = "scripts/skills/perks/legend_vala_premonition",
		Name = this.Const.Strings.PerkName.LegendValaPremonition,
		Tooltip = this.Const.Strings.PerkDescription.LegendValaPremonition,
		Icon = "ui/perks/legend_vala_premonition.png",
		IconDisabled = "ui/perks/legend_vala_premonition_sw.png",
		Const = "LegendValaPremonition"
	},
	{
		ID = "perk.legend_vala_chanting_mastery",
		Script = "scripts/skills/perks/legend_vala_chanting_mastery",
		Name = this.Const.Strings.PerkName.LegendValaChantMastery,
		Tooltip = this.Const.Strings.PerkDescription.LegendValaChantMastery,
		Icon = "ui/perks/legend_vala_chanting_mastery.png",
		IconDisabled = "ui/perks/legend_vala_chanting_mastery_sw.png",
		Const = "LegendValaChantMastery"
	},
	{
		ID = "perk.legend_vala_trance_mastery",
		Script = "scripts/skills/perks/legend_vala_trance_mastery",
		Name = this.Const.Strings.PerkName.LegendValaTranceMastery,
		Tooltip = this.Const.Strings.PerkDescription.LegendValaTranceMastery,
		Icon = "ui/perks/legend_vala_trance_mastery.png",
		IconDisabled = "ui/perks/legend_vala_trance_mastery_sw.png",
		Const = "LegendValaTranceMastery"
	},
	{
		ID = "perk.legend_vala_chant_disharmony",
		Script = "scripts/skills/perks/legend_vala_chant_disharmony",
		Name = this.Const.Strings.PerkName.LegendValaChantDisharmony,
		Tooltip = this.Const.Strings.PerkDescription.LegendValaChantDisharmony,
		Icon = "ui/perks/legend_vala_chant_disharmony.png",
		IconDisabled = "ui/perks/legend_vala_chant_disharmony_sw.png",
		Const = "LegendValaChantDisharmony"
	},
	{
		ID = "perk.legend_vala_spiritual_bond",
		Script = "scripts/skills/perks/legend_vala_spiritual_bond",
		Name = this.Const.Strings.PerkName.LegendValaSpiritualBond,
		Tooltip = this.Const.Strings.PerkDescription.LegendValaSpiritualBond,
		Icon = "ui/perks/legend_vala_spiritual_bond.png",
		IconDisabled = "ui/perks/legend_vala_spiritual_bond_sw.png",
		Const = "LegendValaSpiritualBond"
	},
	{
		ID = "perk.legend_vala_trance_perspective",
		Script = "scripts/skills/perks/legend_vala_trance_perspective",
		Name = this.Const.Strings.PerkName.LegendValaTrancePerspective,
		Tooltip = this.Const.Strings.PerkDescription.LegendValaTrancePerspective,
		Icon = "ui/perks/legend_vala_trance_perspective.png",
		IconDisabled = "ui/perks/legend_vala_trance_perspective_sw.png",
		Const = "LegendValaTrancePerspective"
	},
	{
		ID = "perk.legend_vala_trance_malevolent",
		Script = "scripts/skills/perks/legend_vala_trance_malevolent",
		Name = this.Const.Strings.PerkName.LegendValaTranceMalevolent,
		Tooltip = this.Const.Strings.PerkDescription.LegendValaTranceMalevolent,
		Icon = "ui/perks/legend_vala_trance_malevolent.png",
		IconDisabled = "ui/perks/legend_vala_trance_malevolent_sw.png",
		Const = "LegendValaTranceMalevolent"
	},
	{
		ID = "perk.legend_prepared_for_anything",
		Script = "scripts/skills/perks/perk_legend_prepared_for_anything",
		Name = this.Const.Strings.PerkName.LegendPreparedForAnything,
		Tooltip = this.Const.Strings.PerkDescription.LegendPreparedForAnything,
		Icon = "ui/perks/perk_20.png",
		IconDisabled = "ui/perks/perk_20_sw.png",
		Const = "LegendPreparedForAnything"
	},
	{
		ID = "perk.legend_brink_of_death",
		Script = "scripts/skills/perks/perk_legend_brink_of_death",
		Name = this.Const.Strings.PerkName.LegendBrinkOfDeath,
		Tooltip = this.Const.Strings.PerkDescription.LegendBrinkOfDeath,
		Icon = "ui/perks/perk_04.png",
		IconDisabled = "ui/perks/perk_04_sw.png",
		Const = "LegendBrinkOfDeath"
	},
	{
		ID = "perk.legend_strict_sermons",
		Script = "scripts/skills/perks/perk_legend_strict_sermons",
		Name = this.Const.Strings.PerkName.LegendStrictSermons,
		Tooltip = this.Const.Strings.PerkDescription.LegendStrictSermons,
		Icon = "ui/perks/perk_08.png",
		IconDisabled = "ui/perks/perk_08_sw.png",
		Const = "LegendStrictSermons"
	},
	{
		ID = "perk.legend_infectious_rage",
		Script = "scripts/skills/perks/perk_legend_infectious_rage",
		Name = this.Const.Strings.PerkName.LegendInfectiousRage,
		Tooltip = this.Const.Strings.PerkDescription.LegendInfectiousRage,
		Icon = "ui/perks/perk_35.png",
		IconDisabled = "ui/perks/perk_35_sw.png",
		Const = "LegendInfectiousRage"
	},
	{
		ID = "perk.legend_teacher",
		Script = "scripts/skills/perks/perk_legend_teacher",
		Name = this.Const.Strings.PerkName.LegendTeacher,
		Tooltip = this.Const.Strings.PerkDescription.LegendTeacher,
		Icon = "ui/perks/perk_21.png",
		IconDisabled = "ui/perks/perk_21_sw.png",
		Const = "LegendTeacher"
	},
	{
		ID = "perk.legend_resurrectionist",
		Script = "scripts/skills/perks/perk_legend_resurrectionist",
		Name = this.Const.Strings.PerkName.LegendResurrectionist,
		Tooltip = this.Const.Strings.PerkDescription.LegendResurrectionist,
		Icon = "ui/perks/reclamation_circle.png",
		IconDisabled = "ui/perks/reclamation_circle_bw.png",
		Const = "LegendResurrectionist"
	},
	{
		ID = "perk.legend_scry",
		Script = "scripts/skills/perks/perk_legend_scry",
		Name = this.Const.Strings.PerkName.LegendScry,
		Tooltip = this.Const.Strings.PerkDescription.LegendScry,
		Icon = "ui/perks/scry_perk.png",
		IconDisabled = "ui/perks/scry_perk_bw.png",
		Const = "LegendScry"
	},
	{
		ID = "perk.legend_piercing_shot",
		Script = "scripts/skills/perks/perk_legend_piercing_shot",
		Name = this.Const.Strings.PerkName.LegendPiercingShot,
		Tooltip = this.Const.Strings.PerkDescription.LegendPiercingShot,
		Icon = "ui/perks/PiercingBoltPerk.png",
		IconDisabled = "ui/perks/PiercingBoltPerk_bw.png",
		Const = "LegendPiercingShot"
	},
	{
		ID = "perk.legend_levitation",
		Script = "scripts/skills/perks/perk_legend_levitation",
		Name = this.Const.Strings.PerkName.LegendLevitate,
		Tooltip = this.Const.Strings.PerkDescription.LegendLevitate,
		Icon = "ui/perks/levitate.png",
		IconDisabled = "ui/perks/levitate_bw.png",
		Const = "LegendLevitate"
	},
	{
		ID = "perk.legend_teleport",
		Script = "scripts/skills/perks/perk_legend_teleport",
		Name = this.Const.Strings.PerkName.LegendTeleport,
		Tooltip = this.Const.Strings.PerkDescription.LegendTeleport,
		Icon = "ui/perks/teleport_perk.png",
		IconDisabled = "ui/perks/teleport_perk_bw.png",
		Const = "LegendTeleport"
	},
	{
		ID = "perk.legend_specialist_shield_skill",
		Script = "scripts/skills/perks/perk_legend_specialist_shield_skill",
		Name = this.Const.Strings.PerkName.LegendSpecialistShieldSkill,
		Tooltip = this.Const.Strings.PerkDescription.LegendSpecialistShieldSkill,
		Icon = "ui/perks/perk_05.png",
		IconDisabled = "ui/perks/perk_05_sw.png",
		Const = "LegendSpecialistShieldSkill"
	},
	{
		ID = "perk.legend_specialist_shield_push",
		Script = "scripts/skills/perks/perk_legend_specialist_shield_push",
		Name = this.Const.Strings.PerkName.LegendSpecialistShieldPush,
		Tooltip = this.Const.Strings.PerkDescription.LegendSpecialistShieldPush,
		Icon = "ui/perks/perk_22.png",
		IconDisabled = "ui/perks/perk_22_sw.png",
		Const = "LegendSpecialistShieldPush"
	},
	{
		ID = "perk.shield_bash",
		Script = "scripts/skills/perks/perk_shield_bash",
		Name = this.Const.Strings.PerkName.ShieldBash,
		Tooltip = this.Const.Strings.PerkDescription.ShieldBash,
		Icon = "ui/perks/perk_22.png",
		IconDisabled = "ui/perks/perk_22_sw.png",
		Const = "ShieldBash"
	},
	{
		ID = "perk.legend_mastery_nets",
		Script = "scripts/skills/perks/perk_legend_mastery_nets",
		Name = this.Const.Strings.PerkName.LegendMasteryNets,
		Tooltip = this.Const.Strings.PerkDescription.LegendMasteryNets,
		Icon = "ui/perks/net_perk.png",
		IconDisabled = "ui/perks/net_perk_bw.png",
		Const = "LegendMasteryNets"
	},
	{
		ID = "perk.legend_vala_chant_fury",
		Script = "scripts/skills/perks/legend_vala_chant_fury",
		Name = this.Const.Strings.PerkName.LegendValaChantFury,
		Tooltip = this.Const.Strings.PerkDescription.LegendValaChantFury,
		Icon = "ui/perks/legend_vala_chant_fury.png",
		IconDisabled = "ui/perks/legend_vala_chant_fury_sw.png",
		Const = "LegendValaChantFury"
	},
	{
		ID = "perk.legend_vala_chant_senses",
		Script = "scripts/skills/perks/legend_vala_chant_senses",
		Name = this.Const.Strings.PerkName.LegendValaChantSenses,
		Tooltip = this.Const.Strings.PerkDescription.LegendValaChantSenses,
		Icon = "ui/perks/legend_vala_chant_senses.png",
		IconDisabled = "ui/perks/legend_vala_chant_senses_sw.png",
		Const = "LegendValaChantSenses"
	},
	{
		ID = "perk.legend_specialist_scythe_skill",
		Script = "scripts/skills/perks/perk_legend_specialist_scythe_skill",
		Name = this.Const.Strings.PerkName.LegendSpecialistScytheSkill,
		Tooltip = this.Const.Strings.PerkDescription.LegendSpecialistScytheSkill,
		Icon = "ui/perks/scythe_01.png",
		IconDisabled = "ui/perks/scythe_bw.png",
		Const = "LegendSpecialistScytheSkill"
	},
	{
		ID = "perk.legend_specialist_scythe_damage",
		Script = "scripts/skills/perks/perk_legend_specialist_scythe_damage",
		Name = this.Const.Strings.PerkName.LegendSpecialistScytheDamage,
		Tooltip = this.Const.Strings.PerkDescription.LegendSpecialistScytheDamage,
		Icon = "ui/perks/scythe_02.png",
		IconDisabled = "ui/perks/scythe_bw.png",
		Const = "LegendSpecialistScytheDamage"
	},
	{
		ID = "perk.legend_inventor_anatomy",
		Script = "scripts/skills/perks/legend_inventor_anatomy",
		Name = this.Const.Strings.PerkName.LegendInventorAnatomy,
		Tooltip = this.Const.Strings.PerkDescription.LegendInventorAnatomy,
		Icon = "ui/perks/legend_inventor_anatomy.png",
		IconDisabled = "ui/perks/legend_inventor_anatomy_sw.png",
		Const = "LegendInventorAnatomy"
	},
	{
		ID = "perk.legend_mastery_slings",
		Script = "scripts/skills/perks/legend_mastery_slings",
		Name = this.Const.Strings.PerkName.LegendMasterySlings,
		Tooltip = this.Const.Strings.PerkDescription.LegendMasterySlings,
		Icon = "ui/perks/sling_03.png",
		IconDisabled = "ui/perks/sling_bw.png",
		Const = "LegendMasterySlings"
	},
	{
		ID = "perk.relentless",
		Script = "scripts/skills/perks/perk_relentless",
		Name = this.Const.Strings.PerkName.Relentless,
		Tooltip = this.Const.Strings.PerkDescription.Relentless,
		Icon = "ui/perks/perk_26.png",
		IconDisabled = "ui/perks/perk_26_sw.png",
		Const = "Relentless"
	},
	{
		ID = "perk.legend_specialist_ninetails_damage",
		Script = "scripts/skills/perks/perk_legend_specialist_ninetails_damage",
		Name = this.Const.Strings.PerkName.LegendSpecialistNinetailsDamage,
		Tooltip = this.Const.Strings.PerkDescription.LegendSpecialistNinetailsDamage,
		Icon = "ui/perks/ninetails_01.png",
		IconDisabled = "ui/perks/ninetails_bw.png",
		Const = "LegendSpecialistNinetailsDamage"
	},
	{
		ID = "perk.legend_specialist_ninetails_skill",
		Script = "scripts/skills/perks/perk_legend_specialist_ninetails_skill",
		Name = this.Const.Strings.PerkName.LegendSpecialistNinetailsSkill,
		Tooltip = this.Const.Strings.PerkDescription.LegendSpecialistNinetailsSkill,
		Icon = "ui/perks/ninetails_02.png",
		IconDisabled = "ui/perks/ninetails_bw.png",
		Const = "LegendSpecialistNinetailsSkill"
	},
	{
		ID = "perk.legend_favoured_enemy_ghoul",
		Script = "scripts/skills/perks/perk_legend_favoured_enemy_ghoul",
		Name = this.Const.Strings.PerkName.LegendFavouredEnemyGhoul,
		Tooltip = this.Const.Strings.PerkDescription.LegendFavouredEnemyGhoul,
		Icon = "ui/perks/favoured_ghoul_01.png",
		IconDisabled = "ui/perks/favoured_ghoul_bw.png",
		Const = "LegendFavouredEnemyGhoul"
	},
	{
		ID = "perk.legend_favoured_enemy_hexen",
		Script = "scripts/skills/perks/perk_legend_favoured_enemy_hexen",
		Name = this.Const.Strings.PerkName.LegendFavouredEnemyHexen,
		Tooltip = this.Const.Strings.PerkDescription.LegendFavouredEnemyHexen,
		Icon = "ui/perks/favoured_hexen_01.png",
		IconDisabled = "ui/perks/favoured_hexen_bw.png",
		Const = "LegendFavouredEnemyHexen"
	},
	{
		ID = "perk.legend_favoured_enemy_alps",
		Script = "scripts/skills/perks/perk_legend_favoured_enemy_alps",
		Name = this.Const.Strings.PerkName.LegendFavouredEnemyAlps,
		Tooltip = this.Const.Strings.PerkDescription.LegendFavouredEnemyAlps,
		Icon = "ui/perks/favoured_alps_01.png",
		IconDisabled = "ui/perks/favoured_alps_bw.png",
		Const = "LegendFavouredEnemyAlps"
	},
	{
		ID = "perk.legend_favoured_enemy_unhold",
		Script = "scripts/skills/perks/perk_legend_favoured_enemy_unhold",
		Name = this.Const.Strings.PerkName.LegendFavouredEnemyUnhold,
		Tooltip = this.Const.Strings.PerkDescription.LegendFavouredEnemyUnhold,
		Icon = "ui/perks/favoured_unhold_01.png",
		IconDisabled = "ui/perks/favoured_unhold_bw.png",
		Const = "LegendFavouredEnemyUnhold"
	},
	{
		ID = "perk.legend_favoured_enemy_lindwurm",
		Script = "scripts/skills/perks/perk_legend_favoured_enemy_lindwurm",
		Name = this.Const.Strings.PerkName.LegendFavouredEnemyLindwurm,
		Tooltip = this.Const.Strings.PerkDescription.LegendFavouredEnemyLindwurm,
		Icon = "ui/perks/favoured_lindwurm_01.png",
		IconDisabled = "ui/perks/favoured_lindwurm_bw.png",
		Const = "LegendFavouredEnemyLindwurm"
	},
	{
		ID = "perk.legend_favoured_enemy_direwolf",
		Script = "scripts/skills/perks/perk_legend_favoured_enemy_direwolf",
		Name = this.Const.Strings.PerkName.LegendFavouredEnemyDirewolf,
		Tooltip = this.Const.Strings.PerkDescription.LegendFavouredEnemyDirewolf,
		Icon = "ui/perks/favoured_direwolf_01.png",
		IconDisabled = "ui/perks/favoured_direwolf_bw.png",
		Const = "LegendFavouredEnemyDirewolf"
	},
	{
		ID = "perk.legend_favoured_enemy_spider",
		Script = "scripts/skills/perks/perk_legend_favoured_enemy_spider",
		Name = this.Const.Strings.PerkName.LegendFavouredEnemySpider,
		Tooltip = this.Const.Strings.PerkDescription.LegendFavouredEnemySpider,
		Icon = "ui/perks/favoured_spider_01.png",
		IconDisabled = "ui/perks/favoured_spider_bw.png",
		Const = "LegendFavouredEnemySpider"
	},
	{
		ID = "perk.legend_favoured_enemy_schrat",
		Script = "scripts/skills/perks/perk_legend_favoured_enemy_schrat",
		Name = this.Const.Strings.PerkName.LegendFavouredEnemySchrat,
		Tooltip = this.Const.Strings.PerkDescription.LegendFavouredEnemySchrat,
		Icon = "ui/perks/favoured_schrat_01.png",
		IconDisabled = "ui/perks/favoured_schrat_bw.png",
		Const = "LegendFavouredEnemySchrat"
	},
	{
		ID = "perk.legend_favoured_enemy_ork",
		Script = "scripts/skills/perks/perk_legend_favoured_enemy_ork",
		Name = this.Const.Strings.PerkName.LegendFavouredEnemyOrk,
		Tooltip = this.Const.Strings.PerkDescription.LegendFavouredEnemyOrk,
		Icon = "ui/perks/favoured_ork_01.png",
		IconDisabled = "ui/perks/favoured_ork_bw.png",
		Const = "LegendFavouredEnemyOrk"
	},
	{
		ID = "perk.legend_favoured_enemy_goblin",
		Script = "scripts/skills/perks/perk_legend_favoured_enemy_goblin",
		Name = this.Const.Strings.PerkName.LegendFavouredEnemyGoblin,
		Tooltip = this.Const.Strings.PerkDescription.LegendFavouredEnemyGoblin,
		Icon = "ui/perks/favoured_goblin_01.png",
		IconDisabled = "ui/perks/favoured_goblin_bw.png",
		Const = "LegendFavouredEnemyGoblin"
	},
	{
		ID = "perk.legend_favoured_enemy_vampire",
		Script = "scripts/skills/perks/perk_legend_favoured_enemy_vampire",
		Name = this.Const.Strings.PerkName.LegendFavouredEnemyVampire,
		Tooltip = this.Const.Strings.PerkDescription.LegendFavouredEnemyVampire,
		Icon = "ui/perks/favoured_vampire_01.png",
		IconDisabled = "ui/perks/favoured_vampire_bw.png",
		Const = "LegendFavouredEnemyVampire"
	},
	{
		ID = "perk.legend_favoured_enemy_skeleton",
		Script = "scripts/skills/perks/perk_legend_favoured_enemy_skeleton",
		Name = this.Const.Strings.PerkName.LegendFavouredEnemySkeleton,
		Tooltip = this.Const.Strings.PerkDescription.LegendFavouredEnemySkeleton,
		Icon = "ui/perks/favoured_skeleton_01.png",
		IconDisabled = "ui/perks/favoured_skeleton_bw.png",
		Const = "LegendFavouredEnemySkeleton"
	},
	{
		ID = "perk.legend_favoured_enemy_zombie",
		Script = "scripts/skills/perks/perk_legend_favoured_enemy_zombie",
		Name = this.Const.Strings.PerkName.LegendFavouredEnemyZombie,
		Tooltip = this.Const.Strings.PerkDescription.LegendFavouredEnemyZombie,
		Icon = "ui/perks/favoured_zombie_01.png",
		IconDisabled = "ui/perks/favoured_zombie_bw.png",
		Const = "LegendFavouredEnemyZombie"
	},
	{
		ID = "perk.legend_favoured_enemy_noble",
		Script = "scripts/skills/perks/perk_legend_favoured_enemy_noble",
		Name = this.Const.Strings.PerkName.LegendFavouredEnemyNoble,
		Tooltip = this.Const.Strings.PerkDescription.LegendFavouredEnemyNoble,
		Icon = "ui/perks/favoured_noble_01.png",
		IconDisabled = "ui/perks/favoured_noble_bw.png",
		Const = "LegendFavouredEnemyNoble"
	},
	{
		ID = "perk.legend_favoured_enemy_barbarian",
		Script = "scripts/skills/perks/perk_legend_favoured_enemy_barbarian",
		Name = this.Const.Strings.PerkName.LegendFavouredEnemyBarbarian,
		Tooltip = this.Const.Strings.PerkDescription.LegendFavouredEnemyBarbarian,
		Icon = "ui/perks/favoured_barbarian_01.png",
		IconDisabled = "ui/perks/favoured_barbarian_bw.png",
		Const = "LegendFavouredEnemyBarbarian"
	},	
	{
		ID = "perk.legend_favoured_enemy_bandit",
		Script = "scripts/skills/perks/perk_legend_favoured_enemy_bandit",
		Name = this.Const.Strings.PerkName.LegendFavouredEnemyBandit,
		Tooltip = this.Const.Strings.PerkDescription.LegendFavouredEnemyBandit,
		Icon = "ui/perks/favoured_bandit_01.png",
		IconDisabled = "ui/perks/favoured_bandit_bw.png",
		Const = "LegendFavouredEnemyBandit"
	},
	{
		ID = "perk.legend_favoured_enemy_archer",
		Script = "scripts/skills/perks/perk_legend_favoured_enemy_archer",
		Name = this.Const.Strings.PerkName.LegendFavouredEnemyArcher,
		Tooltip = this.Const.Strings.PerkDescription.LegendFavouredEnemyArcher,
		Icon = "ui/perks/favoured_archer_01.png",
		IconDisabled = "ui/perks/favoured_archer_bw.png",
		Const = "LegendFavouredEnemyArcher"
	},
	{
		ID = "perk.legend_favoured_enemy_swordmaster",
		Script = "scripts/skills/perks/perk_legend_favoured_enemy_swordmaster",
		Name = this.Const.Strings.PerkName.LegendFavouredEnemySwordmaster,
		Tooltip = this.Const.Strings.PerkDescription.LegendFavouredEnemySwordmaster,
		Icon = "ui/perks/favoured_swordmaster_01.png",
		IconDisabled = "ui/perks/favoured_swordmaster_bw.png",
		Const = "LegendFavouredEnemySwordmaster"
	},	
	{
		ID = "perk.legend_favoured_enemy_mercenary",
		Script = "scripts/skills/perks/perk_legend_favoured_enemy_mercenary",
		Name = this.Const.Strings.PerkName.LegendFavouredEnemyMercenary,
		Tooltip = this.Const.Strings.PerkDescription.LegendFavouredEnemyMercenary,
		Icon = "ui/perks/favoured_mercenary_01.png",
		IconDisabled = "ui/perks/favoured_mercenary_bw.png",
		Const = "LegendFavouredEnemyMercenary"
	},
	{
		ID = "perk.legend_favoured_enemy_caravan",
		Script = "scripts/skills/perks/perk_legend_favoured_enemy_caravan",
		Name = this.Const.Strings.PerkName.LegendFavouredEnemyCaravan,
		Tooltip = this.Const.Strings.PerkDescription.LegendFavouredEnemyCaravan,
		Icon = "ui/perks/favoured_caravan_01.png",
		IconDisabled = "ui/perks/favoured_caravan_bw.png",
		Const = "LegendFavouredEnemyCaravan"
	},
	{
		ID = "perk.legend_favoured_enemy_caravan",
		Script = "scripts/skills/perks/perk_legend_favoured_enemy_caravan",
		Name = this.Const.Strings.PerkName.LegendFavouredEnemyCaravan,
		Tooltip = this.Const.Strings.PerkDescription.LegendFavouredEnemyCaravan,
		Icon = "ui/perks/favoured_caravan_01.png",
		IconDisabled = "ui/perks/favoured_caravan_bw.png",
		Const = "LegendFavouredEnemyCaravan"
	},
	{
		ID = "perk.mastery.greatsword",
		Script = "scripts/skills/perks/perk_mastery_greatsword",
		Name = this.Const.Strings.PerkName.LegendSpecGreatSword,
		Tooltip = this.Const.Strings.PerkDescription.LegendSpecGreatSword,
		Icon = "ui/perks/spec_greatsword.png",
		IconDisabled = "ui/perks/spec_greatsword_bw.png",
		Const = "LegendSpecGreatSword"
	},
	{
		ID = "perk.legend_forceful_swing",
		Script = "scripts/skills/perks/perk_legend_forceful_swing",
		Name = this.Const.Strings.PerkName.LegendForcefulSwing,
		Tooltip = this.Const.Strings.PerkDescription.LegendForcefulSwing,
		Icon = "ui/perks/forceful_swings.png",
		IconDisabled = "ui/perks/forceful_swings_bw.png",
		Const = "LegendForcefulSwing"
	},
	{
		ID = "perk.legend_balance",
		Script = "scripts/skills/perks/perk_legend_balance",
		Name = this.Const.Strings.PerkName.LegendBalance,
		Tooltip = this.Const.Strings.PerkDescription.LegendBalance,
		Icon = "ui/perks/balance.png",
		IconDisabled = "ui/perks/balance_bw.png",
		Const = "LegendBalance"
	},
	{
		ID = "perk.legend_matching_set",
		Script = "scripts/skills/perks/perk_legend_matching_set",
		Name = this.Const.Strings.PerkName.LegendMatchingSet,
		Tooltip = this.Const.Strings.PerkDescription.LegendMatchingSet,
		Icon = "ui/perks/matching_set.png",
		IconDisabled = "ui/perks/matching_set_bw.png",
		Const = "LegendMatchingSet"
	},
	{
		ID = "perk.legend_lithe",
		Script = "scripts/skills/perks/perk_legend_lithe",
		Name = this.Const.Strings.PerkName.LegendLithe,
		Tooltip = this.Const.Strings.PerkDescription.LegendLithe,
		Icon = "ui/perks/lithe.png",
		IconDisabled = "ui/perks/lithe_bw.png",
		Const = "LegendLithe"
	},
	{
		ID = "perk.legend_hidden",
		Script = "scripts/skills/perks/perk_legend_hidden",
		Name = this.Const.Strings.PerkName.LegendHidden,
		Tooltip = this.Const.Strings.PerkDescription.LegendHidden,
		Icon = "ui/perks/hidden.png",
		IconDisabled = "ui/perks/hidden_bw.png",
		Const = "LegendHidden"
	},
	{
		ID = "perk.legend_specialist_spearwall",
		Script = "scripts/skills/perks/perk_legend_specialist_spearwall",
		Name = this.Const.Strings.PerkName.LegendSpecSpearWall,
		Tooltip = this.Const.Strings.PerkDescription.LegendSpecSpearWall,
		Icon = "ui/perks/spearwall_mastery.png",
		IconDisabled = "ui/perks/spearwall_mastery_bw.png",
		Const = "LegendSpecSpearWall"
	},
	{
		ID = "perk.legend_specialist_spearwall",
		Script = "scripts/skills/perks/perk_legend_specialist_spearthrust",
		Name = this.Const.Strings.PerkName.LegendSpecSpearThrust,
		Tooltip = this.Const.Strings.PerkDescription.LegendSpecSpearThrust,
		Icon = "ui/perks/spearthrust_mastery.png",
		IconDisabled = "ui/perks/spearthrust_mastery_bw.png",
		Const = "LegendSpecSpearThrust"
	},
	{
		ID = "perk.legend_assured_conquest",
		Script = "scripts/skills/perks/perk_legend_assured_conquest",
		Name = this.Const.Strings.PerkName.LegendAssuredConquest,
		Tooltip = this.Const.Strings.PerkDescription.LegendAssuredConquest,
		Icon = "ui/perks/assured_conquest_circle.png",
		IconDisabled = "ui/perks/assured_conquest_circle_bw.png",
		Const = "LegendAssuredConquest"
	},	
	{
		ID = "perk.legend_blend_in",
		Script = "scripts/skills/perks/perk_legend_blend_in",
		Name = this.Const.Strings.PerkName.LegendBlendIn,
		Tooltip = this.Const.Strings.PerkDescription.LegendBlendIn,
		Icon = "ui/perks/blend_in_circle.png",
		IconDisabled = "ui/perks/blend_in_circle_bw.png",
		Const = "LegendBlendIn"
	},	
	{
		ID = "perk.legend_mastery_staff_stun",
		Script = "scripts/skills/perks/perk_mastery_staff_stun",
		Name = this.Const.Strings.PerkName.LegendSpecStaffStun,
		Tooltip = this.Const.Strings.PerkDescription.LegendSpecStaffStun,
		Icon = "ui/perks/staff_circle.png",
		IconDisabled = "ui/perks/staff_circle_bw.png",
		Const = "LegendSpecStaffStun"
	},	
	{
		ID = "perk.legend_staff_skill",
		Script = "scripts/skills/perks/perk_legend_specialist_staff_skill",
		Name = this.Const.Strings.PerkName.LegendSpecStaffStun,
		Tooltip = this.Const.Strings.PerkDescription.LegendSpecStaffStun,
		Icon = "ui/perks/staff_skill_circle.png",
		IconDisabled = "ui/perks/staff_skill_circle_bw.png",
		Const = "LegendSpecStaffSkill"
	},	
	{
		ID = "perk.legend_drums_of_war",
		Script = "scripts/skills/perks/perk_legend_drums_of_war",
		Name = this.Const.Strings.PerkName.LegendDrumsOfWar,
		Tooltip = this.Const.Strings.PerkDescription.LegendDrumsOfWar,
		Icon = "ui/perks/drums_circle.png",
		IconDisabled = "ui/perks/drums_circle_bw.png",
		Const = "LegendDrumsOfWar"
	},	
	
];


gt.Const.Perks.PerkDefs <- {}

foreach(i, v in gt.Const.Perks.PerkDefObjects)
{
	gt.Const.Perks.PerkDefs[v.Const] <- i;
}
