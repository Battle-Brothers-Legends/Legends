local gt = this.getroottable();

if (!("Perks" in gt.Const))
{
	gt.Const.Perks <- {};
}

gt.Const.Perks.MaceTree <- {
	ID = "Mace",
	Descriptions = [
		"maces"
	],
	Tree = [
		[],
		[gt.Const.Perks.PerkDefs.LegendOnslaught],
		[],
		[gt.Const.Perks.PerkDefs.SpecMace],
		[],
		[gt.Const.Perks.PerkDefs.ReturnFavor],
		[]
	]
};


gt.Const.Perks.FlailTree <- {
	ID = "Flail",
	Descriptions = [
		"flails"
	],
	Tree = [
		[],//gt.Const.Perks.PerkDefs.ShieldAvoidance],
		[],
		[],
		[gt.Const.Perks.PerkDefs.SpecFlail],
		[],
		[gt.Const.Perks.PerkDefs.HeadHunter],
		[gt.Const.Perks.PerkDefs.BattleFlow]
	]
};

gt.Const.Perks.HammerTree <- {
	ID = "Hammer",
	Descriptions = [
		"hammers"
	],
	Tree = [
		[],//gt.Const.Perks.PerkDefs.DestroyArmor
		[gt.Const.Perks.PerkDefs.LegendSmackdown],
		[],
		[gt.Const.Perks.PerkDefs.SpecHammer],
		[],
		[gt.Const.Perks.PerkDefs.SunderingStrikes],
		[]
	]
};

gt.Const.Perks.AxeTree <- {
	ID = "Axe",
	Descriptions = [
		"axes"
	],
	Tree = [
		[],
		[gt.Const.Perks.PerkDefs.LegendSmashingShields], 
		[],
		[gt.Const.Perks.PerkDefs.SpecAxe],
		[],
		[],
		[gt.Const.Perks.PerkDefs.KillingFrenzy]
	]
};

gt.Const.Perks.CleaverTree <- {
	ID = "Cleaver",
	Descriptions = [
		"cleavers"
	],
	Tree = [
		[], 
		[gt.Const.Perks.PerkDefs.LegendBloodbath],
		[],
		[gt.Const.Perks.PerkDefs.SpecCleaver],
		[],
		[],
		[gt.Const.Perks.PerkDefs.Fearsome]
	]
};

gt.Const.Perks.GreatSwordTree <- {
	ID = "GreatSword",
	Descriptions = [
		"greatswords"
	],
	Tree = [
		[],
		[gt.Const.Perks.PerkDefs.BloodyHarvest],
		[], 
		[gt.Const.Perks.PerkDefs.LegendSpecGreatSword],
		[],
		[gt.Const.Perks.PerkDefs.LegendForcefulSwing],
		[]
	]
};

gt.Const.Perks.SwordTree <- {
	ID = "Sword",
	Descriptions = [
		"swords"
	],
	Tree = [
		[],
		[gt.Const.Perks.PerkDefs.Feint],
		[],
		[gt.Const.Perks.PerkDefs.SpecSword],
		[],
		[gt.Const.Perks.PerkDefs.Duelist]
	]
};

gt.Const.Perks.DaggerTree <- {
	ID = "Dagger",
	Descriptions = [
		"daggers"
	],
	Tree = [
		[],
		[gt.Const.Perks.PerkDefs.Backstabber],
		[],
		[gt.Const.Perks.PerkDefs.SpecDagger],
		[gt.Const.Perks.PerkDefs.DoubleStrike],
		[],
		[]
	]
};
gt.Const.Perks.PolearmTree <- {
	ID = "Polearm",
	Descriptions = [
		"polearms"
	],
	Tree = [
		[],
		[gt.Const.Perks.PerkDefs.Slaughterer],
		[],
		[gt.Const.Perks.PerkDefs.SpecPolearm],
		[gt.Const.Perks.PerkDefs.ReachAdvantage],
		[],
		[]
	]
};

gt.Const.Perks.SpearTree <- {
	ID = "Spear",
	Descriptions = [
		"spears"
	],
	Tree = [
		[],
		[gt.Const.Perks.PerkDefs.LegendSpecSpearWall],
		[],
		[gt.Const.Perks.PerkDefs.SpecSpear],
		[gt.Const.Perks.PerkDefs.LegendSpecSpearThrust],
		[],
		[]
	]
};

gt.Const.Perks.CrossbowTree <- {
	ID = "Crossbow",
	Descriptions = [
		"crossbows"
	],
	Tree = [
		[],//gt.Const.Perks.PerkDefs.ArmorPierce
		[],
		[],
		[gt.Const.Perks.PerkDefs.SpecCrossbow],
		[],
		[gt.Const.Perks.PerkDefs.Ballistics],
		[gt.Const.Perks.PerkDefs.LegendPiercingShot]
	]
};

