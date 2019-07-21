local gt = this.getroottable();

if (!("Perks" in gt.Const))
{
	gt.Const.Perks <- {};
}

gt.Const.Perks.AgileTree <- {
	ID = "AgileTree",
	Descriptions = [
		"is agile",
		"moves gracefully",
		"carries themself with ease",
		"is impressively agile",
		"has an athletic physique",
		"is spry as a fox",
		"is particularly dexterous"
	],
	Attributes = {
		Hitpoints = [
			0,
			0
		],
		Bravery = [
			0,
			0
		],
		Stamina = [
			0,
			0
		],
		MeleeSkill = [
			0,
			0
		],
		RangedSkill = [
			4,
			4
		],
		MeleeDefense = [
			0,
			0
		],
		RangedDefense = [
			0,
			0
		],
		Initiative = [
			2,
			2
		]
	},
	Tree = [
		[
			gt.Const.Perks.PerkDefs.Pathfinder
		],
		[],
		[
			gt.Const.Perks.PerkDefs.Sprint
		],
		[],
		[
			gt.Const.Perks.PerkDefs.Footwork
		],
		[],
		[]
	]
};
gt.Const.Perks.IndestructibleTree <- {
	ID = "IndestructibleTree",
	Descriptions = [
		"is practicaly indestructible",
		"is stubbornly relentless",
		"is staunchly perserverent",
		"has a strong will",
		"steadfastly persists",
		"seems unswervingly firm",
		"is adamantly resolute"
	],
	Attributes = {
		Hitpoints = [
			4,
			4
		],
		Bravery = [
			0,
			0
		],
		Stamina = [
			0,
			0
		],
		MeleeSkill = [
			0,
			0
		],
		RangedSkill = [
			0,
			0
		],
		MeleeDefense = [
			0,
			0
		],
		RangedDefense = [
			2,
			2
		],
		Initiative = [
			0,
			0
		]
	},
	Tree = [
		[
			gt.Const.Perks.PerkDefs.NineLives
		],
		[],
		[
			gt.Const.Perks.PerkDefs.HoldOut
		],
		[],
		[],
		[],
		[
			gt.Const.Perks.PerkDefs.Indomitable
		]
	]
};
gt.Const.Perks.MartyrTree <- {
	ID = "MartyrTree",
	Descriptions = [
		"has martyr complex",
		"strictly penatant ",
		"strives for attonement in harship",
		"sees their own torture as absolution",
		"seems to revel in self-suffering",
		"takes joy in feeling pain",
		"perversely enjoys to be tormented"
	],
	Attributes = {
		Hitpoints = [
			0,
			0
		],
		Bravery = [
			0,
			0
		],
		Stamina = [
			0,
			0
		],
		MeleeSkill = [
			0,
			0
		],
		RangedSkill = [
			0,
			0
		],
		MeleeDefense = [
			4,
			4
		],
		RangedDefense = [
			2,
			2
		],
		Initiative = [
			0,
			0
		]
	},
	Tree = [
		[],
		[],
		[],
		[],
		[
			gt.Const.Perks.PerkDefs.LoneWolf
		],
		[
			gt.Const.Perks.PerkDefs.Vengeance
		],
		[
			gt.Const.Perks.PerkDefs.LastStand
		]
	]
};
gt.Const.Perks.ViciousTree <- {
	ID = "ViciousTree",
	Descriptions = [
		"is vicious",
		"seems fiendishly barbarous",
		"is ferociously savage",
		"is brutally harsh",
		"appears diabolically fierce",
		"is beastially dangerous",
		"enjoys martial butchery"
	],
	Attributes = {
		Hitpoints = [
			0,
			0
		],
		Bravery = [
			0,
			0
		],
		Stamina = [
			0,
			0
		],
		MeleeSkill = [
			4,
			4
		],
		RangedSkill = [
			2,
			2
		],
		MeleeDefense = [
			0,
			0
		],
		RangedDefense = [
			0,
			0
		],
		Initiative = [
			0,
			0
		]
	},
	Tree = [
		[
			gt.Const.Perks.PerkDefs.CripplingStrikes
		],
		[],
		[
			gt.Const.Perks.PerkDefs.Debilitate
		],
		[],
		[
			gt.Const.Perks.PerkDefs.Berserk
		],
		[
			gt.Const.Perks.PerkDefs.LegendAssuredConquest
		],
		[]
	]
};
gt.Const.Perks.DeviousTree <- {
	ID = "DeviousTree",
	Descriptions = [
		"is devious",
		"strikes you as shifty",
		"has a shady appearance",
		"comes across as insincere",
		"is slyly sneaky",
		"responds evasively",
		"is shrewdly desceitful"
	],
	Attributes = {
		Hitpoints = [
			0,
			0
		],
		Bravery = [
			0,
			0
		],
		Stamina = [
			0,
			0
		],
		MeleeSkill = [
			0,
			0
		],
		RangedSkill = [
			2,
			2
		],
		MeleeDefense = [
			0,
			0
		],
		RangedDefense = [
			4,
			4
		],
		Initiative = [
			0,
			0
		]
	},
	Tree = [
		[],
		[],
		[
			gt.Const.Perks.PerkDefs.LegendTrueBeliever
		],
		[],
		[
			gt.Const.Perks.PerkDefs.LegendBlendIn
		],
		[
			gt.Const.Perks.PerkDefs.LegendHidden
		],
		[
			gt.Const.Perks.PerkDefs.LegendEvasion
		]
	]
};
gt.Const.Perks.InspirationalTree <- {
	ID = "InspirationalTree",
	Descriptions = [
		"is inspirational",
		"arouses loyalty in people",
		"galvanises trust in others",
		"emboldens people to action",
		"speaks with conviction",
		"gives impressive speeches",
		"instills motivation through words"
	],
	Attributes = {
		Hitpoints = [
			0,
			0
		],
		Bravery = [
			4,
			4
		],
		Stamina = [
			0,
			0
		],
		MeleeSkill = [
			2,
			2
		],
		RangedSkill = [
			0,
			0
		],
		MeleeDefense = [
			0,
			0
		],
		RangedDefense = [
			0,
			0
		],
		Initiative = [
			0,
			0
		]
	},
	Tree = [
		[],
		[
			gt.Const.Perks.PerkDefs.RallyTheTroops
		],
		[
			gt.Const.Perks.PerkDefs.Taunt
		],
		[],
		[],
		[
			gt.Const.Perks.PerkDefs.InspiringPresence
		],
		[
			gt.Const.Perks.PerkDefs.Inspire
		]
	]
};
gt.Const.Perks.IntelligentTree <- {
	ID = "IntelligentTree",
	Descriptions = [
		"is intelligent",
		"is strikingly astute",
		"has a creative imagination",
		"seems well informed",
		"appears knowledgeable of many things",
		"approaches problems rationally",
		"inventively resolves challenges"
	],
	Attributes = {
		Hitpoints = [
			0,
			0
		],
		Bravery = [
			4,
			4
		],
		Stamina = [
			0,
			0
		],
		MeleeSkill = [
			0,
			0
		],
		RangedSkill = [
			0,
			0
		],
		MeleeDefense = [
			0,
			0
		],
		RangedDefense = [
			2,
			2
		],
		Initiative = [
			0,
			0
		]
	},
	Tree = [
		[
			gt.Const.Perks.PerkDefs.Student
		],
		[
			gt.Const.Perks.PerkDefs.Gifted,
			gt.Const.Perks.PerkDefs.FortifiedMind
		],
		[],
		[],
		[],
		[
			gt.Const.Perks.PerkDefs.LegendMindOverBody
		],
		[]
	]
};
gt.Const.Perks.CalmTree <- {
	ID = "CalmTree",
	Descriptions = [
		"is calm",
		"is soothingly relaxed",
		"projects peace of mind",
		"seems unflustered",
		"goes with the flow",
		"is unworried"
	],
	Attributes = {
		Hitpoints = [
			0,
			0
		],
		Bravery = [
			2,
			2
		],
		Stamina = [
			0,
			0
		],
		MeleeSkill = [
			0,
			0
		],
		RangedSkill = [
			0,
			0
		],
		MeleeDefense = [
			0,
			0
		],
		RangedDefense = [
			0,
			0
		],
		Initiative = [
			4,
			4
		]
	},
	Tree = [
		[
			gt.Const.Perks.PerkDefs.LegendAlert
		],
		[],
		[],
		[],
		[
			gt.Const.Perks.PerkDefs.LegendClarity
		],
		[],
		[
			gt.Const.Perks.PerkDefs.PerfectFocus
		]
	]
};
gt.Const.Perks.FastTree <- {
	ID = "FastTree",
	Descriptions = [
		"is fast",
		"runs quickly",
		"is quick as a flash",
		"has fleet feet",
		"maneuverss rapidly",
		"steps briskly",
		"is a speedy sprinter"
	],
	Attributes = {
		Hitpoints = [
			0,
			0
		],
		Bravery = [
			0,
			0
		],
		Stamina = [
			0,
			0
		],
		MeleeSkill = [
			0,
			0
		],
		RangedSkill = [
			2,
			2
		],
		MeleeDefense = [
			0,
			0
		],
		RangedDefense = [
			0,
			0
		],
		Initiative = [
			4,
			4
		]
	},
	Tree = [
		[
			gt.Const.Perks.PerkDefs.FastAdaption,
			gt.Const.Perks.PerkDefs.Adrenalin
		],
		[
			gt.Const.Perks.PerkDefs.Anticipation
		],
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
		"is large",
		"has a hulking form",
		"has impressively broad shoulders",
		"is a hefty sort",
		"looms with immensity",
		"is a mountainous figure",
		"wields considerable musculature"
	],
	Attributes = {
		Hitpoints = [
			4,
			4
		],
		Bravery = [
			0,
			0
		],
		Stamina = [
			0,
			0
		],
		MeleeSkill = [
			2,
			2
		],
		RangedSkill = [
			0,
			0
		],
		MeleeDefense = [
			0,
			0
		],
		RangedDefense = [
			0,
			0
		],
		Initiative = [
			0,
			0
		]
	},
	Tree = [
		[
			gt.Const.Perks.PerkDefs.Colossus
		],
		[],
		[],
		[],
		[
			gt.Const.Perks.PerkDefs.LegendSecondWind
		],
		[],
		[
			gt.Const.Perks.PerkDefs.LegendMuscularity
		]
	]
};
gt.Const.Perks.OrganisedTree <- {
	ID = "OrganisedTree",
	Descriptions = [
		"is organized",
		"coordinates activities effectively",
		"formulates detailed plans",
		"tabulates company expenses",
		"already classified your inventory",
		"straightened out the supplies",
		"is fastidiously organised"
	],
	Attributes = {
		Hitpoints = [
			0,
			0
		],
		Bravery = [
			0,
			0
		],
		Stamina = [
			4,
			4
		],
		MeleeSkill = [
			0,
			0
		],
		RangedSkill = [
			0,
			0
		],
		MeleeDefense = [
			0,
			0
		],
		RangedDefense = [
			0,
			0
		],
		Initiative = [
			2,
			2
		]
	},
	Tree = [
		[
			gt.Const.Perks.PerkDefs.BagsAndBelts
		],
		[],
		[
			gt.Const.Perks.PerkDefs.LegendEfficientPacking
		],
		[],
		[
			gt.Const.Perks.PerkDefs.LegendSkillfulStacking
		],
		[],
		[]
	]
};
gt.Const.Perks.SturdyTree <- {
	ID = "SturdyTree",
	Descriptions = [
		"is sturdy",
		"is built to last",
		"has a rugged countenance",
		"is stouthearted",
		"is quite robust",
		"is well built",
		"seems hardy"
	],
	Attributes = {
		Hitpoints = [
			2,
			2
		],
		Bravery = [
			0,
			0
		],
		Stamina = [
			0,
			0
		],
		MeleeSkill = [
			0,
			0
		],
		RangedSkill = [
			0,
			0
		],
		MeleeDefense = [
			4,
			4
		],
		RangedDefense = [
			0,
			0
		],
		Initiative = [
			0,
			0
		]
	},
	Tree = [
		[],
		[
			gt.Const.Perks.PerkDefs.LegendComposure
		],
		[
			gt.Const.Perks.PerkDefs.Steadfast
		],
		[],
		[
			gt.Const.Perks.PerkDefs.Stalwart
		],
		[],
		[]
	]
};
gt.Const.Perks.FitTree <- {
	ID = "FitTree",
	Descriptions = [
		"can run all day",
		"lifts weight for hours",
		"barely breaks a sweat",
		"has extraordinary endurance",
		"has superb stamina",
		"rarely loses breath"
	],
	Attributes = {
		Hitpoints = [
			2,
			2
		],
		Bravery = [
			0,
			0
		],
		Stamina = [
			4,
			4
		],
		MeleeSkill = [
			0,
			0
		],
		RangedSkill = [
			5,
			5
		],
		MeleeDefense = [
			0,
			0
		],
		RangedDefense = [
			0,
			0
		],
		Initiative = [
			0,
			0
		]
	},
	Tree = [
		[
			gt.Const.Perks.PerkDefs.Recover
		],
		[],
		[
			gt.Const.Perks.PerkDefs.Relentless
		],
		[],
		[],
		[],
		[
			gt.Const.Perks.PerkDefs.Rebound
		]
	]
};
gt.Const.Perks.TrainedTree <- {
	ID = "TrainedTree",
	Descriptions = [
		"is well trained",
		"has great qualifications",
		"is well drilled",
		"is truly disciplined",
		"has practiced a great deal",
		"has been instructed by someone skillful",
		"has genuine experience"
	],
	Attributes =  {
		Hitpoints = [
			0,
			0
		],
		Bravery = [
			0,
			0
		],
		Stamina = [
			0,
			0
		],
		MeleeSkill = [
			4,
			4
		],
		RangedSkill = [
			0,
			0
		],
		MeleeDefense = [
			2,
			2
		],
		RangedDefense = [
			0,
			0
		],
		Initiative = [
			0,
			0
		]
	},
	Tree = [
		[
			gt.Const.Perks.PerkDefs.LegendBackToBasics
		],
		[],
		[
			gt.Const.Perks.PerkDefs.Rotation
		],
		[],
		[
			gt.Const.Perks.PerkDefs.Underdog
		],
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
	function getRandom( _exclude )
	{
		local L = [];

		foreach( i, t in this.Tree )
		{
			if (_exclude.find(t.ID))
			{
				continue;
			}

			L.push(i);
		}

		local r = this.Math.rand(0, L.len() - 1);
		return this.Tree[L[r]];
	}

	function getBaseAttributes()
	{
		return {
			Hitpoints = [
				-12,
				-12
			],
			Bravery = [
				-10,
				-10
			],
			Stamina = [
				-10,
				-10
			],
			MeleeSkill = [
				-12,
				-12
			],
			RangedSkill = [
				-10,
				-10
			],
			MeleeDefense = [
				-10,
				-10
			],
			RangedDefense = [
				-10,
				-10
			],
			Initiative = [
				-12,
				-12
			]
		};
	}

};
