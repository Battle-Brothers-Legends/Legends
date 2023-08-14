this.fletchers_hut_location <- this.inherit("scripts/entity/world/attached_location", {
	m = {},
	function create()
	{
		this.attached_location.create();
		this.m.Name = "Arrow Maker\'s Shed";
		this.m.ID = "attached_location.fletchers_hut";
		this.m.Description = "The arrow makers in these sheds produce all kinds of ranged ammunition which they then sell at the nearest settlement. Contributes bows, crossbows, arrows, bolts, bowyers and archers to the local town";
		this.m.Sprite = "world_fletchers_hut_01";
		this.m.SpriteDestroyed = "world_fletchers_hut_01_ruins";
	}

	function getSounds( _all = true )
	{
		local r = [];

		if (this.World.getTime().IsDaytime)
		{
			r = [
				{
					File = "ambience/settlement/settlement_saw_00.wav",
					Volume = 1.0,
					Pitch = 1.0
				},
				{
					File = "ambience/settlement/settlement_saw_01.wav",
					Volume = 1.0,
					Pitch = 1.0
				},
				{
					File = "ambience/settlement/settlement_building_00.wav",
					Volume = 1.0,
					Pitch = 1.0
				},
				{
					File = "ambience/settlement/settlement_building_01.wav",
					Volume = 1.0,
					Pitch = 1.0
				},
				{
					File = "ambience/settlement/settlement_building_02.wav",
					Volume = 1.0,
					Pitch = 1.0
				},
				{
					File = "ambience/settlement/settlement_building_03.wav",
					Volume = 1.0,
					Pitch = 1.0
				},
				{
					File = "ambience/settlement/settlement_building_03.wav",
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
		_list.push("supplies/ammo_item");
		_list.push("supplies/ammo_small_item");
		_list.push("supplies/ammo_item");
		_list.push("supplies/ammo_small_item");
	}

	function onUpdateDraftList( _list, _gender = null)
	{
		_gender = ::Legends.Mod.ModSettings.getSetting("GenderEquality").getValue() != "Disabled";
		if (!this.isActive())
		{
			return;
		}
		_list.push("hunter_background");
		_list.push("hunter_background");
		_list.push("bowyer_background");
		_list.push("poacher_background");
		_list.push("poacher_background");
		_list.push("witchhunter_background");

		if (_gender)
		{
			_list.push("female_bowyer_background");
			_list.push("female_bowyer_background");
		}
	}

	function onUpdateShopList( _id, _list )
	{
		if (_id == "building.marketplace")
		{
			_list.push({
				R = 10,
				P = 1.0,
				S = "weapons/short_bow"
			});
			_list.push({
				R = 10,
				P = 1.0,
				S = "weapons/legend_saw"
			});
			_list.push({
				R = 0,
				P = 0.8,
				S = "ammo/quiver_of_arrows"
			});
			_list.push({
				R = 0,
				P = 0.8,
				S = "ammo/quiver_of_bolts"
			});
			_list.push({
				R = 0,
				P = 0.8,
				S = "supplies/ammo_item"
			});
			_list.push({
				R = 80,
				P = 1.0,
				S = "ammo/legend_armor_piercing_arrows"
			});
			_list.push({
				R = 80,
				P = 1.0,
				S = "ammo/legend_armor_piercing_bolts"
			});
			_list.push({
				R = 80,
				P = 1.0,
				S = "ammo/legend_broad_head_arrows"
			});
			_list.push({
				R = 80,
				P = 1.0,
				S = "ammo/legend_broad_head_bolts"
			});
		}
		else if (_id == "building.specialized_trader")
		{
		}
		else if (_id == "building.fletcher")
		{
			_list.push({
				R = 20,
				P = 1.0,
				S = "weapons/hunting_bow"
			});
			_list.push({
				R = 20,
				P = 1.0,
				S = "weapons/legend_sling"
			});
			_list.push({
				R = 20,
				P = 1.0,
				S = "weapons/light_crossbow"
			});
			_list.push({
				R = 60,
				P = 1.0,
				S = "ammo/huge_quiver_of_arrows"
			});
			_list.push({
				R = 60,
				P = 1.0,
				S = "ammo/huge_quiver_of_bolts"
			});
			_list.push({
				R = 40,
				P = 1.0,
				S = "ammo/legend_large_armor_piercing_arrows"
			});
			_list.push({
				R = 40,
				P = 1.0,
				S = "ammo/legend_large_armor_piercing_bolts"
			});
			_list.push({
				R = 40,
				P = 1.0,
				S = "ammo/legend_large_broad_head_arrows"
			});
			_list.push({
				R = 40,
				P = 1.0,
				S = "ammo/legend_large_broad_head_bolts"
			});
		}
		else if (_id == "building.weaponsmith")
		{
			_list.push({
				R = 50,
				P = 1.0,
				S = "weapons/war_bow"
			});
			_list.push({
				R = 99,
				P = 3.0,
				S = "weapons/legend_hand_crossbow"
			});
		}
	}

});

