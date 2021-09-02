this.incense_dryer_location <- this.inherit("scripts/entity/world/attached_location", {
	m = {},
	function create()
	{
		this.attached_location.create();
		this.m.Name = "Incense Dryer";
		this.m.ID = "attached_location.incense_dryer";
		this.m.Description = "Tree sap is gathered from the surrounding trees and dried in the sun to create valuable incense.";
		this.m.Sprite = "world_incense_01";
		this.m.SpriteDestroyed = "world_incense_01_ruins";
	}

	function onBuild()
	{
		local myTile = this.getTile();
		myTile.setBrush("world_desert_0" + this.Math.rand(6, 9));
		return true;
	}

	function onUpdateProduce( _list )
	{
		_list.push("trade/incense_item");
		_list.push("supplies/armor_parts_small_item");
		_list.push("supplies/medicine_small_item");
	}

	function onUpdateDraftList( _list, _gender)
	{
		if (!this.isActive())
		{
			return;
		}

		_list.push("daytaler_southern_background");
		_list.push("daytaler_southern_background");
		_list.push("legend_dervish_background");
		_list.push("legend_alchemist_background");
	}

	function onUpdateShopList( _id, _list )
	{
		if (_id == "building.marketplace")
		{
			_list.push({
				R = 0,
				P = 1.0,
				S = "trade/incense_item"
			});
			_list.push({
				R = 0,
				P = 1.0,
				S = "supplies/armor_parts_small_item"
			});
			_list.push({
				R = 95,
				P = 1.0,
				S = "tents/tent_enchant"
			});
			_list.push({
				R = 80,
				P = 1.0,
				S = "tents/tent_craft"
			});
			_list.push({
				R = 0,
				P = 1.0,
				S = "supplies/medicine_small_item"
			});
		}
	}

});