gt.Const.Perks.BowTree <- {
	ID = "Bow",
	Descriptions = [
		"bows"
	],
	Tree = [
		[],//gt.Const.Perks.PerkDefs.BowRange
		[gt.Const.Perks.PerkDefs.Bullseye],
		[],
		[gt.Const.Perks.PerkDefs.SpecBow],
		[],
		[gt.Const.Perks.PerkDefs.Overwhelm],
		[]
	]
};

gt.Const.Perks.ThrowingTree <- {
	ID = "Throwing",
	Descriptions = [
		"throwing weapons"
	],
	Tree = [
		[],
		[gt.Const.Perks.PerkDefs.QuickHands],
		[],
		[gt.Const.Perks.PerkDefs.SpecThrowing],
		[],
		[],
		[gt.Const.Perks.PerkDefs.CloseCombatArcher]
	]
};

gt.Const.Perks.SlingsTree <- {
	ID = "Slings",
	Descriptions = [
		"slings"
	],
	Tree = [
		[gt.Const.Perks.PerkDefs.LegendSpecialistSlingSkill],
		[],
		[],
		[gt.Const.Perks.PerkDefs.LegendMasterySlings],
		[gt.Const.Perks.PerkDefs.LegendSpecialistSlingDamage],
		[],
		[]
	]
};

gt.Const.Perks.StavesTree <- {
	ID = "Staves",
	Descriptions = [
		"staves"
	],
	Tree = [
		[],
		[],
		[gt.Const.Perks.PerkDefs.LegendSpecStaffSkill],
		[gt.Const.Perks.PerkDefs.LegendMasteryStaves],
		[gt.Const.Perks.PerkDefs.LegendSpecStaffStun],
		[],
		[]
	]
};

gt.Const.Perks.FistTree <- {
	ID = "FistTree",
	Descriptions = [
		"unarmed combat"
	],
	Tree = [
		[],
		[gt.Const.Perks.PerkDefs.LegendKick],
		[gt.Const.Perks.PerkDefs.LegendGrapple],
		[gt.Const.Perks.PerkDefs.LegendSpecFists],
		[],
		[],
		[]
	]
};

gt.Const.Perks.WeaponTrees <- {
	Tree = [
		gt.Const.Perks.MaceTree,
		gt.Const.Perks.FistTree,
		gt.Const.Perks.FlailTree,
		gt.Const.Perks.HammerTree,
		gt.Const.Perks.AxeTree,
		gt.Const.Perks.CleaverTree, 
		gt.Const.Perks.GreatSwordTree,
		gt.Const.Perks.SwordTree,
		gt.Const.Perks.DaggerTree,
		gt.Const.Perks.PolearmTree, 
		gt.Const.Perks.SpearTree,
		gt.Const.Perks.CrossbowTree,
		gt.Const.Perks.BowTree,
		gt.Const.Perks.ThrowingTree,
		gt.Const.Perks.SlingsTree,
		gt.Const.Perks.StavesTree
	],
	function getRandom(_exclude) 
	{
		local L = [];
		foreach (i, t in this.Tree)
		{
			if (_exclude.find(t.ID))
			{
				//this.logInfo("Excluding " + t.ID)
				continue;
			}
			L.push(i);
		}

		local r = this.Math.rand(0, L.len() - 1)
		return this.Tree[L[r]];
	}
};

gt.Const.Perks.MeleeWeaponTrees <- {
	Tree = [
		gt.Const.Perks.MaceTree,
		gt.Const.Perks.FlailTree,
		gt.Const.Perks.HammerTree,
		gt.Const.Perks.AxeTree,
		gt.Const.Perks.CleaverTree, 
		gt.Const.Perks.GreatSwordTree,
		gt.Const.Perks.SwordTree,
		gt.Const.Perks.DaggerTree,
		gt.Const.Perks.PolearmTree, 
		gt.Const.Perks.SpearTree,
		gt.Const.Perks.StavesTree
	],
	function getRandom(_exclude) 
	{
		local L = [];
		foreach (i, t in this.Tree)
		{
			if (_exclude.find(t.ID))
			{
				continue;
			}
			L.push(i);
		}

		local r = this.Math.rand(0, L.len() - 1)
		return this.Tree[L[r]];
	}
};

gt.Const.Perks.RangedWeaponTrees <- {
	Tree = [
		gt.Const.Perks.CrossbowTree,
		gt.Const.Perks.BowTree,
		gt.Const.Perks.ThrowingTree,
		gt.Const.Perks.SlingsTree
	],
	function getRandom(_exclude) 
	{
		local L = [];
		foreach (i, t in this.Tree)
		{
			if (_exclude.find(t.ID))
			{
				continue;
			}
			L.push(i);
		}

		local r = this.Math.rand(0, L.len() - 1)
		return this.Tree[L[r]];;
	}
};