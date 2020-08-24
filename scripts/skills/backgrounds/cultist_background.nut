this.cultist_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.cultist";
		this.m.Name = "Cultist";
		this.m.Icon = "ui/backgrounds/background_34.png";
		this.m.BackgroundDescription = "Cultists have a resolve to spread further their cult that is second to few.";
		this.m.GoodEnding = "The cultist, %name%, left the company with a band of cloaked converts. You know not what became of the fanatic, but every so often they appear in your dreams. Often standing alone in a great void and there is always someone, or something, lingering in the black beyond. Every night, this image gets a little more clear, and each night you find yourself staying up later and later just to avoid dreaming at all.";
		this.m.BadEnding = "You heard that %name%, the cultist, left the company at some juncture and went out to spread the faith. There\'s no telling what became of the fanatic, but there was a recent inquisition against unholy faiths and hundreds of \'folk in dark cloaks with even darker intentions\' were burned at the stake across the realm.";
		this.m.HiringCost = 50;
		this.m.DailyCost = 6;
		this.m.Excluded = [
			"trait.teamplayer",
			"trait.fear_undead",
			"trait.hate_beasts",
			"trait.hate_undead",
			"trait.hate_greenskins",
			"trait.night_blind",
			"trait.lucky",
			"trait.athletic",
			"trait.bright",
			"trait.drunkard",
			"trait.dastard",
			"trait.gluttonous",
			"trait.insecure",
			"trait.disloyal",
			"trait.hesitant",
			"trait.fat",
			"trait.bright",
			"trait.greedy",
			"trait.craven",
			"trait.fainthearted"
		];
		this.m.Titles = [
			"the Cultist",
			"the Mad",
			"the Believer",
			"the Occultist",
			"the Insane",
			"the Follower",
			"the Lost",
			"the Odd",
			"the Misguided",
			"the Fanatic",
			"the Zealot"
		];

		this.m.Faces = this.Const.Faces.AllMale;
		this.m.Hairs = this.Const.Hair.UntidyMale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = this.Const.Beards.Untidy;

		this.m.Bodies = this.Const.Bodies.Skinny;
		this.m.AlignmentMin = this.Const.LegendMod.Alignment.Dreaded;
		this.m.AlignmentMax = this.Const.LegendMod.Alignment.Merciless;
		this.m.IsOutlawBackground = true;
		this.m.AlignmentMin = this.Const.LegendMod.Alignment.Dreaded;
		this.m.AlignmentMax = this.Const.LegendMod.Alignment.Merciless;
		this.m.Modifiers.Injury = this.Const.LegendMod.ResourceModifiers.Injury[2];
		this.m.Modifiers.Meds = this.Const.LegendMod.ResourceModifiers.Meds[1];
		this.m.Modifiers.MedConsumption = this.Const.LegendMod.ResourceModifiers.MedConsumption[1];
		this.m.PerkTreeDynamic = {
			Weapon = [
				this.Const.Perks.CleaverTree,
				this.Const.Perks.FlailTree,
				this.Const.Perks.SlingsTree
			],
			Defense = [
				this.Const.Perks.MediumArmorTree
			],
			Traits = [
				this.Const.Perks.MartyrTree,
				this.Const.Perks.ViciousTree,
				this.Const.Perks.FastTree,
				this.Const.Perks.IndestructibleTree
			],
			Enemy = [],
			Class = [this.Const.Perks.NinetailsClassTree],
			Magic = []
		}
	}

	//Default Male
	function setGender(_gender = -1)
	{
		local r = _gender;
		if (_gender == -1)
		{
			r = this.Math.rand(0, 9);
			if (this.World.LegendsMod.Configs().LegendGenderEnabled())
			{
				r = this.Math.rand(0, 1);
			}
		}

		if (r != 1)
		{
			return;
		}

		this.m.Faces = this.Const.Faces.OldFemale;
		this.m.Hairs = this.Const.Hair.AllFemale;
		this.m.HairColors = this.Const.HairColors.Old;
		this.m.Beards = null;
		this.m.BeardChance = 0;
		this.m.Bodies = this.Const.Bodies.AllFemale;
		this.m.IsFemaleBackground = true;

	}

	// Should overwrite the "character_backgrounds" isCultist() check
	function isCultist()
	{
		return true;
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
		return "{The cultist stands with a placard hanging from their neck. | Their face is wreathed in garish tattoos. They carry a note. | The face is hidden inside a deep cowl, an islanded tip of a nose all that you see in the darkness. They carry a placard around their neck. | Clothed in rags, it is strange they neither sweat nor shake in heat or cold. Clutching a scroll as if it protects from the very elements. | Scripture is written across their arm in scars, the coda of madness. | The stranger writes in the dirt as quick as someone who has done it a thousand times. The message is clear to see. | They stand with a tome nestled behind a crooked arm. They hand it to you. Opening it, the leather feels like none you\'ve ever touched before. There is only one passage inside, written over and over.} It reads: \"Ph\'nglui mglw\'nafh Davkul R\'lyeh wgah\'nagl fhtagn. Nn\'nilgh\'ri, nn\'nglui. Sgn\'wahl sll\'ha ep\'shogg.\" Hmm... quaint.";
	}

	function onChangeAttributes()
	{
		local c = {
			Hitpoints = [
				-10,
				10
			],
			Bravery = [
				20,
				10
			],
			Stamina = [
				-2,
				8
			],
			MeleeSkill = [
				-5,
				5
			],
			RangedSkill = [
				-5,
				5
			],
			MeleeDefense = [
				-5,
				5
			],
			RangedDefense = [
				-5,
				5
			],
			Initiative = [
				-5,
				5
			]
		};
		return c;
	}

	function onSetAppearance()
	{
		if (this.m.IsFemaleBackground == false)
		{
			local actor = this.getContainer().getActor();
			local tattoo_body = actor.getSprite("tattoo_body");
			local tattoo_head = actor.getSprite("tattoo_head");

			if (this.Math.rand(1, 100) <= 50)
			{
				local body = actor.getSprite("body");
				tattoo_body.setBrush("tattoo_01_" + body.getBrush().Name);
				tattoo_body.Visible = true;
			}

			if (this.Math.rand(1, 100) <= 50)
			{
				tattoo_head.setBrush("tattoo_head_01");
				tattoo_head.Visible = true;
			}
		}
	}

	function updateAppearance()
	{
		if (this.m.IsFemaleBackground == false)
		{
			local actor = this.getContainer().getActor();
			local tattoo_body = actor.getSprite("tattoo_body");

			if (tattoo_body.HasBrush)
			{
				local body = actor.getSprite("body");
				tattoo_body.setBrush("tattoo_01_" + body.getBrush().Name);
			}
		}
	}

	function onAddEquipment()
	{
		local items = this.getContainer().getActor().getItems();
		local r;
		r = this.Math.rand(0, 8);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/weapons/legend_scythe"));
		}
		else if (r == 1)
		{
			items.equip(this.new("scripts/items/weapons/wooden_flail"));
		}
		else if (r == 2)
		{
			items.equip(this.new("scripts/items/weapons/legend_cat_o_nine_tails"));
		}
		else if (r == 3)
		{
			items.equip(this.new("scripts/items/weapons/legend_chain"));
		}
		else if (r == 4)
		{
			if (this.Const.DLC.Wildmen)
			{
				items.equip(this.new("scripts/items/weapons/battle_whip"));
			}
			else if (!this.Const.DLC.Wildmen)
			{
				items.equip(this.new("scripts/items/weapons/legend_cat_o_nine_tails"));
			}
		}
		else if (r >= 5)
		{
		 items.equip(this.new("scripts/items/weapons/legend_cat_o_nine_tails"));
		}

		items.equip(this.Const.World.Common.pickArmor([
			[1, "tattered_sackcloth"],
			[1, "leather_wraps"],
			[1, "monk_robe"],
			[1, "cultist_leather_robe"]
		]));	
		items.equip(this.Const.World.Common.pickHelmet([
			[1, "cultist_hood"],
			[1, "hood"],
			[1, "cultist_leather_hood"]
		]));
	}
});

