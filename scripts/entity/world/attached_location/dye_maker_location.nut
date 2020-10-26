this.dye_maker_location <- this.inherit("scripts/entity/world/attached_location", {
	m = {},
	function create()
	{
		this.attached_location.create();
		this.m.Name = "Dye Maker";
		this.m.ID = "attached_location.dye_maker";
		this.m.Description = "This dye maker creates precious dies from all kinds of ingredients. The recipes for these expensive goods are well-kept secrets.";
		this.m.Sprite = "world_dye_maker_01";
		this.m.SpriteDestroyed = "world_dye_maker_01_ruins";
	}

	function onUpdateProduce( _list )
	{
		_list.push("trade/dies_item");
	}

	function onUpdateDraftList( _list, _gender)
	{
		if (!this.isActive())
		{
			return;
		}

		_list.push("apprentice_background");
		_list.push("caravan_hand_background");
		_list.push("tailor_background");
		if (_gender)
		{
			_list.push("female_tailor_background");
		}

	}

	function onUpdateShopList( _id, _list )
	{
		if (_id == "building.marketplace")
		{
			_list.push({
				R = 0,
				P = 1.0,
				S = "trade/dies_item"
			});
		   _list.push({
				R = 0,
				P = 1.0,
				S = "weapons/legend_wooden_pitchfork"
			});
			_list.push({
				R = 30,
				P = 1.0,
				S = "helmets/jesters_hat"
			});
			_list.push({
				R = 30,
				P = 1.0,
				S = "helmets/jesters_hat"
			});

			if (this.Const.DLC.Unhold)
			{
				_list.push({
					R = 30,
					P = 1.0,
					S = "misc/paint_set_item"
				});
				_list.push({
					R = 50,
					P = 1.0,
					S = "misc/paint_black_item"
				});
				_list.push({
					R = 50,
					P = 1.0,
					S = "misc/paint_red_item"
				});
				_list.push({
					R = 50,
					P = 1.0,
					S = "misc/paint_orange_red_item"
				});
				_list.push({
					R = 50,
					P = 1.0,
					S = "misc/paint_white_blue_item"
				});
				_list.push({
					R = 50,
					P = 1.0,
					S = "misc/paint_white_green_yellow_item"
				});
			}
		}
		else if (_id == "building.specialized_trader")
		{
		}
		else if (_id == "building.armorsmith")
		{
			_list.push({
				R = 0,
				P = 1.0,
				S = "helmets/named/jugglers_hat"
			});
			_list.push({
				R = 30,
				P = 1.0,
				S = "helmets/named/jugglers_padded_hat"
			});
			_list.push({
				R = 50,
				P = 1.0,
				S = "helmets/named/death_jesters_helm"
			});
		}
	}

	function onInit()
	{
		this.attached_location.onInit();
		this.getSprite("body").Scale = 0.9;
	}

});

