if (!("Perks" in ::Const))
{
	::Const.Perks <- {};
}

::Const.Perks.ShadyTree <- {
	ID = "ShadyTree",
	Name =  "Shady",
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
			::Const.Perks.PerkDefs.LegendFeint
		],
		[
			::Const.Perks.PerkDefs.Backstabber,
			::Const.Perks.PerkDefs.CoupDeGrace
		],
		[],
		[],
		[],
		[],
		[]
	]
};
::Const.Perks.AggressiveTree <- {
	ID = "AggressiveTree",
	Name =  "Aggressive",
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
		[],
		[],
		[],
		[],
		[
			::Const.Perks.PerkDefs.Berserk
		],
		[
			::Const.Perks.PerkDefs.KillingFrenzy,
			::Const.Perks.PerkDefs.Fearsome
		]
	]
};
::Const.Perks.SparringTree <- {
	ID = "SparringTree",
	Name =  "Sparring",
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
			::Const.Perks.PerkDefs.LegendBackToBasics
		],
		[
			::Const.Perks.PerkDefs.Rotation,
			::Const.Perks.PerkDefs.Anticipation
        ],
		[],
		[],
		[],
		[],
		[]
	]
};
::Const.Perks.RangerTree <- {
	ID = "RangerTree",
	Name =  "Ranger",
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
			::Const.Perks.PerkDefs.LegendLookout,
            ::Const.Perks.PerkDefs.Pathfinder
		],
		[
			::Const.Perks.PerkDefs.Anticipation
        ],
		[],
		[],
		[],
		[
			::Const.Perks.PerkDefs.LegendBallistics
		],
		[]
	]
};
::Const.Perks.GiantTree <- {
	ID = "GiantTree",
	Name =  "Giant",
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
			::Const.Perks.PerkDefs.Colossus
		],
		[
			::Const.Perks.PerkDefs.HoldOut
        ],
		[],
		[],
		[],
		[],
		[
            ::Const.Perks.PerkDefs.LegendMuscularity,
            ::Const.Perks.PerkDefs.Indomitable
        ]
	]
};
