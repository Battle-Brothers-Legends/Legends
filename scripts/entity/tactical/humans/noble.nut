this.noble <- this.inherit("scripts/entity/tactical/human", {
	m = {
		Properties = [],
		Titles = []
	},
	function getProperties()
	{
		return this.m.Properties;
	}

	function getTitles()
	{
		return this.m.Titles;
	}

	function create()
	{
		this.m.Type = this.Const.EntityType.Knight;
		this.m.BloodType = this.Const.BloodType.Red;
		this.m.XP = this.Const.Tactical.Actor.Noble.XP;
		this.m.Name = this.generateName();
		this.human.create();
		this.m.Faces = this.Const.Faces.SmartMale;
		this.m.Hairs = this.Const.Hair.CommonMale;
		this.m.HairColors = null;
		this.m.Beards = this.Const.Beards.Tidy;
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/military_melee_agent");
		this.m.AIAgent.setActor(this);
	}

	function generateName()
	{
		return this.Const.Strings.NobleTitles[this.Math.rand(0, this.Const.Strings.NobleTitles.len() - 1)] + " " + this.Const.Strings.CharacterNames[this.Math.rand(0, this.Const.Strings.CharacterNames.len() - 1)];
	}

	function onInit()
	{
		this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.Noble);
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.getSprite("socket").setBrush("bust_base_military");
		this.m.Skills.add(this.new("scripts/skills/perks/perk_steel_brow"));
		this.m.Skills.add(this.new("scripts/skills/actives/recover_skill"));
		if("Assets" in this.World && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
			{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_nimble"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_battle_forged"));
			this.m.Skills.add(this.new("scripts/skills/traits/fearless_trait"));
			}

	}

	function assignRandomEquipment()
	{
		local r;
		this.m.Surcoat = this.World.FactionManager.getFaction(this.getFaction()).getBanner();
		local surcoat = "surcoat_" + (this.m.Surcoat < 10 ? "0" + this.m.Surcoat : this.m.Surcoat);
		r = this.Math.rand(1, 7);
		local withDetails = true;
		local alwaysWithDetails = false;
		local withHelmet = true;

		if (r == 1)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[1, "noble_tunic"]
			]));
			alwaysWithDetails = true;
		}
		else if (r == 2)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[1, "coat_of_plates"]
			]));
			withDetails = false;
			withHelmet = false;

			if (this.Math.rand(1, 100) <= 75)
			{
				this.getSprite("surcoat").setBrush(surcoat);
			}

			if (this.Math.rand(1, 100) <= 25)
			{
				local h = this.Const.World.Common.pickHelmet([
					[1, "greatsword_faction_helm", this.World.FactionManager.getFaction(this.getFaction()).getBanner()]
				])
				this.m.Items.equip(h);
			}

			if (this.Math.rand(1, 100) <= 33)
			{
				local variants = [
					"02",
					"10"
				];
				this.getSprite("surcoat").setBrush("bust_body_noble_" + variants[this.Math.rand(0, variants.len() - 1)]);
			}
		}
		else if (r == 3)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[1, "coat_of_scales"]
			]));
			withDetails = false;
			withHelmet = false;

			if (this.Math.rand(1, 100) <= 75)
			{
				this.getSprite("surcoat").setBrush(surcoat);
			}

			if (this.Math.rand(1, 100) <= 25)
			{
				local h = this.Const.World.Common.pickHelmet([
					[1, "greatsword_faction_helm", this.World.FactionManager.getFaction(this.getFaction()).getBanner()]
				])
				this.m.Items.equip(h);
			}

			if (this.Math.rand(1, 100) <= 33)
			{
				local variants = [
					"02",
					"10"
				];
				this.getSprite("surcoat").setBrush("bust_body_noble_" + variants[this.Math.rand(0, variants.len() - 1)]);
			}
		}
		else
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[1, "noble_gear"]
			]));
		}

		if (withDetails && (alwaysWithDetails || this.Math.rand(1, 100) <= 50))
		{
			local variants = [
				"01",
				"02",
				"03",
				"06",
				"09",
				"10"
			];
			this.getSprite("surcoat").setBrush("bust_body_noble_" + variants[this.Math.rand(0, variants.len() - 1)]);
		}

		if (withHelmet && this.Math.rand(1, 100) <= 50)
		{
			this.Const.World.Common.pickHelmet([
					[1, "noble_headgear"]
			])
		}
	}

	function onSerialize( _out )
	{
		this.human.onSerialize(_out);
		_out.writeU8(this.m.Properties.len());

		foreach( p in this.m.Properties )
		{
			_out.writeU32(p);
		}

		_out.writeU8(this.m.Titles.len());

		foreach( t in this.m.Titles )
		{
			_out.writeString(t);
		}
	}

	function onDeserialize( _in )
	{
		this.human.onDeserialize(_in);
		local numProperties = _in.readU8();
		this.m.Properties.resize(numProperties);

		for( local i = 0; i < numProperties; i = ++i )
		{
			this.m.Properties[i] = _in.readU32();
		}

		local numTitles = _in.readU8();
		this.m.Titles.resize(numTitles);

		for( local i = 0; i < numTitles; i = ++i )
		{
			this.m.Titles[i] = _in.readString();
		}
	}

});

