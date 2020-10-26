local gt = this.getroottable();

if (!("Perks" in gt.Const))
{
	gt.Const.Perks <- {};
}

gt.Const.Perks.BeastsTree <- {
	ID = "BeastsTree",
	Descriptions = [
		"beasts"
	],
	Tree = [
		[],
		[],
		[
		gt.Const.Perks.PerkDefs.LegendFavouredEnemyGhoul,
		gt.Const.Perks.PerkDefs.LegendFavouredEnemyDirewolf,
		gt.Const.Perks.PerkDefs.LegendFavouredEnemySpider
		],
		[],
		[],
		[gt.Const.Perks.PerkDefs.LegendFavouredEnemyLindwurm],
		[]
	]
};

gt.Const.Perks.GhoulTree <- {
	ID = "GhoulTree",
	Descriptions = [
		"ghouls"
	],
	Tree = [
		[],
		[],
		[gt.Const.Perks.PerkDefs.LegendFavouredEnemyGhoul],
		[],
		[],
		[],
		[]
	]
};

gt.Const.Perks.DirewolfTree <- {
	ID = "DirewolfTree",
	Descriptions = [
		"direwolves"
	],
	Tree = [
		[],
		[],
		[gt.Const.Perks.PerkDefs.LegendFavouredEnemyDirewolf],
		[],
		[],
		[],
		[]
	]
};

gt.Const.Perks.SpiderTree <- {
	ID = "SpiderTree",
	Descriptions = [
		"spiders"
	],
	Tree = [
		[],
		[],
		[gt.Const.Perks.PerkDefs.LegendFavouredEnemySpider],
		[],
		[],
		[],
		[]
	]
};

gt.Const.Perks.LindwurmTree <- {
	ID = "LindwurmTree",
	Descriptions = [
		"lindwurms"
	],
	Tree = [
		[],
		[],
		[],
		[],
		[],
		[gt.Const.Perks.PerkDefs.LegendFavouredEnemyLindwurm],
		[]
	]
};

gt.Const.Perks.MysticTree <- {
	ID = "MysticTree",
	Descriptions = [
		"mystics"
	],
	Tree = [
		[],
		[],
		[],
		[],
		[],
		[gt.Const.Perks.PerkDefs.LegendFavouredEnemySchrat],
		[
		gt.Const.Perks.PerkDefs.LegendFavouredEnemyHexen,
		gt.Const.Perks.PerkDefs.LegendFavouredEnemyAlps
		]
	]
};

gt.Const.Perks.SchratTree <- {
	ID = "SchratTree",
	Descriptions = [
		"schrats"
	],
	Tree = [
		[],
		[],
		[],
		[],
		[],
		[gt.Const.Perks.PerkDefs.LegendFavouredEnemySchrat],
		[]
	]
};

gt.Const.Perks.HexenTree <- {
	ID = "HexenTree",
	Descriptions = [
		"hexen"
	],
	Tree = [
		[],
		[],
		[],
		[],
		[],
		[],
		[gt.Const.Perks.PerkDefs.LegendFavouredEnemyHexen]
	]
};

gt.Const.Perks.AlpTree <- {
	ID = "AlpTree",
	Descriptions = [
		"alps"
	],
	Tree = [
		[],
		[],
		[],
		[],
		[],
		[],
		[gt.Const.Perks.PerkDefs.LegendFavouredEnemyAlps]
	]
};

gt.Const.Perks.UndeadTree <- {
	ID = "UndeadTree",
	Descriptions = [
		"undead"
	],
	Tree = [
		[],
		[],
		[],
		[],
		[
		gt.Const.Perks.PerkDefs.LegendFavouredEnemySkeleton,
		gt.Const.Perks.PerkDefs.LegendFavouredEnemyZombie
		],
		[],
		[gt.Const.Perks.PerkDefs.LegendFavouredEnemyVampire]
	]
};

gt.Const.Perks.SkeletonTree <- {
	ID = "SkeletonTree",
	Descriptions = [
		"skeletons"
	],
	Tree = [
		[],
		[],
		[],
		[],
		[gt.Const.Perks.PerkDefs.LegendFavouredEnemySkeleton],
		[],
		[]
	]
};

gt.Const.Perks.ZombieTree <- {
	ID = "ZombieTree",
	Descriptions = [
		"zombies"
	],
	Tree = [
		[],
		[],
		[],
		[],
		[gt.Const.Perks.PerkDefs.LegendFavouredEnemyZombie],
		[],
		[]
	]
};

gt.Const.Perks.VampireTree <- {
	ID = "VampireTree",
	Descriptions = [
		"vampires"
	],
	Tree = [
		[],
		[],
		[],
		[],
		[],
		[],
		[gt.Const.Perks.PerkDefs.LegendFavouredEnemyVampire]
	]
};

gt.Const.Perks.OrcsTree <- {
	ID = "OrcsTree",
	Descriptions = [
		"greenskins"
	],
	Tree = [
		[],
		[],
		[],
		[],
		[
		gt.Const.Perks.PerkDefs.LegendFavouredEnemyOrk,
		gt.Const.Perks.PerkDefs.LegendFavouredEnemyGoblin
		],
		[gt.Const.Perks.PerkDefs.LegendFavouredEnemyUnhold],
		[]
	]
};

gt.Const.Perks.OrcTree <- {
	ID = "OrcTree",
	Descriptions = [
		"orcs"
	],
	Tree = [
		[],
		[],
		[],
		[],
		[gt.Const.Perks.PerkDefs.LegendFavouredEnemyOrk],
		[],
		[]
	]
};

