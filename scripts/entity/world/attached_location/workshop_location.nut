this.workshop_location <- this.inherit("scripts/entity/world/attached_location", {
	m = {
		LastFireTime = 0
	},
	function create()
	{
		this.attached_location.create();
		this.m.Name = "Workshop";
		this.m.ID = "attached_location.workshop";
		this.m.Description = "The workshop is proficient in making all kinds of tools and other supplies needed to keep carts and machines working.";
		this.m.Sprite = "world_workshop_01";
		this.m.SpriteDestroyed = "world_workshop_01_ruins";
	}

	function getSounds( _all = true )
	{
		local r = [];

		if (this.World.getTime().IsDaytime)
		{
			r = [
				{
					File = "ambience/buildings/blacksmith_hammering_00.wav",
					Volume = 1.0,
					Pitch = 1.0
				},
				{
					File = "ambience/buildings/blacksmith_hammering_01.wav",
					Volume = 1.0,
					Pitch = 1.0
				},
				{
					File = "ambience/buildings/blacksmith_hammering_02.wav",
					Volume = 1.0,
					Pitch = 1.0
				},
				{
					File = "ambience/buildings/blacksmith_hammering_03.wav",
					Volume = 1.0,
					Pitch = 1.0
				},
				{
					File = "ambience/buildings/blacksmith_hammering_04.wav",
					Volume = 1.0,
					Pitch = 1.0
				},
				{
					File = "ambience/buildings/blacksmith_hammering_05.wav",
					Volume = 1.0,
					Pitch = 1.0
				},
				{
					File = "ambience/buildings/blacksmith_hammering_06.wav",
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
		_list.push("supplies/armor_parts_item");
		_list.push("supplies/armor_parts_small_item");
	}

	function onUpdateDraftList( _list, _gender)
	{
		if (!this.isActive())
		{
			return;
		}
		_list.push("legend_ironmonger_background");
		_list.push("legend_ironmonger_background");
		_list.push("legend_ironmonger_background");
		_list.push("legend_ironmonger_background");
		_list.push("legend_blacksmith_background");
		_list.push("legend_blacksmith_background");
		_list.push("apprentice_background");
		_list.push("caravan_hand_background");
		_list.push("peddler_background");
		_list.push("daytaler_background");

		if (_gender)
		{
		_list.push("female_daytaler_background");

		}

		if(this.World.LegendsMod.Configs().LegendMagicEnabled())
		{
			local r;
			if  ( this.World.Assets.getOrigin().getID() == "scenario.legends_seer")
			{
			r = this.Math.rand(0, 5);
				if (r == 1)
				{
				_list.push("legend_transmuter_background");
				}
			}
			else
			{
			r = this.Math.rand(0, 9);
				if (r == 1)
				{
				_list.push("legend_transmuter_background");
				}
			}
		}
	}

	function onUpdateShopList( _id, _list )
	{
		if (_id == "building.marketplace")
		{
			_list.push({
				R = 20,
				P = 1.0,
				S = "supplies/armor_parts_item"
			});
			_list.push({
				R = 10,
				P = 1.0,
				S = "weapons/legend_saw"
			});
			_list.push({
				R = 10,
				P = 1.0,
				S = "weapons/legend_hammer"
			});
			_list.push({
				R = 20,
				P = 1.0,
				S = "supplies/armor_parts_item"
			});
			_list.push({
				R = 20,
				P = 1.0,
				S = "supplies/armor_parts_small_item"
			});
			_list.push({
				R = 20,
				P = 1.0,
				S = "supplies/armor_parts_small_item"
			});
			_list.push({
				R = 20,
				P = 1.0,
				S = "supplies/armor_parts_item"
			});
			_list.push({
				R = 80,
				P = 1.0,
				S = "tents/tent_craft"
			});
			_list.push({
				R = 20,
				P = 1.0,
				S = "supplies/armor_parts_item"
			});
		}
		else if (_id == "building.specialized_trader")
		{
		}
		else if (_id == "building.weaponsmith")
		{
			_list.push({
				R = 95,
				P = 1.0,
				S = "weapons/named/legend_named_blacksmith_hammer"
			});
		}
		else if (_id == "building.armorsmith")
		{
		}
	}

	function onInit()
	{
		this.attached_location.onInit();
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

		if (this.m.Settlement != null && this.m.Settlement.isDiscovered() && this.World.getTime().IsDaytime && this.Time.getRealTimeF() - this.m.LastFireTime >= 10.0)
		{
			this.m.LastFireTime = this.Time.getRealTimeF();
			local smoke = this.Const.World.CampSmokeParticles;

			for( local i = 0; i < smoke.len(); i = ++i )
			{
				this.World.spawnParticleEffect(smoke[i].Brushes, smoke[i].Delay, smoke[i].Quantity, smoke[i].LifeTime, smoke[i].SpawnRate, smoke[i].Stages, this.createVec(this.getPos().X + 85, this.getPos().Y - 10), -200 + this.Const.World.ZLevel.Particles);
			}
		}
	}

});

