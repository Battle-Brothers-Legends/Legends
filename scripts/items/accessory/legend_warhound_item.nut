this.legend_warhound_item <- this.inherit("scripts/items/accessory/legend_accessory_dog", {
	m = {},

	function create()
	{
		this.legend_accessory_dog.create();
		this.m.Script = "scripts/entity/tactical/warhound";
		this.m.Variant = this.Math.rand(1, 2);
		this.updateVariant();
		this.m.ID = "accessory.legend_warhound";
		this.m.Name = this.Const.Strings.WardogNames[this.Math.rand(0, this.Const.Strings.WardogNames.len() - 1)] + " the Warhound";
		this.m.Description = "A strong and loyal northern hound bred for war. Can be unleashed in battle for scouting, tracking or running down routing enemies.";
		this.m.Value = 250;
	}

	function getDescription()
	{
		if (this.m.Entity == null)
		{
			return this.item.getDescription();
		}
		else
		{
			return "The collar of a warhound that has been unleashed onto the battlefield.";
		}
	}

	function getName()
	{
		if (this.m.Entity == null)
		{
			return this.item.getName();
		}
		else
		{
			return "Warhound Collar";
		}
	}

	function onEquip()
	{
		this.legend_accessory_dog.onEquip();
		local unleash = this.new("scripts/skills/actives/unleash_wardog");
		unleash.setItem(this);
		unleash.m.Name = "Unleash Warhound";
		unleash.m.Description = "Unleash your warhound and send him charging into the enemy. Needs a free tile adjacent.";
		unleash.m.Icon = "skills/active_165.png";
		unleash.m.IconDisabled = "skills/active_165_sw.png";
		unleash.m.Overlay = "active_165";
		this.m.Skill = this.WeakTableRef(unleash);
		this.addSkill(unleash);
	}

	function setEntity( _e )
	{
		this.m.Entity = _e;

		if (this.m.Entity != null)
		{
			this.m.Icon = "tools/hound_01_leash_70x70.png";
		}
		else
		{
			this.m.Icon = "tools/hound_0" + this.m.Variant + "_70x70.png";
		}
	}

});