gt.Const.Perks.GoblinTree <- {
	ID = "GoblinTree",
	Descriptions = [
		"goblins"
	],
	Tree = [
		[],
		[],
		[],
		[],
		[gt.Const.Perks.PerkDefs.LegendFavouredEnemyGoblin],
		[],
		[]
	]
};

gt.Const.Perks.UnholdTree <- {
	ID = "UnholdTree",
	Descriptions = [
		"unholds"
	],
	Tree = [
		[],
		[],
		[],
		[],
		[],
		[gt.Const.Perks.PerkDefs.LegendFavouredEnemyUnhold],
		[]
	]
};

gt.Const.Perks.CivilizationTree <- {
	ID = "CivilizationTree",
	Descriptions = [
		"civilians"
	],
	Tree = [
		[],
		[],
		[gt.Const.Perks.PerkDefs.LegendFavouredEnemyCaravan],
		[],
		[gt.Const.Perks.PerkDefs.LegendFavouredEnemyMercenary],
		[gt.Const.Perks.PerkDefs.LegendFavouredEnemyNoble],
		[]
	]
};

gt.Const.Perks.CaravanTree <- {
	ID = "CaravanTree",
	Descriptions = [
		"caravans"
	],
	Tree = [
		[],
		[],
		[gt.Const.Perks.PerkDefs.LegendFavouredEnemyCaravan],
		[],
		[],
		[],
		[]
	]
};

gt.Const.Perks.MercenaryTree <- {
	ID = "MercenaryTree",
	Descriptions = [
		"mercenaries"
	],
	Tree = [
		[],
		[],
		[],
		[],
		[gt.Const.Perks.PerkDefs.LegendFavouredEnemyMercenary],
		[],
		[]
	]
};

gt.Const.Perks.NoblesTree <- {
	ID = "NoblesTree",
	Descriptions = [
		"nobles"
	],
	Tree = [
		[],
		[],
		[],
		[],
		[],
		[gt.Const.Perks.PerkDefs.LegendFavouredEnemyNoble],
		[]
	]
};

gt.Const.Perks.OutlandersTree <- {
	ID = "OutlandersTree",
	Descriptions = [
		"outlanders"
	],
	Tree = [
		[],
		[],
		[],
		[],
		[gt.Const.Perks.PerkDefs.LegendFavouredEnemyBandit],
		[gt.Const.Perks.PerkDefs.LegendFavouredEnemyBarbarian],
		[]
	]
};

gt.Const.Perks.BanditTree <- {
	ID = "BanditTree",
	Descriptions = [
		"bandits"
	],
	Tree = [
		[],
		[],
		[],
		[],
		[gt.Const.Perks.PerkDefs.LegendFavouredEnemyBandit],
		[],
		[]
	]
};

gt.Const.Perks.BarbarianTree <- {
	ID = "BarbariansTree",
	Descriptions = [
		"barbarians"
	],
	Tree = [
		[],
		[],
		[],
		[],
		[],
		[gt.Const.Perks.PerkDefs.LegendFavouredEnemyBarbarian],
		[]
	]
};

gt.Const.Perks.ArchersTree <- {
	ID = "ArchersTree",
	Descriptions = [
		"archers"
	],
	Tree = [
		[gt.Const.Perks.PerkDefs.Pathfinder],
		[],
		[],
		[],
		[gt.Const.Perks.PerkDefs.Footwork],
		[gt.Const.Perks.PerkDefs.LegendFavouredEnemyArcher],
		[]
	]
};

gt.Const.Perks.SwordmastersTree <- {
	ID = "SwordmastersTree",
	Descriptions = [
		"swordmasters"
	],
	Tree = [
		[],
		[],
		[gt.Const.Perks.PerkDefs.Steadfast],
		[],
		[gt.Const.Perks.PerkDefs.SunderingStrikes],
		[gt.Const.Perks.PerkDefs.LegendFavouredEnemySwordmaster],
		[]
	]
};

gt.Const.Perks.SouthernersTree <- {
	ID = "SouthernersTree",
	Descriptions = [
		"southerners"
	],
	Tree = [
		[gt.Const.Perks.PerkDefs.Pathfinder],
		[],
		[],
		[],
		[],
		[gt.Const.Perks.PerkDefs.LegendFavouredEnemySoutherner],
		[]
	]
};

gt.Const.Perks.EnemyTrees <- {
	Tree = [
		gt.Const.Perks.GhoulTree,
		gt.Const.Perks.DirewolfTree,
		gt.Const.Perks.SpiderTree,
		gt.Const.Perks.SchratTree,
		gt.Const.Perks.HexenTree,
		gt.Const.Perks.AlpTree,
		gt.Const.Perks.SkeletonTree,
		gt.Const.Perks.ZombieTree,
		gt.Const.Perks.VampireTree,
		gt.Const.Perks.OrcTree,
		gt.Const.Perks.GoblinTree,
		gt.Const.Perks.UnholdTree,
		gt.Const.Perks.CaravanTree,
		gt.Const.Perks.MercenaryTree,
		gt.Const.Perks.NoblesTree,
		gt.Const.Perks.BanditTree,
		gt.Const.Perks.BarbarianTree,
		gt.Const.Perks.ArchersTree,
		gt.Const.Perks.SwordmastersTree,
		gt.Const.Perks.SouthernersTree
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


	function getRandomPerk()
	{
		local tree = this.getRandom();
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