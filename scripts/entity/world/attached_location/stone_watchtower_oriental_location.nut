this.stone_watchtower_oriental_location <- this.inherit("scripts/entity/world/attached_location", {
	m = {},
	function create()
	{
		this.attached_location.create();
		this.m.Name = "Stone Watchtower";
		this.m.ID = "attached_location.stone_watchtower";
		this.m.Description = "A stone watchtower occupied by well trained soldiers on guard duty.";
		this.m.Sprite = "world_southern_watchtower";
		this.m.SpriteDestroyed = "world_southern_watchtower_ruins";
		this.m.IsMilitary = true;
		this.m.IsScalingDefenders = true;
	}

	function getSounds( _all = true )
	{
		local r = [];

		if (this.World.getTime().IsDaytime)
		{
			r = [
				{
					File = "ambience/settlement/settlement_dog_00.wav",
					Volume = 1.0,
					Pitch = 1.0
				},
				{
					File = "ambience/settlement/settlement_dog_01.wav",
					Volume = 1.0,
					Pitch = 1.0
				},
				{
					File = "ambience/settlement/settlement_dog_02.wav",
					Volume = 1.0,
					Pitch = 1.0
				},
				{
					File = "ambience/settlement/fortification_yelling_00.wav",
					Volume = 1.0,
					Pitch = 1.0
				},
				{
					File = "ambience/settlement/fortification_yelling_01.wav",
					Volume = 1.0,
					Pitch = 1.0
				},
				{
					File = "ambience/settlement/fortification_yelling_02.wav",
					Volume = 1.0,
					Pitch = 1.0
				},
				{
					File = "ambience/settlement/fortification_yelling_03.wav",
					Volume = 1.0,
					Pitch = 1.0
				}
			];
			return r;
		}

		return r;
	}

	function onUpdateDraftList( _list, _gender)
	{
		if (!this.isActive())
		{
			return;
		}

		_list.push("nomad_background");
		_list.push("nomad_background");
		_list.push("nomad_background");
	}

	function onUpdateShopList( _id, _list )
	{
		if (_id == "building.marketplace")
		{
			_list.push({
				R = 30,
				P = 1.0,
				S = "armor/oriental/padded_vest"
			});
			_list.push({
				R = 40,
				P = 1.0,
				S = "armor/oriental/linothorax"
			});
			_list.push({
				R = 40,
				P = 1.0,
				S = "armor/oriental/southern_mail_shirt"
			});
			_list.push({
				R = 10,
				P = 1.0,
				S = "helmets/oriental/southern_head_wrap"
			});
			_list.push({
				R = 65,
				P = 1.0,
				S = "helmets/oriental/spiked_skull_cap_with_mail"
			});
			_list.push({
				R = 30,
				P = 1.0,
				S = "shields/oriental/southern_light_shield"
			});
			_list.push({
				R = 40,
				P = 1.0,
				S = "weapons/oriental/saif"
			});
			_list.push({
				R = 60,
				P = 1.0,
				S = "weapons/scimitar"
			});
				_list.push({
				R = 90,
				P = 1.0,
				S = "tents/tent_train"
			});
				_list.push({
				R = 90,
				P = 1.0,
				S = "tents/tent_scout"
			});
			_list.push({
				R = 60,
				P = 1.0,
				S = "weapons/oriental/light_southern_mace"
			});

			if (this.Const.DLC.Unhold)
			{
				_list.extend([
					{
						R = 80,
						P = 1.0,
						S = "weapons/throwing_spear"
					}
				]);
			}
		}
		else if (_id == "building.specialized_trader")
		{
		}
		else if (_id == "building.weaponsmith")
		{
		}
		else if (_id == "building.armorsmith")
		{
			if (this.LegendsMod.Configs().LegendArmorsEnabled())
			{
				_list.push({
					R = 35,
					P = 1.0,
					S = "legend_armor/tabard/legend_southern_tabard"
				});
				_list.push({
					R = 60,
					P = 1.0,
					S = "legend_armor/cloak/legend_armor_cloak_common"
				});
				_list.push({
					R = 60,
					P = 1.0,
					S = "legend_armor/cloak/legend_armor_cloak_heavy"
				});
				_list.push({
					R = 99,
					P = 2.0,
					S = "legend_armor/named/legend_armor_cloak_rich"
				});
				_list.push({
					R = 60,
					P = 1.0,
					S = "legend_armor/cloak/legend_sash"
				});
				_list.push({
					R = 99,
					P = 2.0,
					S = "legend_armor/named/legend_armor_named_tabard"
				});
			}
		}
	}

	function onInit()
	{
		this.attached_location.onInit();
		this.getSprite("lighting").setBrush("world_southern_watchtower_lights");
		this.registerThinker();
	}

	function onFinish()
	{
		this.attached_location.onFinish();
		this.unregisterThinker();
	}

	function onUpdate()
	{
		if (!this.m.IsActive)
		{
			return;
		}

		this.updateLighting();
	}

});

