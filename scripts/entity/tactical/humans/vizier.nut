this.vizier <- this.inherit("scripts/entity/tactical/human", {
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
		this.m.Type = this.Const.EntityType.Officer;
		this.m.BloodType = this.Const.BloodType.Red;
		this.m.XP = this.Const.Tactical.Actor.Officer.XP;
		this.m.Name = this.Const.Strings.SouthernNames[this.Math.rand(0, this.Const.Strings.SouthernNames.len() - 1)] + " " + this.Const.Strings.SouthernNamesLast[this.Math.rand(0, this.Const.Strings.SouthernNamesLast.len() - 1)];
		this.m.Title = this.Const.Strings.VizierTitles[this.Math.rand(0, this.Const.Strings.VizierTitles.len() - 1)];
		this.human.create();
		this.m.Bodies = this.Const.Bodies.SouthernMale;
		this.m.Faces = this.Const.Faces.SouthernMale;
		this.m.Hairs = this.Const.Hair.SouthernMale;
		this.m.HairColors = this.Const.HairColors.Southern;
		this.m.Beards = this.Const.Beards.Southern;
		this.m.BeardChance = 90;
		this.m.Ethnicity = 1;
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/military_melee_agent");
		this.m.AIAgent.setActor(this);
	}

	function onOtherActorDeath( _killer, _victim, _skill )
	{
		if (_victim.getType() == this.Const.EntityType.Slave && _victim.isAlliedWith(this))
		{
			return;
		}

		this.actor.onOtherActorDeath(_killer, _victim, _skill);
	}

	function onOtherActorFleeing( _actor )
	{
		if (_actor.getType() == this.Const.EntityType.Slave && _actor.isAlliedWith(this))
		{
			return;
		}

		this.actor.onOtherActorFleeing(_actor);
	}

	function onInit()
	{
		this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.Noble);
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.getSprite("socket").setBrush("bust_base_southern");
	}

	function assignRandomEquipment()
	{
		local r;
		r = this.Math.rand(1, 8);
		local withDetails = true;
		local alwaysWithDetails = false;
		local withHelmet = true;

		this.m.Items.equip(this.Const.World.Common.pickArmor([
				[1, "oriental/padded_mail_and_lamellar_hauberk"],
				[1, "oriental/mail_and_lamellar_plating"],
				[1, "oriental/vizier_gear"]
		]));

		if (withDetails && (alwaysWithDetails || this.Math.rand(1, 100) <= 50))
		{
			local variants = [
				"03",
				"04"
			];
			this.getSprite("surcoat").setBrush("bust_desert_noble_" + variants[this.Math.rand(0, variants.len() - 1)]);
		}

		if (withHelmet && this.Math.rand(1, 100) <= 80)
		{
			local helmet = [
				[1, "oriental/vizier_headgear"]
			];
			this.m.Items.equip(this.Const.World.Common.pickHelmet(helmet));
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

