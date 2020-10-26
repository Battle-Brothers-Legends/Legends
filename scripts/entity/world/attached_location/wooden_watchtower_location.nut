this.wooden_watchtower_location <- this.inherit("scripts/entity/world/attached_location", {
	m = {},
	function create()
	{
		this.attached_location.create();
		this.m.Name = "Wooden Watchtower";
		this.m.ID = "attached_location.wooden_watchtower";
		this.m.Description = "A wooden watchtower with a small garrison on watch duty.";
		this.m.Sprite = "world_wooden_watchtower_01";
		this.m.SpriteDestroyed = "world_wooden_watchtower_01_ruins";
		this.m.IsMilitary = true;
		this.m.IsScalingDefenders = false;
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

		_list.push("militia_background");
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
				R = 50,
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
				R = 30,
				P = 1.0,
				S = "shields/wooden_shield"
			});
			_list.push({
				R = 10,
				P = 1.0,
				S = "weapons/legend_sling"
			});
				_list.push({
				R = 50,
				P = 1.0,
				S = "weapons/legend_staff"
			});
			_list.push({
				R = 65,
				P = 1.0,
				S = "shields/legend_tower_shield"
			});
			_list.push({
				R = 80,
				P = 1.0,
				S = "tents/tent_scout"
			});
			_list.push({
				R = 30,
				P = 1.0,
				S = "weapons/legend_wooden_spear"
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

	function onInit()
	{
		this.attached_location.onInit();
		this.getSprite("lighting").setBrush("world_wooden_watchtower_01_light");
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


	function getNewResources()
	{
		return 0;
	}
});

