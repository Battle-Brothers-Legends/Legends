local gt = this.getroottable();

if (!("Perks" in gt.Const))
{
	gt.Const.Perks <- {};
}

gt.Const.Perks.AgileTree <- {
	ID = "AgileTree",
	Descriptions = [
		"moves gracefully",
		"carries themself with ease",
		"is impressively agile",
		"has an athletic physique",
		"is spry as a fox",
		"is particularly dexterous"
	],
	Tree = [
		[gt.Const.Perks.PerkDefs.Pathfinder],
		[],
		[gt.Const.Perks.PerkDefs.Sprint],
		[],
		[gt.Const.Perks.PerkDefs.Footwork],
		[],
		[]
	]
};


gt.Const.Perks.IndestructibleTree <- {
	ID = "IndestructibleTree",
	Descriptions = [
		"is stubbornly relentless",
		"is staunchly perserverent",
		"has a strong will",
		"steadfastly persists",
		"seems unswervingly firm",
		"is adamantly resolute"
	],
	Tree = [
		[gt.Const.Perks.PerkDefs.NineLives],
		[],//gt.Const.Perks.PerkDefs.LegendTasteThePain],
		[gt.Const.Perks.PerkDefs.HoldOut],
		[],
		[],
		[],
		[gt.Const.Perks.PerkDefs.Indomitable]
	]
};

gt.Const.Perks.MartyrTree <- {
	ID = "MartyrTree",
		Descriptions = [

	],
	Tree = [
		[],
		[],
		[],//gt.Const.Perks.PerkDefs.LegendTasteThePain],
		[],
		[gt.Const.Perks.PerkDefs.LoneWolf],
		[gt.Const.Perks.PerkDefs.Vengeance],
		[gt.Const.Perks.PerkDefs.LastStand]
	]
};

gt.Const.Perks.ViciousTree <- {
	ID = "ViciousTree",
		Descriptions = [

	],
	Tree = [
		[gt.Const.Perks.PerkDefs.CripplingStrikes],
		[],
		[gt.Const.Perks.PerkDefs.Debilitate],
		[],
		[gt.Const.Perks.PerkDefs.Berserk],
		[gt.Const.Perks.PerkDefs.LegendAssuredConquest],
		[]
	]
};

gt.Const.Perks.DeviousTree <- {
	ID = "DeviousTree",
		Descriptions = [

	],
	Tree = [
		[],
		[],
		[gt.Const.Perks.PerkDefs.LegendTrueBeliever],
		[],
		[gt.Const.Perks.PerkDefs.LegendBlendIn],
		[gt.Const.Perks.PerkDefs.LegendHidden],
		[gt.Const.Perks.PerkDefs.LegendEvasion]
	]
};

gt.Const.Perks.InspirationalTree <- {
	ID = "InspirationalTree",
		Descriptions = [

	],
	Tree = [
		[],
		[gt.Const.Perks.PerkDefs.RallyTheTroops],
		[gt.Const.Perks.PerkDefs.Taunt],
		[],
		[],
		[gt.Const.Perks.PerkDefs.LegendAssuredConquest],
		[gt.Const.Perks.PerkDefs.Inspire]
	]
};

gt.Const.Perks.IntelligentTree <- {
	ID = "IntelligentTree",
		Descriptions = [

	],
	Tree = [
		[gt.Const.Perks.PerkDefs.Student],
		[
			gt.Const.Perks.PerkDefs.Gifted,
			gt.Const.Perks.PerkDefs.FortifiedMind
		],
		[],
		[],
		[],
		[],
		[]
	]
};

gt.Const.Perks.CalmTree <- {
	ID = "CalmTree",
		Descriptions = [

	],
	Tree = [
		[gt.Const.Perks.PerkDefs.LegendAlert],
		[],
		[],
		[],
		[gt.Const.Perks.PerkDefs.LegendClarity],
		[],
		[gt.Const.Perks.PerkDefs.PerfectFocus]
	]
};

gt.Const.Perks.FastTree <- {
	ID = "FastTree",
		Descriptions = [

	],
	Tree = [
		[
			gt.Const.Perks.PerkDefs.FastAdaption,
			gt.Const.Perks.PerkDefs.Adrenalin
		],
		[gt.Const.Perks.PerkDefs.Dodge],
		[],
		[],
		[],
		[],
		[]
	]
};

gt.Const.Perks.LargeTree <- {
	ID = "LargeTree",
		Descriptions = [

	],
	Tree = [
		[gt.Const.Perks.PerkDefs.Colossus],
		[],
		[],
		[],
		[gt.Const.Perks.PerkDefs.LegendSecondWind],
		[],
		[gt.Const.Perks.PerkDefs.LegendMuscularity]
	]
};

gt.Const.Perks.OrganisedTree <- {
	ID = "OrganisedTree",
		Descriptions = [

	],
	Tree = [
		[gt.Const.Perks.PerkDefs.BagsAndBelts],
		[],
		[gt.Const.Perks.PerkDefs.LegendEfficientPacking],				
		[],
		[gt.Const.Perks.PerkDefs.LegendSkillfulStacking],
		[],
		[]
	]
};

gt.Const.Perks.SturdyTree <- {
	ID = "SturdyTree",
		Descriptions = [

	],
	Tree = [
		[],
		[gt.Const.Perks.PerkDefs.Stalwart],
		[gt.Const.Perks.PerkDefs.Steadfast],
		[],
		[],
		[gt.Const.Perks.PerkDefs.LegendComposure],
		[]
	]
};

gt.Const.Perks.FitTree <- {
	ID = "FitTree",
		Descriptions = [

	],
	Tree = [
		[gt.Const.Perks.PerkDefs.Recover],
		[],
		[gt.Const.Perks.PerkDefs.Relentless],
		[],
		[gt.Const.Perks.PerkDefs.Rebound],
		[],
		[]
	]
};

gt.Const.Perks.TrainedTree <- {
	ID = "TrainedTree",
		Descriptions = [

	],
	Tree = [
		[],
		[gt.Const.Perks.PerkDefs.HoldOut],
		[gt.Const.Perks.PerkDefs.Rotation],
		[],
		[gt.Const.Perks.PerkDefs.Underdog],
		[],
		[]
	]
};


gt.Const.Perks.TraitsTrees <- {
	Tree = [
		gt.Const.Perks.AgileTree,
		gt.Const.Perks.IndestructibleTree,
		gt.Const.Perks.MartyrTree,
		gt.Const.Perks.ViciousTree,
		gt.Const.Perks.DeviousTree, 
		gt.Const.Perks.InspirationalTree,
		gt.Const.Perks.IntelligentTree,
		gt.Const.Perks.CalmTree,
		gt.Const.Perks.FastTree,
		gt.Const.Perks.LargeTree, 
		gt.Const.Perks.OrganisedTree,
		gt.Const.Perks.SturdyTree,
		gt.Const.Perks.FitTree,
		gt.Const.Perks.TrainedTree
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