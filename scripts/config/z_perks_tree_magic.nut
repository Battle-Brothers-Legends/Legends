local gt = this.getroottable();

if (!("Perks" in gt.Const))
{
	gt.Const.Perks <- {};
}

gt.Const.Perks.ValaChantMagicTree <- {
	ID = "ValaChantMagicTree",
	Name = "Vala Chant",
	Descriptions = [
		"chants"
	],
	Tree = [
		[],
		[],
		[gt.Const.Perks.PerkDefs.LegendValaChantSenses],
		[gt.Const.Perks.PerkDefs.LegendValaChantMastery],
		[gt.Const.Perks.PerkDefs.LegendValaChantDisharmony],
		[],
		[]
	]
};

gt.Const.Perks.ValaTranceMagicTree <- {
	ID = "ValaTranceMagicTree",
	Name = "Vala Trance",
	Descriptions = [
		"trances"
	],
	Tree = [
		[],
		[gt.Const.Perks.PerkDefs.LegendValaTranceMalevolent],
		[],
		[gt.Const.Perks.PerkDefs.LegendValaTranceMastery],
		[],
		[gt.Const.Perks.PerkDefs.LegendValaThreads],
		[]
	]
};

gt.Const.Perks.ValaRuneMagicTree <- {
	ID = "ValaRuneMagicTree",
	Name = "Vala Rune"
	Descriptions = [
		"runes"
	],
	Tree = [
		[gt.Const.Perks.PerkDefs.LegendValaInscribeShield],
		[],
		[gt.Const.Perks.PerkDefs.LegendValaInscribeHelmet],
		[gt.Const.Perks.PerkDefs.LegendValaInscriptionMastery],
		[gt.Const.Perks.PerkDefs.LegendValaInscribeArmor],
		[],
		[gt.Const.Perks.PerkDefs.LegendValaInscribeWeapon]
	]
};

gt.Const.Perks.ValaSpiritMagicTree <- {
	ID = "ValaSpiritMagicTree",
	Name = "Vala Spirits",
	Descriptions = [
		"spirits"
	],
	Tree = [
		[gt.Const.Perks.PerkDefs.LegendValaWarden],
		[],
		[gt.Const.Perks.PerkDefs.LegendValaPremonition],
		[],
		[],
		[gt.Const.Perks.PerkDefs.LegendValaSpiritualBond],
		[]
	]
};

gt.Const.Perks.InventorMagicTree <- {
	ID = "InventorMagicTree",
	Name = "Inventor",
	Descriptions = [
		"inventor"
	],
	Tree = [
		[],
		[],
		[],
		[],
		[],
		[],
		[gt.Const.Perks.PerkDefs.LegendInventorAnatomy]
	]
};


gt.Const.Perks.RangerHuntMagicTree <- {
	ID = "RangerHuntMagicTree",
	Name = "Ranger",
	Descriptions = [
		"hunting"
	],
	Tree = [
		[gt.Const.Perks.PerkDefs.LegendMarkTarget],
		[],
		[],
		[gt.Const.Perks.PerkDefs.LegendSpecPoison],
		[],
		[gt.Const.Perks.PerkDefs.LegendFavouredEnemyArcher],
		[gt.Const.Perks.PerkDefs.LegendBigGameHunter]
	]
};

gt.Const.Perks.VampireMagicTree <- {
	ID = "VampireMagicTree",
	Name = "Vampire",
	Descriptions = [
		"undeath"
	],
	Tree = [
		[gt.Const.Perks.PerkDefs.LegendPrepareBleed],
		[gt.Const.Perks.PerkDefs.Debilitate],
		[],
		[gt.Const.Perks.PerkDefs.LegendBloodbath],
		[gt.Const.Perks.PerkDefs.LegendSlaughter],
		[gt.Const.Perks.PerkDefs.LegendGruesomeFeast],
		[gt.Const.Perks.PerkDefs.LegendDarkflight]
	]
};

gt.Const.Perks.BerserkerMagicTree <- {
	ID = "BerserkerMagicTree",
	Name = "Berserker",
	Descriptions = [
		"berserking"
	],
	Tree = [
		[gt.Const.Perks.PerkDefs.Colossus],
		[gt.Const.Perks.PerkDefs.DevastatingStrikes],
		[gt.Const.Perks.PerkDefs.Brawny],
		[],
		[gt.Const.Perks.PerkDefs.LegendMuscularity],
		[gt.Const.Perks.PerkDefs.Berserk],
		[
		gt.Const.Perks.PerkDefs.LegendBerserkerRage,
		gt.Const.Perks.PerkDefs.LegendUberNimble
		]
	]
};

gt.Const.Perks.CaptainMagicTree <- {
	ID = "CaptainMagicTree",
	Name = "Leadership",
	Descriptions = [
		"leading"
	],
	Tree = [
		[gt.Const.Perks.PerkDefs.LegendBackToBasics],
		[gt.Const.Perks.PerkDefs.LegendComposure],
		[gt.Const.Perks.PerkDefs.InspiringPresence],
		[gt.Const.Perks.PerkDefs.LegendShieldsUp],
		[gt.Const.Perks.PerkDefs.LegendHoldTheLine],
		[gt.Const.Perks.PerkDefs.LegendForwardPush],
		[gt.Const.Perks.PerkDefs.Inspire]
	]
};

gt.Const.Perks.DruidMagicTree <- {
	ID = "DruidMagicTree",
	Name = "Druidic Arts",
	Descriptions = [
		"druidic arts"
	],
	Tree = [
		[gt.Const.Perks.PerkDefs.LegendWither],
		[gt.Const.Perks.PerkDefs.LegendRoots],
		[gt.Const.Perks.PerkDefs.LegendPrayerOfLife],
		[],
		[gt.Const.Perks.PerkDefs.LegendSummonStorm],
		[gt.Const.Perks.PerkDefs.LegendDrumsOfLife],
		[gt.Const.Perks.PerkDefs.LegendInsects]
	]
};

gt.Const.Perks.AssassinMagicTree <- {
	ID = "AssassinMagicTree",
	Name = "Assassin",
	Descriptions = [
		"assassination"
	],
	Tree = [
		[],
		[],
		[],
		[gt.Const.Perks.PerkDefs.LegendHidden],
		[gt.Const.Perks.PerkDefs.LegendBlendIn],
		[gt.Const.Perks.PerkDefs.LegendUntouchable],
		[gt.Const.Perks.PerkDefs.LegendAssassinate]
	]
};

gt.Const.Perks.PhilosophyMagicTree <- {
	ID = "PhilosophyMagicTree",
	Name = "Philosophy",
	Descriptions = [
		"philosophy"
	],
	Tree = [
		[],
		[],
		[],
		[],
		[gt.Const.Perks.PerkDefs.LegendScholar],
		[gt.Const.Perks.PerkDefs.LegendScrollIngredients]
	]
}

gt.Const.Perks.MagicTrees <- {
	Tree = [
		gt.Const.Perks.ValaChantMagicTree,
		gt.Const.Perks.ValaTranceMagicTree,
		//gt.Const.Perks.HealerMagicTree,
		//gt.Const.Perks.ValaRuneMagicTree,
		// gt.Const.Perks.ValaSpiritMagicTree,
		gt.Const.Perks.RangerHuntMagicTree,
		gt.Const.Perks.VampireMagicTree,
		gt.Const.Perks.BerserkerMagicTree,
		gt.Const.Perks.DruidMagicTree,
		gt.Const.Perks.CaptainMagicTree,
		// gt.Const.Perks.AssassinMagicTree,
		gt.Const.Perks.PhilosophyMagicTree

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
