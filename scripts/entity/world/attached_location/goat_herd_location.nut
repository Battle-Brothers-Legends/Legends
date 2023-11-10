this.goat_herd_location <- this.inherit("scripts/entity/world/attached_location", {
	m = {},
	function create()
	{
		this.attached_location.create();
		this.m.Name = "Goat Pens";
		this.m.ID = "attached_location.goat_herd";
		this.m.Description = "The goats held here are mainly used for their milk which is then turned into cheese to make it more durable. Contributes cheese, staves, slings, shepherds, farmhands and butchers to the local town.";
		this.m.Sprite = "world_goat_herd_01";
		this.m.SpriteDestroyed = "world_goat_herd_01_ruins";
	}

	function getSounds( _all = true )
	{
		local r = [];

		if (this.World.getTime().IsDaytime)
		{
			r = [
				{
					File = "ambience/settlement/goat_pens_00.wav",
					Volume = 1.0,
					Pitch = 1.0
				},
				{
					File = "ambience/settlement/goat_pens_01.wav",
					Volume = 1.0,
					Pitch = 1.0
				},
				{
					File = "ambience/settlement/goat_pens_02.wav",
					Volume = 1.0,
					Pitch = 1.0
				},
				{
					File = "ambience/settlement/goat_pens_03.wav",
					Volume = 1.0,
					Pitch = 1.0
				},
				{
					File = "ambience/settlement/goat_pens_04.wav",
					Volume = 1.0,
					Pitch = 1.0
				},
				{
					File = "ambience/settlement/goat_pens_05.wav",
					Volume = 1.0,
					Pitch = 1.0
				},
				{
					File = "ambience/settlement/goat_pens_06.wav",
					Volume = 1.0,
					Pitch = 1.0
				}
			];

			foreach( s in r )
			{
				s.Volume *= this.Const.Sound.Volume.Ambience / this.Const.Sound.Volume.AmbienceOutsideSettlement;
			}
		}

		return r;
	}

	function onUpdateProduce( _list )
	{
		_list.push("supplies/goat_cheese_item");
		_list.push("supplies/legend_fresh_milk_item");
	}

	function onUpdateDraftList( _list, _gender = null)
	{
		_gender = ::Legends.Mod.ModSettings.getSetting("GenderEquality").getValue() != "Disabled";
		if (!this.isActive())
		{
			return;
		}

		_list.push("butcher_background");
		_list.push("daytaler_background");
		_list.push("farmhand_background");
		_list.push("farmhand_background");
		_list.push("shepherd_background");
		_list.push("shepherd_background");
		_list.push("shepherd_background");
	}

	function onUpdateShopList( _id, _list )
	{
		if (_id == "building.marketplace")
		{
			_list.push({
				R = 0,
				P = 1.0,
				S = "supplies/goat_cheese_item"
			});
			_list.push({
				R = 0,
				P = 1.0,
				S = "supplies/goat_cheese_item"
			});
			_list.push({
				R = 0,
				P = 1.0,
				S = "supplies/legend_fresh_milk_item"
			});
			_list.push({
				R = 0,
				P = 1.0,
				S = "weapons/legend_sling"
			});
			_list.push({
				R = 10,
				P = 1.0,
				S = "weapons/legend_staff"
			});
			_list.push({
				R = 60,
				P = 1.0,
				S = "weapons/legend_tipstaff"
			});
			_list.push({
				R = 60,
				P = 1.0,
				S = "weapons/legend_slingstaff"
			});
			_list.push({
				R = 30,
				P = 1.0,
				S = "armor/leather_tunic"
			});
		}
	}

});

