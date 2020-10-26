this.trapper_location <- this.inherit("scripts/entity/world/attached_location", {
	m = {},
	function create()
	{
		this.attached_location.create();
		this.m.Name = "Trapper";
		this.m.ID = "attached_location.trapper";
		this.m.Description = "Small huts provide shelter for the trappers living here and setting traps for animals with valuable furs.";
		this.m.Sprite = "world_trapper_01";
		this.m.SpriteDestroyed = "world_trapper_01_ruins";
	}

	function onUpdateProduce( _list )
	{
		_list.push("trade/furs_item");
		_list.push("trade/tin_ingots_item");
	}

	function onUpdateDraftList( _list, _gender)
	{
		if (!this.isActive())
		{
			return;
		}

		_list.push("peddler_background");
		_list.push("caravan_hand_background");
		_list.push("poacher_background");

		local r;
		if  ( this.World.Assets.getOrigin().getID() == "scenario.legends_seer")
		{
		r = this.Math.rand(0, 5);
			if (r == 1)
			{
				_list.push("legend_conjurer_background");
			}
		}
		else
		{
			r = this.Math.rand(0, 9);
			if (r == 1)
			{
				_list.push("legend_conjurer_background");
			}
		}

	}

	function onUpdateShopList( _id, _list )
	{
		if (_id == "building.marketplace")
		{
			_list.push({
				R = 0,
				P = 1.0,
				S = "trade/furs_item"
			});

			_list.push({
				R = 50,
				P = 1.0,
				S = "weapons/hunting_bow"
			});
			_list.push({
				R = 50,
				P = 1.0,
				S = "weapons/legend_shiv"
			});
			_list.push({
				R = 10,
				P = 1.0,
				S = "weapons/legend_wooden_stake"
			});
			_list.push({
				R = 50,
				P = 1.0,
				S = "tools/throwing_net"
			});
			_list.push({
				R = 80,
				P = 1.0,
				S = "tents/tent_hunter"
			});
				_list.push({
				R = 50,
				P = 1.0,
				S = "weapons/legend_chain"
			});
		}
		else if (_id == "building.specialized_trader")
		{
		}
	}

});

