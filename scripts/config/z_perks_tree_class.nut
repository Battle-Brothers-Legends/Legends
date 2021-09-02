local gt = this.getroottable();

if (!("Perks" in gt.Const))
{
	gt.Const.Perks <- {};
}

gt.Const.Perks.BeastClassTree <- {
	ID = "BeastClassTree",
	Name = "Nets",
	Descriptions = [
		"catching beasts"
	],
	Tree = [
		[],
		[gt.Const.Perks.PerkDefs.LegendNetRepair],
		[gt.Const.Perks.PerkDefs.LegendNetCasting],
		[gt.Const.Perks.PerkDefs.LegendMasteryNets],
		[gt.Const.Perks.PerkDefs.LegendEscapeArtist],
		[],
		[]
	]
};

gt.Const.Perks.BardClassTree <- {
	ID = "BardClassTree",
	Name = "Bard",
	Descriptions = [
		"entertaining"
	],
	Tree = [
		[
		gt.Const.Perks.PerkDefs.LegendCheerOn,
		gt.Const.Perks.PerkDefs.LegendSpecialistLuteSkill
		],
		[gt.Const.Perks.PerkDefs.LegendDaze],
		[gt.Const.Perks.PerkDefs.LegendSpecialistLuteDamage],
		[gt.Const.Perks.PerkDefs.LegendEntice],
		[gt.Const.Perks.PerkDefs.LegendPush],
		[gt.Const.Perks.PerkDefs.LegendDrumsOfWar],
		[gt.Const.Perks.PerkDefs.LegendDrumsOfLife]
	]
};

gt.Const.Perks.HealerClassTree <- {
	ID = "HealerClassTree",
	Name = "Healing",
	Descriptions = [
		"healing"
	],
	Tree = [
		[gt.Const.Perks.PerkDefs.LegendMedIngredients],
		[],
		[],
		[gt.Const.Perks.PerkDefs.LegendSpecBandage],
		[],
		[],
		[gt.Const.Perks.PerkDefs.LegendFieldTriage]
	]
};

gt.Const.Perks.FaithClassTree <- {
	ID = "FaithClassTree",
	Name = "Faith",
	Descriptions = [
		"faith"
	],
	Tree = [
		[],
		[],
		[],
		[],
		[gt.Const.Perks.PerkDefs.LegendPrayerOfFaith],
		[gt.Const.Perks.PerkDefs.LegendPrayerOfLife],
		[gt.Const.Perks.PerkDefs.LegendHolyFlame]
	]
};

gt.Const.Perks.FistsClassTree <- {
	ID = "FistsClassTree",
	Name = "Unarmed",
	Descriptions = [
		"unarmed combat"
	],
	Tree = [
		[gt.Const.Perks.PerkDefs.LegendUnarmedTraining],
		[gt.Const.Perks.PerkDefs.LegendKick],
		[gt.Const.Perks.PerkDefs.LegendGrapple],
		[gt.Const.Perks.PerkDefs.LegendSpecFists],
		[gt.Const.Perks.PerkDefs.LegendUnarmedLunge],
		[gt.Const.Perks.PerkDefs.LegendChoke],
		[gt.Const.Perks.PerkDefs.PushTheAdvantage]
	]
};

gt.Const.Perks.ChefClassTree <- {
	ID = "ChefClassTree",
	Name = "Chef",
	Descriptions = [
		"cooking"
	],
	Tree = [
		[gt.Const.Perks.PerkDefs.LegendMealPreperation],
		[gt.Const.Perks.PerkDefs.LegendCampCook],
		[gt.Const.Perks.PerkDefs.LegendAlcoholBrewing],
		[],
		[],
		[gt.Const.Perks.PerkDefs.LegendQuartermaster],
		[gt.Const.Perks.PerkDefs.LegendFieldTreats]
	]
};

gt.Const.Perks.RepairClassTree <- {
	ID = "RepairClassTree",
	Name = "Repair",
	Descriptions = [
		"repairs"
	],
	Tree = [
		[],
		[gt.Const.Perks.PerkDefs.LegendToolsDrawers],
		[gt.Const.Perks.PerkDefs.LegendToolsSpares],
		[],
		[],
		[],
		[gt.Const.Perks.PerkDefs.LegendFieldRepairs]
	]
};

