this.generic_item <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "items.generic";
		this.m.Name = this.Const.Items.Default.GenericItemName;
		this.m.Description = "?!";
		this.m.Icon = this.Const.Items.Default.GenericItemIcon;
		this.m.Type = this.Const.SkillType.Item;
		this.m.Order = this.Const.SkillOrder.Item;
		this.m.IsActive = false;
		this.m.IsHidden = true;
		this.m.IsStacking = true;
		this.m.IsSerialized = false;
		this.m.IsRemovedAfterBattle = false;
	}

	function onUpdate( _properties )
	{

		if (!isNull(this.m.Item) && !isNull(this.m.Item.getContainer()))
		{
			this.m.Item.onUpdateProperties(_properties);
		}
		else
		{
			this.removeSelf();
		}
	}


	function onTurnStart()
	{
		if (!isNull(this.m.Item) && !isNull(this.m.Item.getContainer()))
		{
			this.m.Item.onTurnStart();
		}
		else
		{
			this.removeSelf();
		}
	}
});
