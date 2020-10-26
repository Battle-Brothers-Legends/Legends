this.desert_plant <- this.inherit("scripts/entity/tactical/entity", {
	m = {
		IsBush = true	
	},
	function getName()
	{
		return this.Const.Strings.Tactical.EntityName.Plant;
	}

	function getDescription()
	{
		return this.Const.Strings.Tactical.EntityDescription.Plant;
	}

	function onInit()
	{
		local flip = this.Math.rand(0, 1) == 1;
		local body = this.addSprite("body");
		body.setBrush("desert_plant_0" + this.Math.rand(1, 5));
		body.setHorizontalFlipping(flip);
		body.varyColor(0.03, 0.03, 0.03);
		body.Scale = 0.8 + this.Math.rand(0, 20) / 100.0;
		this.setBlockSight(true);
	}

});

