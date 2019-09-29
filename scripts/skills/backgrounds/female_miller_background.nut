this.female_miller_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.female_miller";
		this.m.Name = "Baker";
		this.m.Icon = "ui/backgrounds/baker.png";
		this.m.BackgroundDescription = "A baker is used to working the oven and grinding the grain.";
		this.m.GoodEnding = "%name% the once-baker stayed with the %companyname% for a time, collecting enough crowns to start her own bakery. Last you heard, her sword-shaped desserts have been a hit with the nobility and she makes more money selling to them than she ever did with the company.";
		this.m.BadEnding = "As the %companyname% fell on hard times, %name% the baker saw fit to go ahead and leave while she could still walk. She helped a nobleman test out a new way of grinding grains with mules and waterwheels working in tandem. Unfortunately, by \'helping\' she managed to fall into the contraption and was brutally crushed to death.";
		this.m.HiringCost = 65;
		this.m.DailyCost = 7;
		this.m.Excluded = [
			"trait.fear_undead",
			"trait.hate_undead",
			"trait.bright",
			"trait.cocky",
			"trait.quick",
			"trait.fragile",
			"trait.greedy",
			"trait.sure_footing",
			"trait.deathwish",
			"trait.dexterous",
			"trait.bloodthirsty"
		];
		this.m.Titles = [
			"the Baker"
		];
		this.m.Faces = this.Const.Faces.AllFemale;
		this.m.Hairs = this.Const.Hair.AllFemale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = null;
		this.m.BeardChance = 0;
		this.m.Body = "bust_naked_body_03";
		this.m.IsFemaleBackground = true;
		if ("Assets" in this.World && this.World.Assets.isLegendGenderEquality())
		{
			local r = this.Math.rand(0, 1);

			if (r == 0)
			{
				this.m.Faces = this.Const.Faces.AllMale;
				this.m.Hairs = this.Const.Hair.CommonMale;
				this.m.HairColors = this.Const.HairColors.All;
				this.m.Beards = this.Const.Beards.Untidy;
				this.m.Body = "bust_naked_body_00";
				this.m.IsFemaleBackground = false;
				this.m.GoodEnding = "%name% the once-baker stayed with the %companyname% for a time, collecting enough crowns to start his own bakery. Last you heard, his sword-shaped desserts have been a hit with the nobility and he makes more money selling to them than he ever did with the company.";
				this.m.BadEnding = "As the %companyname% fell on hard times, %name% the baker saw fit to go ahead and leave while he could still walk. He helped a nobleman test out a new way of grinding grains with mules and waterwheels working in tandem. Unfortunately, by \'helping\' he managed to fall into the contraption and was brutally crushed to death.";
			}
		}

		this.m.Modifiers.Stash = this.Const.LegendMod.ResourceModifiers.Stash[1];
		this.m.Modifiers.Gathering = this.Const.LegendMod.ResourceModifiers.Gather[1];
		this.m.PerkTreeDynamic = {
			Weapon = [
				this.Const.Perks.CleaverTree,
				this.Const.Perks.MaceTree,
				this.Const.Perks.FlailTree,
				this.Const.Perks.SlingsTree
			],
			Defense = [
				this.Const.Perks.LightArmorTree
			],
			Traits = [
				this.Const.Perks.OrganisedTree,
				this.Const.Perks.CalmTree,
				this.Const.Perks.LargeTree,
				this.Const.Perks.SturdyTree
			],
			Enemy = [],
			Class = [
				this.Const.Perks.ChefClassTree
			]
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
		return "{The life as a baker had always been lacking something for %name%, yet the hard work kept her from making any big plans. | Continuing the family tradition, %name% learned the bakers trade from her father. | Although just a simple miller, %name% always dreamed about wandering out into the world and bring home tales and pockets full of crowns. | Being a simple lass, %name% did not mind working hard in the bakery every day. | %name% always was more ambitious than other people. While her brother was content with running their family\'s bakery, she could not shake the feeling that she was destined for more.} {One night she was awoken by a loud thunderstorm. Rushing outside, %name% realised that her bakery had been ignited by a lightning strike. | When she caught her promised husband in bed with another woman, she was furious, battering both of them with a hail of blows. Her fists were bruised, people were shouting at her, but the only thing she felt was emptyness where once was her heart. As if in a dream she quickly packed her belongings and set out, never to return. | When her young and handsome husband was found dead, torn apart by wild beasts in the woods, she did not say a word. Silently she packed her belongings and set out into the world, to start a new life somewhere far away. | After hearing wild tales from a hedge knight in the tavern of %townname%, her imagination was running wild with all the possibilities out there in the world waiting for her. | A drought meant business was running slow for her. When %name% was not able to pay her debts any more her life was threatened by ruthless money collectors. She had to disappear.} {Remembering her cousin, %randomname%, who has made a decent living in the mercenary business, %name% decided to do the same. | While looking for opportunities she met a mercenary recruiter who promised her fame and fortune. | Although she does not know the next thing about fighting, %name% is eager to sign up with a mercenary company hooked by the promise of adventure. | Whether by lack of alternatives or by her free will, %name% stands before you now, ready to swear fealty.}";
	}

	function onChangeAttributes()
	{
		local c = {
			Hitpoints = [
				-1,
				-6
			],
			Bravery = [
				0,
				0
			],
			Stamina = [
				13,
				8
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
		};
		return c;
	}

	function onAddEquipment()
	{
		local items = this.getContainer().getActor().getItems();
		local r;
		r = this.Math.rand(0, 4);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/weapons/butchers_cleaver"));
		}
		else if (r == 1)
		{
			items.equip(this.new("scripts/items/weapons/legend_shovel"));
		}
		else if (r >= 2)
		{
			items.equip(this.new("scripts/items/weapons/wooden_stick"));
		}


		r = this.Math.rand(0, 4);

		if (r == 0 || r == 1)
		{
			items.equip(this.new("scripts/items/armor/legend_maid_apron"));
		}
		else if (r == 2)
		{
			items.equip(this.new("scripts/items/armor/legend_maid_dress"));
		}
		else
		{
			local item = this.new("scripts/items/armor/linen_tunic");
			item.setVariant(this.Math.rand(6, 7));
			items.equip(item);
		}
	}

});
