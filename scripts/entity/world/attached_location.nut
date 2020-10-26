this.attached_location <- this.inherit("scripts/entity/world/location", {
	m = {
		ID = "",
		Sprite = "",
		SpriteDestroyed = "",
		Settlement = null,
		IsActive = true,
		IsMilitary = false,
		IsConnected = true,
		IsUsable = true,
		IsNew = false
	},

	function getSpriteName()
	{
		if (this.m.Sprite == "")
		{
			return "";
		}

		local s = this.m.Sprite;
		if (this.World.LegendsMod.Configs().LegendWorldEconomyEnabled())
		{
			s = "legend_" + this.m.Sprite;
		}
		return s
	}

	function getSpriteDestroyedName()
	{
		if (this.m.IsNew)
		{
			//This is normally gated around our WorldEconomy config, but when reloading a saved game,
			//the sprites on the UI are loaded before the config, so we'll get the wrong sprite
			//to show -- hackish, but we know that IsNew is only used by the WorldEconomy so
			//we can assume it is enabled here.
			local s= "legend_" + this.m.Sprite + "_upgrade";
			return s;
		}

		local s = this.m.SpriteDestroyed;
		if (this.World.LegendsMod.Configs().LegendWorldEconomyEnabled())
		{
			s = "legend_" + this.m.SpriteDestroyed;
		}
		return s;
	}

	function getTypeID()
	{
		return this.m.ID;
	}

	function isEnterable()
	{
		return false;
	}

	function isActive()
	{
		return this.m.IsActive && !this.m.IsNew;
	}

	function isBuilding()
	{
		return this.m.IsNew;
	}

	function isMilitary()
	{
		return this.m.IsMilitary;
	}

	function isConnected()
	{
		return this.m.IsConnected;
	}

	function isUsable()
	{
		return this.m.IsUsable;
	}

	function getSettlement()
	{
		return this.m.Settlement;
	}

	function setSettlement( _s )
	{
		if (_s == null || !_s.isLocation())
		{
			this.m.Settlement = null;
		}
		else
		{
			this.m.Settlement = this.WeakTableRef(_s);
			this.m.Settlement.onAttachedLocationsChanged();
		}
	}

	function getName()
	{
		if (this.m.IsNew) {
			local s = "New " + this.world_entity.getName() + " Construction";
			return s;
		}

		return this.m.IsActive ? this.world_entity.getName() : "Ruins";
	}

	function getRealName()
	{
		return this.world_entity.getName();
	}

	function getDescription()
	{
		if (this.m.IsActive || this.m.IsNew)
		{
			return this.world_entity.getDescription();
		}
		else
		{
			return "Once part of the nearby settlement, these are now burned down and abandoned ruins.";
		}
	}

	function setActive( _a, _force = false)
	{
		if (_a == this.m.IsActive && _force == false)
		{
			return;
		}

		this.m.IsActive = _a;
		if (this.m.Settlement != null && !this.m.Settlement.isNull() && this.m.Settlement.isAlive())
		{
			this.m.Settlement.onAttachedLocationsChanged();
		}
		this.updateSprites();
	}

	function setNew( _a )
	{
		this.m.IsNew = _a;
	}

	function updateSprites()
	{
		local s = this.getSprite("body")
		if (s != null)
		{
			s.setBrush(this.m.IsActive ? this.getSpriteName() : this.getSpriteDestroyedName());
		}
		s = this.getSprite("lighting")
		if (s != null)
		{
			s.Visible = this.m.IsActive || this.m.IsNew;
		}
	}

	function updateLighting()
	{
		local lighting = this.getSprite("lighting");

		if (lighting.IsFadingDone)
		{
			if (lighting.Alpha == 0 && this.World.getTime().TimeOfDay >= 4 && this.World.getTime().TimeOfDay <= 7)
			{
				lighting.Color = this.createColor("ffffff00");

				if (this.World.getCamera().isInsideScreen(this.getPos(), 0))
				{
					lighting.fadeIn(5000);
				}
				else
				{
					lighting.Alpha = 255;
				}
			}
			else if (lighting.Alpha != 0 && this.World.getTime().TimeOfDay >= 0 && this.World.getTime().TimeOfDay <= 3)
			{
				if (this.World.getCamera().isInsideScreen(this.getPos(), 0))
				{
					lighting.fadeOut(4000);
				}
				else
				{
					lighting.Alpha = 0;
				}
			}
		}
	}

	function create()
	{
		this.location.create();
		this.m.IsAttackable = false;
		this.m.IsAttackableByAI = false;
		this.m.IsDestructible = false;
		this.m.IsShowingName = false;
		this.m.CombatLocation.Template[0] = "tactical.human_camp";
		this.m.CombatLocation.Fortification = this.Const.Tactical.FortificationType.None;
		this.m.CombatLocation.CutDownTrees = true;
		this.m.CombatLocation.AdditionalRadius = 5;
		this.m.LocationType = this.Const.World.LocationType.AttachedLocation;
	}

	function onUpdate()
	{
	}

	function onBuild()
	{
		return true;
	}

	function onUpdateProduce( _list )
	{
	}

	function onUpdateDraftList( _list, _gender)
	{
	}

	function onUpdateStablesList ( _list )
	{
	}

	function onUpdateShopList( _id, _list )
	{
	}


	function onRaided()
	{
	}

	function onInit()
	{
		this.location.onInit();
		this.setDiscovered(true);
		this.setShowName(false);
		local body = this.addSprite("body");
		body.setBrush(this.getSpriteName());
		local lighting = this.addSprite("lighting");
		this.setSpriteColorization("lighting", false);
		lighting.Alpha = 0;
		lighting.IgnoreAmbientColor = true;
	}

	function onFinish()
	{
		this.location.onFinish();
	}

	function getNewResources()
	{
		return 1;
	}

	function onSerialize( _out )
	{
		this.location.onSerialize(_out);

		if (this.m.Settlement != null && !this.m.Settlement.isNull() && this.m.Settlement.isAlive())
		{
			_out.writeU32(this.m.Settlement.getID());
		}
		else
		{
			_out.writeU32(0);
		}

		_out.writeBool(this.m.IsActive);
		_out.writeBool(this.m.IsNew);
	}

	function onDeserialize( _in )
	{
		this.location.onDeserialize(_in);
		local settlementID = _in.readU32();

		if (settlementID != 0)
		{
			this.setSettlement(this.World.getEntityByID(settlementID));

			if (this.m.Settlement != null)
			{
				this.m.Settlement.getAttachedLocations().push(this);
				this.m.Settlement.updateProduce();
			}
		}

		local active = _in.readBool();
		this.m.IsNew = _in.readBool();
		this.setActive(active, true);
		this.setAttackable(false);
		this.getSprite("lighting").Color = this.createColor("ffffff00");
	}

});

