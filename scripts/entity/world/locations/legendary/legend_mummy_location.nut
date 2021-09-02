this.legend_mummy_location <- this.inherit("scripts/entity/world/location", {
	m = {},
	function getDescription()
	{
		return "An ancient ruin, in a style of architecture you have never seen before.";
	}

	function create()
	{
		this.location.create();
		this.m.TypeID = "location.legend_mummy";
		this.m.LocationType = this.Const.World.LocationType.Unique;
		this.m.IsShowingDefenders = false;
		this.m.IsShowingBanner = true;
		this.m.IsAttackable = false;
		this.m.IsDestructible = false;
		this.m.VisibilityMult = 0.8;
		this.m.Resources = 0;
		this.m.OnEnter = "event.location.legend_mummy_enter";
	}

	function onSpawned()
	{
		this.m.Name = "Ancient Mastaba";
		this.location.onSpawned();
	}

	function onInit()
	{
		this.location.onInit();
		local body = this.addSprite("body");
		body.setBrush("legend_mastaba");
		local banner = this.addSprite("banner");
		banner.setOffset(this.createVec(-60, 50));
	}

});

