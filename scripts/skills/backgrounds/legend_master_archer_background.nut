this.legend_master_archer_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.legend_master_archer";
		this.m.Name = "Master Archer";
		this.m.Icon = "ui/backgrounds/ranger_01.png";
		this.m.BackgroundDescription = "Master Archers have spent years honing their craft, in hunting, in sport, in war. ";
		this.m.GoodEnding = "While the %companyname% continued on with great success, %name% the hunter eventually saw fit to leave it all behind. They returned to the life of an archer, working for who ever paid the best. %name% rarely showed the grim reality of hunting humans, but you have to imagine they\'d just rather stop doing it. As far as you know, %name% is doing well these days. The archer purchased a bit of land and helps guide nobles on pricy hunting trips.";
		this.m.BadEnding = "With the decline of the %companyname% readily obvious, %name% the master archer departed from the company and returned to archery contests. Unfortunately, a shoot off went awry while shooting apples off each other\'s heads. The master archer was the better shot, but being better does not help if you\'re dead.";
		this.m.HiringCost = 8000;
		this.m.DailyCost = 120;
		this.m.Excluded = [
			"trait.weasel",
			"trait.fear_undead",
			"trait.fear_beasts",
			"trait.hate_beasts",
			"trait.night_blind",
			"trait.clubfooted",
			"trait.brute",
			"trait.short_sighted",
			"trait.fat",
			"trait.clumsy",
			"trait.gluttonous",
			"trait.asthmatic",
			"trait.craven",
			"trait.dastard",
			"trait.drunkard"
		];
		this.m.Titles = [
			"Target Finder",
			"the Accurate",
			"the Archer",
			"Arrowsplitter",
			"True-Shot",
			"One Shot",
			"Eagle Eye"
		];
		this.m.Faces = this.Const.Faces.AllMale;
		this.m.Hairs = this.Const.Hair.UntidyMale;
		this.m.HairColors = this.Const.HairColors.Young;
		this.m.Beards = this.Const.Beards.Untidy;

		this.m.Level = this.Math.rand(1, 4);
		this.m.IsUntalented = true;
		this.m.IsCombatBackground = true;
		this.m.IsRangerRecruitBackground = true;
		this.m.AlignmentMin = this.Const.LegendMod.Alignment.Cruel;
		this.m.AlignmentMax = this.Const.LegendMod.Alignment.Chivalrous;
		this.m.Modifiers.Ammo = this.Const.LegendMod.ResourceModifiers.Ammo[3];
		this.m.Modifiers.Hunting = this.Const.LegendMod.ResourceModifiers.Hunting[3];
		this.m.Modifiers.Fletching = this.Const.LegendMod.ResourceModifiers.Fletching[3];
		this.m.Modifiers.Scout = this.Const.LegendMod.ResourceModifiers.Scout[3];
		this.m.Modifiers.Terrain = [
				0.0, // ?
				0.0, //ocean
				0.0,//plains
				0.0, //swamp
				0.0, //hills
				0.25, //forest
				0.25, //forest
				0.25, //forest_leaves
				0.25, //autumn_forest
				0.0, //mountains
				0.0, // ?
				0.0, //farmland
				0.01, // snow
				0.01, // badlands
				0.01, //highlands
				0.0, //stepps
				0.0, //ocean
				0.0, //desert
				0.0 //oasis
			];
		this.m.PerkTreeDynamic = {
			Weapon = [
				this.Const.Perks.BowTree,
				this.Const.Perks.CrossbowTree,
				this.Const.Perks.SwordTree,
				this.Const.Perks.ThrowingTree
			],
			Defense = [
				this.Const.Perks.LightArmorTree
			],
			Traits = [
				this.Const.Perks.AgileTree,
				this.Const.Perks.FastTree,
				this.Const.Perks.ViciousTree,
				this.Const.Perks.FitTree,
				this.Const.Perks.DeviousTree
			],
			Enemy = [],
			Class = [],
			Magic = [this.Const.Perks.RangerHuntMagicTree]
		}
	}

	function getTooltip()
	{
		return [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			}
		];
	}

	function onBuildDescription()
	{
		return "{Without a father around, %name%\'s mother taught the child how to shoot a bow, and how to feed the rest of the family. | Born in the hinterlands of %randomtown%, %name% has spent life stalking the beasts amongst the trees. | %name% once took a bet to shoot an apple off a pig\'s head, and missed. With a belly full of bacon, the archer became determined to never miss again - unless it meant more bacon, of course. | Early in life, %name% liked to traipse about the forests. When a rabid fox attacked, %name% learned to take a bow. When a devilish eagle clawed the archer\'s face, %name% learned to shoot it.} {Once employed by local royalty, a disastrous boar hunt ended with a gored baron and all the blame - and blood - on %name%\'s hands. | The hunter hid the thought well, but for the longest time wondered what it would be like to hunt the ultimate game: man. | Sadly, a bad game of peasant-roulette forced the deer hunter into seeking other means of income. | Unfortunately, not nearly as good at cooking deer as shooting them. A dinner consisting of undercooked meats poisoned the archer\'s entire family. Desperation for a new life is understandable. | After an arduous trip to town to sell meats and leathers, %name% followed the call of mercenary work. | War drove the game out of the forests, and the hunt out of %name%. Now %name% seeks another line of work. | When %name%\'s partner fell ill, the archer could not heal with hunted meat. Needing to earn crowns to pay for treatment, %name% took up the vocation of sellswords - or sellbows, as it were.} {Any outfit could use a deadeye such as this. | Not entirely without faults, %name% is a professional bowman nonetheless. | A quick demonstration is offered: %name% shoots one arrow high into the sky, and with another he knocks it out. Impressive. | %name% has something to prove - just make sure it is done at range. When first given a sword, %name% grabbed it at the wrong end. Yes, that end. | The hunter wields a bow like another limb, and shoots arrows like a preacher does words.}";
	}

	function onChangeAttributes()
	{
		local c = {
			Hitpoints = [
				0,
				0
			],
			Bravery = [
				0,
				5
			],
			Stamina = [
				7,
				5
			],
			MeleeSkill = [
				0,
				0
			],
			RangedSkill = [
				25,
				22
			],
			MeleeDefense = [
				0,
				0
			],
			RangedDefense = [
				5,
				8
			],
			Initiative = [
				0,
				5
			]
		};
		return c;
	}

	function onAddEquipment()
	{
		local talents = this.getContainer().getActor().getTalents();
		talents.resize(this.Const.Attributes.COUNT, 0);
		talents[this.Const.Attributes.RangedSkill] = 3;
		talents[this.Const.Attributes.Fatigue] = 3;
		this.getContainer().getActor().fillTalentValues(2, true);
		local items = this.getContainer().getActor().getItems();
		local r;
		items.equip(this.new("scripts/items/weapons/war_bow"));
		items.equip(this.new("scripts/items/ammo/huge_quiver_of_arrows"));
		r = this.Math.rand(0, 1);

		if (r == 0)
		{
			items.addToBag(this.new("scripts/items/weapons/knife"));
		}

		items.equip(this.Const.World.Common.pickArmor([
			[1, "padded_surcoat"],
			[1, "thick_tunic"],
			[1, "leather_tunic"]
		]));

		items.equip(this.Const.World.Common.pickHelmet([
			[1, "hood"],
			[1, "hunters_hat"]
		]));

	}

});

