this.female_slave_southern_background <- this.inherit("scripts/skills/backgrounds/slave_background", {
	m = {},
	function create()
	{
		this.slave_background.create();
		this.m.GoodEnding = "You purchased %name% as an indebted for almost no gold and continued to pay her a \'slave\'s wage\' for her stay as a sellsword. She did make herself an effective fighter, no doubt believing it was better to be paid nothing and fight to stay alive than be paid nothing and give up and rot. After your departure, you heard that the %companyname% traveled south on a campaign and the indebted got a good chance to exact a fair bit of revenge on a number of enemies in her past. Thankfully, she does not consider you one such person despite having keeping her in an enslaved stead.";
		this.m.BadEnding = "You purchased %name% as an indebted and after your retiring, she went on with the %companyname%. Word of the mercenary band\'s problems have trickled in, but nothing about the indebted\'s current situation. Knowing how this world works, she has either been put into the vanguard as fodder or perhaps even been sold off to recoup profits. Either way, the world isn\'t easy on a sellsword, and it isn\'t easy on an indebted, and the woman is unfortunately both.";
		this.m.Bodies = this.Const.Bodies.SouthernFemaleSkinny;
		this.m.Faces = this.Const.Faces.SouthernFemale;
		this.m.Hairs = this.Const.Hair.SouthernFemale;
		this.m.HairColors = this.Const.HairColors.Southern;
		this.m.Beards = null
		this.m.BeardChance = 0;
		this.m.Ethnicity = 1;
		this.m.Titles = [
			"the Enslaved",
			"the Prisoner",
			"the Unlucky",
			"the Indebted",
			"the Indebted",
			"the Indebted",
			"the Unfree",
			"the Criminal",
			"the Obedient",
			"the Shackled",
			"the Bound"
		]
	}

	function onBuildDescription()
	{
		return "{Much of the southern city states float atop the expendable bodies of prisoners of war, criminals, and indebted, throngs of people who have slighted the Gilder or Her followers and must \'earn\' salvation through hard work. %name% is one such unfortunate soul.} {Like a shocking many, %name% was not always a hunted woman. She worked as a traveling merchant until nomads ambushed her caravan. The nomads took her to a Vizier, pretending the man a criminal, and sold her as a hunted woman. | Spotted for her beauty, %name% was kidnapped off the streets of %randomcitystate% and sold straight to a manipulative Vizier. She does not speak much of what all happened, but there is a sense manual labor was not her sole duty. | So great the religious transgressions of her predecessors, %name% was born into an indebted family, and it is uncertain how far back into her ancestry you must go before a truly free woman would be found. | Desperate to save her family from generational debt, %name% sold herself into indentured servitude to ensure her husband and children have a life to live for themselves. | %name% swears she is from the north, but the deserts of the south have left her darkly tanned and, frankly, you\'ve not much reason to believe the words of a former prisoner of war no matter where he\'s from. | A once sea-farer, %name% spent years as an oarmen traveling from harbor to harbor to drive the goods of opulent merchants. Those who gave her to you stated she has a criminal past in piracy. | %name% was accused of ravishing an old woman and was given the option of execution or lifelong servitude. | Caught stealing from a fruit stall, %name% was pressed into lifelong servitude. | Fornications with \'men\' led to %name%\'s submission to servitude per the rules of the city-state in which she broke the laws. It was either that or become a sterile, and you can hardly blame her for choosing the hard labor in this case.} {The hardships of her life, rather quaintly, may serve as an excellent cast from which to mold a proper mercenary. | Her servitude no doubt made the woman formidable in appearance, though it may be hard to say where her mind is at being what is essence an indentured sellsword. | Slaves for warriors are a usual sight in the southern cities and %name% might serve as a useful, albeit enslaved, sellsword yet. | You hope %name% could make a sound sellsword, but you have the feeling her primary allegiance is to that which any woman wishes to taste: freedom.}";
	}

	function onChangeAttributes()
	{
		local c = {
			Hitpoints = [
				-10,
				-10
			],
			Bravery = [
				-10,
				-5
			],
			Stamina = [
				5,
				5
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
				-5,
				-5
			]
		};
		return c;
	}

	//Default Female
	function setGender(_gender = -1)
	{
		local r = _gender;
		if (_gender == -1)
		{
			r = 1;
			if (this.LegendsMod.Configs().LegendGenderEnabled())
			{
				r = this.Math.rand(0, 19);
			}
		}

		if (r == 1)
		{
			return;
		}


		this.m.Bodies = this.Const.Bodies.SouthernSlave;
		this.m.Faces = this.Const.Faces.SouthernMale;
		this.m.Hairs = this.Const.Hair.SouthernMale;
		this.m.HairColors = this.Const.HairColors.Southern;
		this.m.Beards = this.Const.Beards.All;
		this.m.BeardChance = 10;
		this.m.Ethnicity = 1;
		this.m.IsFemaleBackground = false;
		this.m.GoodEnding = "%name% the indebted has had a rough life and you\'ve both contributed to that and helped alleviate it in some way. Found as a slave in the south, far from family and home. \'Hired\' essentially for free and worked as an enslaved sellsword. After you left the %companyname%, %name% was removed from the ledger of indebted and was for all intents and purposes free. %name% stayed with the company and has been rising through its ranks ever since. You stand at an odd relation, %name% never thanked you, nor expressed ill will.";
		this.m.BadEnding = "With your retiring from the unsuccessful %companyname%, %name% the indebted from the north carried on with the company for a time. You got wind that the mercenary band ran into financial troubles and was selling off \'flesh and material\' to make ends meet. It seems %name%\'s time with the company presumably ended sometime there, and %name%\'s time as a slave started again.";

	}

	//no need to do legendsequipment here because it inherits from slave_background

	function onAddEquipment()
	{
		local items = this.getContainer().getActor().getItems();
		items.equip(this.Const.World.Common.pickArmor([
			[1, "tattered_sackcloth"],
			[1, "leather_wraps"],
			[3, "oriental/cloth_sash"],
			[2, ""]
		]))

			items.equip(this.Const.World.Common.pickHelmet([
			[1, ""],
			[1, "legend_headband_coin"],
			[1, "legend_headress_coin"],
			[1, "legend_earings"],
			[5, "legend_southern_veil"],
			[1, "legend_southern_veil_coin"],
			[1, "legend_southern_cloth_headress"]
		]));
	}

});

