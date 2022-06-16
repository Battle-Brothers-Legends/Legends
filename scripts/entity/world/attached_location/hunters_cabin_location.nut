this.hunters_cabin_location <- this.inherit("scripts/entity/world/attached_location", {
	m = {},
	function create()
	{
		this.attached_location.create();
		this.m.Name = "Hunter\'s Cabin";
		this.m.ID = "attached_location.hunters_cabin";
		this.m.Description = "Hunters take shelter in these small huts while on the hunt. Chopped up game, venison and hides hung up to dry in the sun surround the huts.";
		this.m.Sprite = "world_hunter_01";
		this.m.SpriteDestroyed = "world_hunter_01_ruins";
	}

	function onUpdateProduce( _list )
	{
		_list.push("supplies/cured_venison_item");
	}

	function onUpdateDraftList( _list, _gender = null)
	{
		_gender = ::Legends.Mod.ModSettings.getSetting("GenderEquality").getValue() != "Disabled";
		if (!this.isActive())
		{
			return;
		}

		_list.push("butcher_background");
		_list.push("butcher_background");
		_list.push("hunter_background");
		_list.push("hunter_background");
		_list.push("poacher_background");
		_list.push("poacher_background");
		_list.push("poacher_background");
		_list.push("poacher_background");
		_list.push("legend_taxidermist_background");

		if (this.Math.rand(0, 9) == 1)
		{
			_list.push("legend_master_archer_background");
		}
	}

	function onUpdateShopList( _id, _list )
	{
		if (_id == "building.marketplace")
		{
			_list.push({
				R = 10,
				P = 1.0,
				S = "supplies/cured_venison_item"
			});
			_list.push({
				R = 0,
				P = 0.9,
				S = "supplies/legend_fresh_meat_item"
			});
			_list.push({
				R = 30,
				P = 1.0,
				S = "weapons/short_bow"
			});
			_list.push({
				R = 50,
				P = 1.0,
				S = "weapons/hunting_bow"
			});
			_list.push({
				R = 90,
				P = 1.0,
				S = "weapons/war_bow"
			});
			_list.push({
				R = 90,
				P = 1.0,
				S = "weapons/greenskins/goblin_bow"
			});
			_list.push({
				R = 10,
				P = 1.0,
				S = "helmets/hood"
			});
			_list.push({
				R = 10,
				P = 1.0,
				S = "weapons/knife"
			});
			_list.push({
				R = 80,
				P = 1.0,
				S = "tents/tent_hunter"
			});
			_list.push({
				R = 10,
				P = 1.0,
				S = "helmets/hunters_hat"
			});

			if (this.Const.DLC.Unhold)
			{
				_list.extend([
					{
						R = 10,
						P = 1.0,
						S = "weapons/spetum"
					}
				]);
			}
		}
	}

	function onInit()
	{
		this.attached_location.onInit();
		this.getSprite("body").Scale = 0.9;
	}

});

