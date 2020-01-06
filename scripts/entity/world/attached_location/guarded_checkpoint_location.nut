this.guarded_checkpoint_location <- this.inherit("scripts/entity/world/attached_location", {
	m = {},
	function create()
	{
		this.attached_location.create();
		this.m.Name = "Guarded Checkpoint";
		this.m.ID = "attached_location.guarded_checkpoint";
		this.m.Description = "A road checkpoint manned by professional soldiers.";
		this.m.Sprite = "world_guarded_checkpoint_01";
		this.m.SpriteDestroyed = "world_guarded_checkpoint_01_ruins";
		this.m.IsMilitary = true;
	}

	function onUpdateDraftList( _list )
	{
		if (!this.isActive())
		{
			return;
		}

		_list.push("militia_background");
		_list.push("deserter_background");
		_list.push("sellsword_background");
	}

	function onUpdateShopList( _id, _list )
	{
		if (_id == "building.marketplace")
		{
			_list.push({
				R = 30,
				P = 1.0,
				S = "armor/leather_tunic"
			});
			_list.push({
				R = 40,
				P = 1.0,
				S = "armor/padded_surcoat"
			});
			_list.push({
				R = 40,
				P = 1.0,
				S = "armor/padded_leather"
			});
			_list.push({
				R = 50,
				P = 1.0,
				S = "armor/gambeson"
			});
			_list.push({
				R = 60,
				P = 1.0,
				S = "armor/basic_mail_shirt"
			});
			_list.push({
				R = 10,
				P = 1.0,
				S = "helmets/aketon_cap"
			});
			_list.push({
				R = 15,
				P = 1.0,
				S = "helmets/full_aketon_cap"
			});
			_list.push({
				R = 60,
				P = 1.0,
				S = "helmets/nasal_helmet"
			});
			_list.push({
				R = 65,
				P = 1.0,
				S = "shields/legend_tower_shield"
			});
			_list.push({
				R = 65,
				P = 1.0,
				S = "helmets/kettle_hat"
			});
			_list.push({
				R = 65,
				P = 1.0,
				S = "helmets/flat_top_helmet"
			});
			_list.push({
				R = 30,
				P = 1.0,
				S = "shields/wooden_shield"
			});
			_list.push({
				R = 70,
				P = 1.0,
				S = "weapons/billhook"
			});
			_list.push({
				R = 60,
				P = 1.0,
				S = "weapons/military_cleaver"
			});
				_list.push({
				R = 80,
				P = 1.0,
				S = "tents/tent_train"
			});
				_list.push({
				R = 80,
				P = 1.0,
				S = "tents/tent_scout"
			});
			_list.push({
				R = 30,
				P = 1.0,
				S = "weapons/legend_tipstaff"
			});

			_list.push({
				R = 60,
				P = 1.0,
				S = "weapons/legend_slingstaff"
			});
			_list.push({
				R = 70,
				P = 1.0,
				S = "weapons/boar_spear"
			});
		}
		else if (_id == "building.specialized_trader")
		{
		}
		else if (_id == "building.weaponsmith")
		{
		}
		else if (_id == "building.armorsmith")
		{
		}
	}

	function onUpdateLegendShopList( _id, _list )
	{
		if (_id == "building.marketplace")
		{
			local armorsL = [
				[15, 1.0, "cloth/legend_gambeson"],
				[15, 1.0, "cloth/legend_padded_surcoat"],
				[20, 1.0, "chain/legend_armor_mail_shirt_simple"],
				[20, 1.0, "chain/legend_armor_mail_shirt"],
				[35, 1.0, "plate/legend_armor_leather_padded"],
				[15, 1.0, "plate/legend_armor_leather_jacket"],
				[15, 1.0, "plate/legend_armor_leather_jacket_simple"]
			]

			foreach( a in armorsL)
			{
				_list.push({
					R = a[0],
					P = a[1],
					S = "legend_armor/" + a[2]
				});
			}

			_list.push({
				R = 10,
				P = 1.0,
				S = "helmets/aketon_cap"
			});
			_list.push({
				R = 15,
				P = 1.0,
				S = "helmets/full_aketon_cap"
			});
			_list.push({
				R = 60,
				P = 1.0,
				S = "helmets/nasal_helmet"
			});
			_list.push({
				R = 65,
				P = 1.0,
				S = "shields/legend_tower_shield"
			});
			_list.push({
				R = 65,
				P = 1.0,
				S = "helmets/kettle_hat"
			});
			_list.push({
				R = 65,
				P = 1.0,
				S = "helmets/flat_top_helmet"
			});
			_list.push({
				R = 30,
				P = 1.0,
				S = "shields/wooden_shield"
			});
			_list.push({
				R = 70,
				P = 1.0,
				S = "weapons/billhook"
			});
			_list.push({
				R = 60,
				P = 1.0,
				S = "weapons/military_cleaver"
			});
				_list.push({
				R = 80,
				P = 1.0,
				S = "tents/tent_train"
			});
				_list.push({
				R = 80,
				P = 1.0,
				S = "tents/tent_scout"
			});
			_list.push({
				R = 30,
				P = 1.0,
				S = "weapons/legend_tipstaff"
			});

			_list.push({
				R = 60,
				P = 1.0,
				S = "weapons/legend_slingstaff"
			});
			_list.push({
				R = 70,
				P = 1.0,
				S = "weapons/boar_spear"
			});
		}
		else if (_id == "building.specialized_trader")
		{
		}
		else if (_id == "building.weaponsmith")
		{
		}
		else if (_id == "building.armorsmith")
		{
		}
	}

});