gt.Const.Perks.BarterClassTree <- {
	ID = "BarterClassTree",
	Name = "Barter",
	Descriptions = [
		"bartering"
	],
	Tree = [
		[],
		[],
		[gt.Const.Perks.PerkDefs.LegendBarterConvincing],
		[],
		[gt.Const.Perks.PerkDefs.LegendBarterTrustworthy],
		[
		gt.Const.Perks.PerkDefs.LegendDangerPay,
		gt.Const.Perks.PerkDefs.LegendPaymaster
		],
		[
		gt.Const.Perks.PerkDefs.LegendBribe,
		gt.Const.Perks.PerkDefs.LegendBarterGreed
		]
	]
};

gt.Const.Perks.KnifeClassTree <- {
	ID = "KnifeClassTree",
	Name = "Knives",
	Descriptions = [
		"knives"
	],
	Tree = [
		[gt.Const.Perks.PerkDefs.LegendSpecialistKnifeSkill],
		[],
		[gt.Const.Perks.PerkDefs.LegendSpecialistKnifeDamage],
		[],
		[],
		[gt.Const.Perks.PerkDefs.LegendHidden],
		[gt.Const.Perks.PerkDefs.LegendAssassinate]
	]
};

gt.Const.Perks.ButcherClassTree <- {
	ID = "ButcherClassTree",
	Name = "Butcher",
	Descriptions = [
		"butchery"
	],
	Tree = [
		[gt.Const.Perks.PerkDefs.LegendSpecialistButcherSkill],
		[],
		[gt.Const.Perks.PerkDefs.LegendSpecialistButcherDamage],
		[],
		[gt.Const.Perks.PerkDefs.LegendPrepareBleed],
		[gt.Const.Perks.PerkDefs.LegendPrepareGraze],
		[gt.Const.Perks.PerkDefs.LegendSlaughter]
	]
};

gt.Const.Perks.HammerClassTree <- {
	ID = "HammerClassTree",
	Name = "Blacksmith",
	Descriptions = [
		"hammers"
	],
	Tree = [
		[gt.Const.Perks.PerkDefs.LegendSpecialistHammerSkill],
		[],
		[gt.Const.Perks.PerkDefs.LegendSpecialistHammerDamage],
		[],
		[gt.Const.Perks.PerkDefs.SunderingStrikes],
		[],
		[]
	]
};

gt.Const.Perks.MilitiaClassTree <- {
	ID = "MilitiaClassTree",
	Name = "Militia",
	Descriptions = [
		"militia"
	],
	Tree = [
		[gt.Const.Perks.PerkDefs.LegendSpecialistMilitiaSkill],
		[],
		[gt.Const.Perks.PerkDefs.LegendSpecialistMilitiaDamage],
		[],
		[],
		[],
		[]
	]
};

gt.Const.Perks.PickaxeClassTree <- {
	ID = "PickaxeClassTree",
	Name = "Miner",
	Descriptions = [
		"pickaxes"
	],
	Tree = [
		[gt.Const.Perks.PerkDefs.LegendSpecialistPickaxeSkill],
		[],
		[gt.Const.Perks.PerkDefs.LegendSpecialistPickaxeDamage],
		[],
		[gt.Const.Perks.PerkDefs.SunderingStrikes],
		[],
		[]
	]
};

gt.Const.Perks.PitchforkClassTree <- {
	ID = "PitchforkClassTree",
	Name = "Farmer",
	Descriptions = [
		"pitchforks"
	],
	Tree = [
		[gt.Const.Perks.PerkDefs.LegendSpecialistPitchforkSkill],
		[],
		[gt.Const.Perks.PerkDefs.LegendSpecialistPitchforkDamage],
		[],
		[],
		[],
		[]
	]
};

gt.Const.Perks.ShortbowClassTree <- {
	ID = "ShortbowClassTree",
	Name = "Shortbow",
	Descriptions = [
		"shortbows"
	],
	Tree = [
		[gt.Const.Perks.PerkDefs.LegendSpecialistShortbowSkill],
		[],
		[gt.Const.Perks.PerkDefs.LegendSpecialistShortbowDamage],
		[],
		[],
		[],
		[]
	]
};

gt.Const.Perks.ShovelClassTree <- {
	ID = "ShovelClassTree",
	Name = "Gravedigger",
	Descriptions = [
		"shovels"
	],
	Tree = [
		[gt.Const.Perks.PerkDefs.LegendSpecialistShovelSkill],
		[],
		[gt.Const.Perks.PerkDefs.LegendSpecialistShovelDamage],
		[],
		[gt.Const.Perks.PerkDefs.LegendResurrectionist],
		[],
		[]
	]
};

