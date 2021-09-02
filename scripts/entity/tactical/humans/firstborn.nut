this.firstborn <- this.inherit("scripts/entity/tactical/player", {
	m = {},
	function getPlaceInFormation()
	{
		return 26;
	}

	function isReallyKilled( _fatalityType )
	{
		return true;
	}

	function create()
	{
		this.m.Type = this.Const.EntityType.Peasant;
		this.m.BloodType = this.Const.BloodType.Red;
		this.m.XP = this.Const.Tactical.Actor.Councilman.XP;
		this.m.IsGuest = true;
		this.player.create();
		this.m.Faces = this.Const.Faces.SmartMale;
		this.m.Hairs = this.Const.Hair.CommonMale;
		this.m.HairColors = this.Const.HairColors.Young;
		this.m.Beards = this.Const.Beards.Tidy;
		this.m.AIAgent = this.new("scripts/ai/tactical/player_agent");
		this.m.AIAgent.setActor(this);
	}

	function onInit()
	{
		this.player.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.Envoy);
		b.TargetAttractionMult = 3.0;
		b.MoraleCheckBraveryMult[this.Const.MoraleCheckType.MentalAttack] = 1000.0;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.Talents.resize(this.Const.Attributes.COUNT, 0);
		this.m.Attributes.resize(this.Const.Attributes.COUNT, [
			0
		]);
		this.getSprite("socket").setBrush("bust_base_militia");
		this.setAppearance();
		this.assignRandomEquipment();
	}

	function assignRandomEquipment()
	{

		this.m.Items.equip(this.Const.World.Common.pickArmor([
			[1, "linen_tunic"]
		]));

		this.m.Items.equip(this.Const.World.Common.pickHelmet([
			[1, "feathered_hat"],
			[3, ""]
		]))
	}

});

