this.occupy_order <- this.inherit("scripts/ai/world/world_behavior", {
	m = {
		IsSafetyOverride = false,
		Target = null,
		Time = 0.0,
		Start = 0.0
	},
	function setTarget( _t )
	{
		if (typeof _t == "instance")
		{
			this.m.Target = _t;
		}
		else
		{
			this.m.Target = this.WeakTableRef(_t);
		}
	}

	function setTime( _t )
	{
		this.m.Time = _t;
	}

	function setSafetyOverride( _s )
	{
		this.m.IsSafetyOverride = _s;
	}

	function create()
	{
		this.world_behavior.create();
		this.m.ID = this.Const.World.AI.Behavior.ID.Occupy;
	}

	function onSerialize( _out )
	{
		this.world_behavior.onSerialize(_out);

		if (this.m.Target != null && !this.m.Target.isNull())
		{
			_out.writeU32(this.m.Target.getID());
		}
		else
		{
			_out.writeU32(0);
		}

		_out.writeBool(this.m.IsSafetyOverride);
		_out.writeF32(this.m.Time);
		_out.writeF32(this.m.Start);
	}

	function onDeserialize( _in )
	{
		this.world_behavior.onDeserialize(_in);
		local t = _in.readU32();

		if (t != 0)
		{
			this.m.Target = this.WeakTableRef(this.World.getEntityByID(t));
		}

		this.m.IsSafetyOverride = _in.readBool();
		this.m.Time = _in.readF32();
		this.m.Start = _in.readF32();
	}

	function onExecute( _entity, _hasChanged )
	{
		if (!this.World.FactionManager.isHolyWar())
		{
			this.getController().popOrder();
			return true;
		}

		local myTile = _entity.getTile();

		if (!this.m.IsSafetyOverride)
		{
			local activeContract = this.World.Contracts.getActiveContract();

			if (activeContract != null && activeContract.isTileUsed(myTile))
			{
				this.getController().popOrder();
				return true;
			}
		}

		if (this.m.Target != null && myTile.ID != this.m.Target.getTile().ID)
		{
			local move = this.new("scripts/ai/world/orders/move_order");
			move.setDestination(this.m.Target.getTile());
			this.getController().addOrderInFront(move);
			return true;
		}

		_entity.setOrders("Occupying");

		if (this.m.Start == 0.0)
		{
			this.m.Start = this.Time.getVirtualTimeF();
		}
		else if (this.Time.getVirtualTimeF() - this.m.Start >= this.m.Time)
		{
			local entities = this.World.getAllEntitiesAndOneLocationAtPos(_entity.getPos(), 1.0);

			foreach( e in entities )
			{
				if (e.isLocation())
				{
					if (e.getFaction() == 0 || !this.World.FactionManager.isAllied(_entity.getFaction(), e.getFaction()))
					{
						e.setFaction(_entity.getFaction());
						e.setBanner(_entity.getSprite("banner").getBrush().Name);

						if (e.getTile().getDistanceTo(this.World.State.getPlayer().getTile()) > 6)
						{
							local image;

							if (e.getTypeID() == "location.holy_site.meteorite")
							{
								image = 154;
							}
							else if (e.getTypeID() == "location.holy_site.vulcano")
							{
								image = 151;
							}
							else
							{
								image = 152;
							}

							local news = this.World.Statistics.createNews();
							news.set("Holysite", e.getName());
							news.set("Image", image);
							this.World.Statistics.addNews(this.World.FactionManager.getFaction(_entity.getFaction()).getType() == this.Const.FactionType.OrientalCityState ? "crisis_holywar_holysite_south" : "crisis_holywar_holysite_north", news);
						}
					}

					break;
				}
			}

			this.getController().popOrder();
		}

		return true;
	}

});

