this.legend_druid_commander_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {
		Tattoo = 0
	},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.legend_commander_druid";
		this.m.Name = "Druid Commander";
		this.m.Icon = "ui/backgrounds/druid_background.png";
		this.m.BackgroundDescription = "Druids are from the wild lands, defenders of nature.";
		// this.m.GoodEnding = "While the %companyname% visited a town for rest and recuperation, a local princess took a shine to %name% the wildman. He was \'purchased\' for a large sum of gold and given to the noblewoman. You went and visited the man recently. For dinner, he sat at a kingly table, grinning goofily and mimicking the nobles around him as best he could. His new and inexplicable wife adored him, and him her. When you said your goodbyes, he offered you a heavy golden crown off the top of his head. It weighed heavy with traditions and ancient histories. You said it\'d be best if he kept it. The wildman shrugged and walked off, spinning the circlet around a finger.";
		// this.m.BadEnding = "%name% the wildman stayed with the fragmenting %companyname% for a time and then, just like that, he was gone. The company went out looking for him in a forest, eventually finding some sort of crude note: an enormous pile of crowns next to a dirt-drawing of the %companyname% and some of its members, all of them being hugged by a big, literal stick figure with a goofy smile on its face. There was also an offering of a dead, half-eaten rabbit.";
		this.m.HiringCost = 10000;
		this.m.DailyCost = 0;
		this.m.Excluded = [
			"trait.weasel",
			"trait.teamplayer",
			"trait.fear_beasts",
			"trait.hate_undead",
			"trait.paranoid",
			"trait.night_blind",
			"trait.ailing",
			"trait.clubfooted",
			"trait.fat",
			"trait.tiny",
			"trait.gluttonous",
			"trait.pessimist",
			"trait.optimist",
			"trait.short_sighted",
			"trait.dexterous",
			"trait.insecure",
			"trait.hesitant",
			"trait.asthmatic",
			"trait.greedy",
			"trait.fragile",
			"trait.fainthearted",
			"trait.craven",
			"trait.bleeder",
			"trait.bright",
			"trait.cocky",
			"trait.dastard",
			"trait.drunkard",
			"trait.disloyal",
			"trait.loyal"
		];
		this.m.Titles = [
			"the Savage",
			"the Outcast",
			"the Wildman",
			"the Feral",
			"the Wild",
			"the Barbarian",
			"The Green thumb",
			"Oakheart",
			"Treebeard",
			"The flower",
			"The Pollenator",
			"Nature's Wrath",
			"The Bear",
			"The Wolf",
			"The Sapling"
		];
		this.m.Faces = this.Const.Faces.AllWhiteMale;
		this.m.Hairs = this.Const.Hair.UntidyMale;
		this.m.HairColors = this.Const.HairColors.Young;
		this.m.Beards = this.Const.Beards.Untidy;
		this.m.BeardChance = 100;
		this.m.Bodies = this.Const.Bodies.LegendTattos;
		this.m.Ethnicity = 2;
		this.m.Level = 3;
		this.m.IsCombatBackground = true;
		this.m.IsLowborn = true;
		this.m.IsUntalented = true;
		this.m.AlignmentMin = this.Const.LegendMod.Alignment.Merciless;
		this.m.AlignmentMax = this.Const.LegendMod.Alignment.Good;
		this.m.Modifiers.Stash = this.Const.LegendMod.ResourceModifiers.Stash[2];
		this.m.Modifiers.Hunting = this.Const.LegendMod.ResourceModifiers.Hunting[2];
		this.m.Modifiers.Scout = this.Const.LegendMod.ResourceModifiers.Scout[3];
		this.m.Modifiers.Gathering = this.Const.LegendMod.ResourceModifiers.Gather[3];
		this.m.Modifiers.Terrain = [
			0.0, // ?
			0.0, //ocean
			0.0,//plains
			0.05, //swamp
			0.05, //hills
			0.1, //forest
			0.1, //forest
			0.1, //forest_leaves
			0.0, //autumn_forest
			0.05, //mountains
			0.0, // ?
			0.0, //farmland
			0.05, // snow
			0.05, // badlands
			0.05, //highlands
			0.05, //stepps
			0.0, //ocean
			0.0, //desert
			0.0 //oasis
		];
			this.m.CustomPerkTree = [
			[
				this.Const.Perks.PerkDefs.LegendMedIngredients,
				this.Const.Perks.PerkDefs.LegendWither,
				this.Const.Perks.PerkDefs.LegendUnarmedTraining,
				this.Const.Perks.PerkDefs.LegendSpecStaffSkill,
				this.Const.Perks.PerkDefs.LegendSpecialistSickleSkill,
				this.Const.Perks.PerkDefs.Student,
				this.Const.Perks.PerkDefs.Colossus,
				this.Const.Perks.PerkDefs.NineLives,
				this.Const.Perks.PerkDefs.Pathfinder,
				this.Const.Perks.PerkDefs.Recover,
				this.Const.Perks.PerkDefs.LegendAlert
			],
			[
				this.Const.Perks.PerkDefs.LegendScryTrance,
				this.Const.Perks.PerkDefs.LegendGatherer,
				this.Const.Perks.PerkDefs.LegendKick,
				this.Const.Perks.PerkDefs.FortifiedMind,
				this.Const.Perks.PerkDefs.CoupDeGrace,
				this.Const.Perks.PerkDefs.Dodge,
				this.Const.Perks.PerkDefs.HoldOut,
				this.Const.Perks.PerkDefs.LegendComposure,
				this.Const.Perks.PerkDefs.QuickHands,
				this.Const.Perks.PerkDefs.LegendSmackdown,
				this.Const.Perks.PerkDefs.LegendOnslaught
			],
			[
				this.Const.Perks.PerkDefs.LegendRoots,
				this.Const.Perks.PerkDefs.LegendHerbcraft,
				this.Const.Perks.PerkDefs.LegendPrayerOfLife,
				this.Const.Perks.PerkDefs.LegendGrapple,
				this.Const.Perks.PerkDefs.LegendSpecialistSickleDamage,
				this.Const.Perks.PerkDefs.LegendSpecStaffStun,
				this.Const.Perks.PerkDefs.Rotation,
				this.Const.Perks.PerkDefs.Taunt,
				this.Const.Perks.PerkDefs.Feint,
				this.Const.Perks.PerkDefs.Relentless,
				this.Const.Perks.PerkDefs.LegendSecondWind
			],
			[
				this.Const.Perks.PerkDefs.LegendPoisonImmunity,
				this.Const.Perks.PerkDefs.LegendSpecBandage,
				this.Const.Perks.PerkDefs.LegendSpecPoison,
				this.Const.Perks.PerkDefs.LegendSummonWolf,
				this.Const.Perks.PerkDefs.LegendSpecFists,
				this.Const.Perks.PerkDefs.SpecSword,
				this.Const.Perks.PerkDefs.SpecThrowing,
				this.Const.Perks.PerkDefs.LegendMasteryStaves,
				this.Const.Perks.PerkDefs.LegendFavouredEnemyGoblin,
				this.Const.Perks.PerkDefs.LegendFavouredEnemyBandit
			],
			[
				this.Const.Perks.PerkDefs.LegendPotionBrewer,
				this.Const.Perks.PerkDefs.LegendChoke,
				this.Const.Perks.PerkDefs.LegendReadOmensTrance,
				this.Const.Perks.PerkDefs.LegendInsects,
				this.Const.Perks.PerkDefs.LoneWolf,
				this.Const.Perks.PerkDefs.Footwork,
				this.Const.Perks.PerkDefs.Vengeance,
				this.Const.Perks.PerkDefs.LegendBattleheart,
				this.Const.Perks.PerkDefs.LegendFavouredEnemyOrk,
				this.Const.Perks.PerkDefs.LegendFavouredEnemyNoble
			],
			[
				this.Const.Perks.PerkDefs.LegendDrumsOfLife,
				this.Const.Perks.PerkDefs.LegendDistantVisions,
				this.Const.Perks.PerkDefs.LegendUnarmedLunge,
				this.Const.Perks.PerkDefs.LegendMuscularity,
				this.Const.Perks.PerkDefs.LegendSummonStorm,
				this.Const.Perks.PerkDefs.LegendClarity,
				this.Const.Perks.PerkDefs.Berserk,
				this.Const.Perks.PerkDefs.Nimble,
				this.Const.Perks.PerkDefs.LegendMindOverBody,
				this.Const.Perks.PerkDefs.LastStand,
				this.Const.Perks.PerkDefs.Rebound
			],
			[
				this.Const.Perks.PerkDefs.LegendMiasma,
				this.Const.Perks.PerkDefs.LegendFieldTriage,
				this.Const.Perks.PerkDefs.LegendTumble,
				this.Const.Perks.PerkDefs.LegendSummonBear,
				this.Const.Perks.PerkDefs.Fearsome,
				this.Const.Perks.PerkDefs.Duelist,
				this.Const.Perks.PerkDefs.KillingFrenzy,
				this.Const.Perks.PerkDefs.BattleFlow,
				this.Const.Perks.PerkDefs.Stalwart,
				this.Const.Perks.PerkDefs.LegendFreedomOfMovement

			]
		];


	}

	//Default Male
	function setGender(_gender = -1)
	{
		local r = _gender;
		if (_gender == -1)
		{
			r = this.Math.rand(0, 9);
			if (this.LegendsMod.Configs().LegendGenderEnabled())
			{
				r = this.Math.rand(0, 1);
			}
		}

		if (r != 1)
		{
			return;
		}
		this.m.Faces = this.Const.Faces.PrettyFemale;
		this.m.Hairs = this.Const.Hair.AllFemale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = null;
		this.m.BeardChance = 0;
		this.m.Bodies = this.Const.Bodies.AllFemale;
		this.m.IsFemaleBackground = true;
	}

	function getTooltip()
	{
		local ret = this.character_background.getTooltip()
		ret.push(
			{
				id = 12,
				type = "text",
				icon = "ui/icons/regular_damage.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+25%[/color] Damage when unarmed"
			}
		)
		return ret
	}

	function onBuildDescription()
	{
		if(this.m.IsFemaleBackground == true)
		{
			return "{For some, the wild is a refuge. | It is said that woman is born with the wilderness in her, and that she does wrong by turning her back on it. | Civilization is a stain, one prolonged arming of every next-generation to better battle the ultimate enemy: Mother Nature herself. | In a time of war, it\'s not surprising that many once again seek refuge in the wild. | Some people flee from town to town. Others stop in between, disappearing into the tranquil forests.} {%name% once found a safe register amongst the trees, but that time is over. | Once a mysterious figure to hunters - the famed masskewatsthat - %name% now returns to civilization for reasons unknown. | %name%\'s got the hands of a blacksmith, but the hygiene of a pigsty. | Maybe it was spurned love, or maybe just war, but %name% has spent the last decade far from the rest of mankind. | Possibly a poacher who settled where she hunted, %name%\'s lived amongst the trees for untold years. | With cleverly stitched garb, %name%\'s atavistic appearance perhaps belies a past as a tailor or tanner.} {There is an obvious language barrier with the druid, but for some reason she seems very willing to fight. Let\'s hope his newfound \'calling\' doesn\'t have a darker purpose behind it. | Colorful and permanent ritual rites circle about her body. When asked why she wishes to join a band of mercenaries, she hoots and, with a crooked finger, replicates one of her fleshen arts across the sky. | Wounds, old and fresh, dot her already mottled body. And they are not superficial - this woman had been fighting something fierce in the wild. | One has to wonder if the calamities which chased her into the forests have come to chase her back out. | Judging by her wild grunting, it\'s doubtful she\'s here to rejoin civilization. | Years as a recluse haven\'t made the woman forget what a few crowns can get you. The question is, why did she come back? | She has the strength to wrestle a boar - and her many scars makes you wonder if perhaps she did.}";
		}
		else
		{
			return "{For some, the wild is a refuge. | It is said that man is born with the wilderness in him, and that he does wrong by turning his back on it. | Civilization is a stain, one prolonged arming of every next-generation to better battle the ultimate enemy: Mother Nature herself. | In a time of war, it\'s not surprising that many once again seek refuge in the wild. | Some people flee from town to town. Others stop in between, disappearing into the tranquil forests.} {%name% once found a safe register amongst the trees, but that time is over. | Once a mysterious figure to hunters - the famed masskewatsthat - %name% now returns to civilization for reasons unknown. | %name%\'s got the hands of a blacksmith, but the hygiene of a pigsty. | Maybe it was spurned love, or maybe just war, but %name% has spent the last decade far from the rest of mankind. | Possibly a poacher who settled where he hunted, %name%\'s lived amongst the trees for untold years. | With cleverly stitched garb, %name%\'s atavistic appearance perhaps belies a past as a tailor or tanner.} {There is an obvious language barrier with the druid, but for some reason he seems very willing to fight. Let\'s hope his newfound \'calling\' doesn\'t have a darker purpose behind it. | Colorful and permanent ritual rites circle about his body. When asked why he wishes to join a band of mercenaries, he hoots and, with a crooked finger, replicates one of his fleshen arts across the sky. | Wounds, old and fresh, dot his already mottled body. And they are not superficial - this man had been fighting something fierce in the wild. | One has to wonder if the calamities which chased him into the forests have come to chase him back out. | Judging by his wild grunting, it\'s doubtful he\'s here to rejoin civilization. | Years as a recluse haven\'t made the man forget what a few crowns can get you. The question is, why did he come back? | He has the strength to wrestle a boar - and his many scars makes you wonder if perhaps he did.}";
		}


	}

	function onChangeAttributes()
	{
		local c = {
			Hitpoints = [
				10,
				25
			],
			Bravery = [
				-5,
				5
			],
			Stamina = [
				5,
				10
			],
			MeleeSkill = [
				5,
				10
			],
			RangedSkill = [
				-10,
				0
			],
			MeleeDefense = [
				5,
				15
			],
			RangedDefense = [
				-5,
				5
			],
			Initiative = [
				-5,
				-10
			]
		};
		return c;
	}

	function onSetAppearance()
	{
		local actor = this.getContainer().getActor();
		local dirt = actor.getSprite("dirt");
		dirt.Visible = true;
		this.m.Tattoo = this.Math.rand(0, 1);
		local tattoo_body = actor.getSprite("tattoo_body");
		local tattoo_head = actor.getSprite("tattoo_head");
		local body = actor.getSprite("body");
		tattoo_body.setBrush((this.m.Tattoo == 0 ? "warpaint_01_" : "scar_02_") + body.getBrush().Name);
		tattoo_body.Visible = true;
		tattoo_head.setBrush(this.m.Tattoo == 0 ? "warpaint_01_head" : "scar_02_head");
		tattoo_head.Visible = true;
	}

	function updateAppearance()
	{
		local actor = this.getContainer().getActor();
		local tattoo_body = actor.getSprite("tattoo_body");

		if (tattoo_body.HasBrush)
		{
			local body = actor.getSprite("body");
			tattoo_body.setBrush((this.m.Tattoo == 0 ? "warpaint_01_" : "scar_02_") + body.getBrush().Name);
		}
	}

	function onAdded()
	{
		this.character_background.onAdded();
		local actor = this.getContainer().getActor();
		actor.setTitle("The Druid");
		this.m.Container.add(this.new("scripts/skills/traits/tough_trait"));
	}

	function onAddEquipment()
	{
		local talents = this.getContainer().getActor().getTalents();
		talents.resize(this.Const.Attributes.COUNT, 0);
		talents[this.Const.Attributes.MeleeSkill] = 3;
		talents[this.Const.Attributes.Hitpoints] = 3;
		this.getContainer().getActor().fillTalentValues(2, true);
		local items = this.getContainer().getActor().getItems();
		local stash = this.World.Assets.getStash()
		stash.removeByID("supplies.ground_grains");
		stash.removeByID("supplies.ground_grains");
		items.equip(this.new("scripts/items/weapons/legend_sickle"));
		items.equip(this.Const.World.Common.pickArmor([
			[1, "barbarians/hide_and_bone_armor"]
		]));

		items.equip(this.Const.World.Common.pickHelmet([
			[1, "barbarians/bear_headpiece"]
		]));

	}

	function onSerialize( _out )
	{
		this.character_background.onSerialize(_out);
		_out.writeU8(this.m.Tattoo);
	}

	function onDeserialize( _in )
	{
		this.character_background.onDeserialize(_in);
		this.m.Tattoo = _in.readU8();
	}

});
