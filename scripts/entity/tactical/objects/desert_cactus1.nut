this.desert_cactus1 <- this.inherit("scripts/entity/tactical/entity", {
	m = {
		IsTree = true	
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
		local variants = [
			"01",
			"05"
		];
		local v = variants[this.Math.rand(0, variants.len() - 1)];
		local bottom = this.addSprite("bottom");
		bottom.setBrush("desert_cactus_" + v + "_bottom");
		bottom.setHorizontalFlipping(flip);
		bottom.varyColor(0.03, 0.03, 0.03);
		bottom.Scale = 0.8 + this.Math.rand(0, 20) / 100.0;
		local top = this.addSprite("top");
		top.setBrush("desert_cactus_" + v + "_top");
		top.setHorizontalFlipping(flip);
		top.Color = bottom.Color;
		top.Scale = bottom.Scale;
		this.setSpriteOcclusion("top", 1, 2, -3);
		this.setBlockSight(true);
	}

});