gt.Const.Perks.WoodaxeClassTree <- {
	ID = "WoodaxeClassTree",
	Name = "Lumberjack",
	Descriptions = [
		"axes"
	],
	Tree = [
		[gt.Const.Perks.PerkDefs.LegendSpecialistWoodaxeSkill],
		[],
		[gt.Const.Perks.PerkDefs.LegendSpecialistWoodaxeDamage],
		[],
		[gt.Const.Perks.PerkDefs.LegendWoodworking],
		[],
		[]
	]
};

gt.Const.Perks.SickleClassTree <- {
	ID = "SickleClassTree",
	Name = "Sickle",
	Descriptions = [
		"sickles"
	],
	Tree = [
		[gt.Const.Perks.PerkDefs.LegendSpecialistSickleSkill],
		[],
		[gt.Const.Perks.PerkDefs.LegendSpecialistSickleDamage],
		[],
		[gt.Const.Perks.PerkDefs.LegendGatherer],
		[gt.Const.Perks.PerkDefs.LegendHerbcraft],
		[gt.Const.Perks.PerkDefs.LegendPotionBrewer]
	]
};

gt.Const.Perks.NinetailsClassTree <- {
	ID = "NinetailsClassTree",
	Name = "Cat O' Nine Tails",
	Descriptions = [
		"ninetails"
	],
	Tree = [
		[gt.Const.Perks.PerkDefs.LegendSpecialistNinetailsSkill],
		[gt.Const.Perks.PerkDefs.LegendSpecCultHood],
		[gt.Const.Perks.PerkDefs.LegendSpecialistNinetailsDamage],
		[],
		[gt.Const.Perks.PerkDefs.LegendPrepareGraze],
		[gt.Const.Perks.PerkDefs.LegendSpecCultArmor],
		[gt.Const.Perks.PerkDefs.LegendLacerate]
	]
}

gt.Const.Perks.JugglerClassTree <- {
	ID = "JugglerClassTree",
	Name = "Juggler",
	Descriptions = [
		"acrobatics"
	],
	Tree = [
		[],
		[gt.Const.Perks.PerkDefs.LegendHairSplitter],
		[],
		[],
		[gt.Const.Perks.PerkDefs.Footwork],
		[gt.Const.Perks.PerkDefs.LegendLeap],
		[gt.Const.Perks.PerkDefs.LegendTumble]
	]
};

gt.Const.Perks.HoundmasterClassTree <- {
	ID = "HoundmasterClassTree",
	Name = "Hound Master",
	Descriptions = [
		"training dogs"
	],
	Tree = [
		[],
		[],
		[gt.Const.Perks.PerkDefs.LegendDogWhisperer],
		[gt.Const.Perks.PerkDefs.LegendDogBreeder],
		[gt.Const.Perks.PerkDefs.LegendDogHandling],
		[gt.Const.Perks.PerkDefs.LegendPackleader],
		[gt.Const.Perks.PerkDefs.LegendDogMaster]
	]
};

gt.Const.Perks.ClassTrees <- {
	Tree = [
		gt.Const.Perks.BeastClassTree,
		gt.Const.Perks.BardClassTree,
		gt.Const.Perks.HealerClassTree,
		gt.Const.Perks.FaithClassTree,
		gt.Const.Perks.FistsClassTree,
		gt.Const.Perks.ChefClassTree,
		gt.Const.Perks.RepairClassTree,
		gt.Const.Perks.BarterClassTree,
		gt.Const.Perks.KnifeClassTree,
		gt.Const.Perks.ButcherClassTree,
		gt.Const.Perks.HammerClassTree,
		gt.Const.Perks.MilitiaClassTree,
		gt.Const.Perks.PickaxeClassTree,
		gt.Const.Perks.PitchforkClassTree,
		gt.Const.Perks.ShortbowClassTree,
		gt.Const.Perks.WoodaxeClassTree,
		gt.Const.Perks.SickleClassTree,
		gt.Const.Perks.NinetailsClassTree,
		gt.Const.Perks.JugglerClassTree,
		gt.Const.Perks.HoundmasterClassTree
	],
	function getRandom(_exclude)
	{
		local L = [];
		foreach (i, t in this.Tree)
		{
			if (_exclude != null && _exclude.find(t.ID))
			{
				continue;
			}
			L.push(i);
		}

		local r = this.Math.rand(0, L.len() - 1)
		return this.Tree[L[r]];;
	}

	function getRandomPerk()
	{
		local tree = this.getRandom(null);
		local L = [];
		foreach (row in tree.Tree)
		{
			foreach (p in row)
			{
				L.push(p);
			}
		}

		local r = this.Math.rand(0, L.len() - 1);
		return L[r];
	}
};