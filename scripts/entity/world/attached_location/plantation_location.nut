this.plantation_location <- this.inherit("scripts/entity/world/attached_location", {
	m = {},
	function create()
	{
		this.attached_location.create();
		this.m.Name = "Plantation";
		this.m.ID = "attached_location.plantation";
		this.m.Description = "All kinds of wonderous spices and herbs are cultivated in this plantation. A small and rare fruitful spot in the barren desert.";
		this.m.Sprite = "world_spice_01";
		this.m.SpriteDestroyed = "world_spice_01_ruins";
	}

	function onBuild()
	{
		local myTile = this.getTile();
		myTile.setBrush("world_desert_0" + this.Math.rand(6, 9));
		return true;
	}

	function onUpdateProduce( _list )
	{
		_list.push("trade/spices_item");
		_list.push("supplies/medicine_small_item");
	}

	function onUpdateDraftList( _list, _gender)
	{
		if (!this.isActive())
		{
			return;
		}

		_list.push("slave_southern_background");
		_list.push("slave_southern_background");

		if (_gender)
		{
			_list.push("legend_qiyan_background");
		}
	}

	function onUpdateShopList( _id, _list )
	{
		if (_id == "building.marketplace")
		{
			_list.push({
				R = 0,
				P = 1.0,
				S = "trade/spices_item"
			});
			_list.push({
				R = 0,
				P = 1.0,
				S = "supplies/dates_item"
			});
			_list.push({
				R = 80,
				P = 1.0,
				S = "tents/tent_heal"
			});
			_list.push({
				R = 90,
				P = 1.0,
				S = "tents/tent_gather"
			});
			_list.push({
				R = 0,
				P = 1.0,
				S = "supplies/medicine_small_item"
			});
		}
	}

	function getNewResources()
	{
		return 2;
	}

});

