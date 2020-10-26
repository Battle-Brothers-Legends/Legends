this.attack_zone_order <- this.inherit("scripts/ai/world/world_behavior", {
	m = {
		TargetTile = null
	},
	function setTargetTile( _t )
	{
		this.m.TargetTile = _t;
	}

	function create()
	{
		this.world_behavior.create();
		this.m.ID = this.Const.World.AI.Behavior.ID.AttackZone;
	}

	function onSerialize( _out )
	{
		this.world_behavior.onSerialize(_out);
		_out.writeI16(this.m.TargetTile.Coords.X);
		_out.writeI16(this.m.TargetTile.Coords.Y);
	}

	function onDeserialize( _in )
	{
		this.world_behavior.onDeserialize(_in);
		local x = _in.readI16();
		local y = _in.readI16();
		this.m.TargetTile = this.World.getTile(x, y);
	}

	function onExecute( _entity, _hasChanged )
	{
		local myTile = _entity.getTile();

		if (this.m.TargetTile != null && myTile.ID != this.m.TargetTile.ID)
		{
			local move = this.new("scripts/ai/world/orders/move_order");
			move.setDestination(this.m.TargetTile);
			this.getController().addOrderInFront(move);
			return true;
		}

		_entity.setOrders("Attacking Zone");
		local parties = this.World.getAllEntitiesAtPos(_entity.getPos(), this.Const.World.CombatSettings.CombatPlayerDistance);

		if (parties.len() > 1)
		{
			local isPlayerInvolved = false;
			local isHostileToPlayer = false;
			local enemy;

			foreach( party in parties )
			{
				if (party.isPlayerControlled())
				{
					isPlayerInvolved = true;
				}

				if (!party.isAlliedWith(_entity) && !party.isLocation())
				{
					enemy = party;
				}

				if (!party.isAlliedWithPlayer() && !party.isLocation())
				{
					isHostileToPlayer = true;
				}
			}

			if (enemy != null)
			{
				if (isPlayerInvolved && isHostileToPlayer)
				{
					this.World.State.setAIEngageCallback(function ()
					{
						if (_entity.onEnteringCombatWithPlayer(false))
						{
							this.World.State.showCombatDialog(false, true, true, null, _entity.getPos());
						}
					});
				}
				else
				{
					this.World.Combat.startCombat(_entity, enemy);
				}
			}
		}

		this.getController().popOrder();
		return true;
	}

});

