this.noble_faction <- this.inherit("scripts/factions/faction", {
	m = {
		HairColor = 0
	},
	function getName()
	{
		return "House " + this.m.Name;
	}

	function getNameOnly()
	{
		return this.m.Name;
	}

	function getColor()
	{
		return this.Const.BannerColor[this.m.Banner];
	}

	function getBannerSmall()
	{
		return "banner_noble_" + (this.m.Banner < 10 ? "0" + this.m.Banner : this.m.Banner);
	}

	function isReadyToSpawnUnit()
	{
		return this.m.Units.len() <= this.m.Settlements.len();
	}

	function addPlayerRelation( _r, _reason = "" )
	{
		this.faction.addPlayerRelation(_r, _reason);

		if (_r < 0)
		{
			foreach( s in this.m.Settlements )
			{
				if (s.getFaction() != this.m.ID)
				{
					this.World.FactionManager.getFaction(s.getFaction()).addPlayerRelationEx(_r * 0.5);
				}
			}
		}

		if (this.m.PlayerRelation > 90.0)
		{
			this.updateAchievement("MakingAllies", 1, 1);
		}
	}

	function makeSettlementsFriendlyToPlayer()
	{
		foreach( s in this.m.Settlements )
		{
			if (!s.isAlive())
			{
				continue;
			}

			local civilian = s.getFactionOfType(this.Const.FactionType.Settlement);

			if (civilian != null && civilian.getPlayerRelation() < 30.0)
			{
				civilian.addPlayerRelationEx(30.0 - civilian.getPlayerRelation(), "Changed sides in the war");
			}
		}
	}

	function create()
	{
		this.faction.create();
		this.m.Type = this.Const.FactionType.NobleHouse;
		this.m.HairColor = this.Math.rand(0, this.Const.HairColors.Lineage.len() - 1);
		this.m.Base = "world_base_09";
		this.m.TacticalBase = "bust_base_military";
		this.m.BannerPrefix = "banner_noble_";
		this.m.CombatMusic = this.Const.Music.NobleTracks;
		this.m.RelationDecayPerDay = this.Const.World.Assets.RelationDecayPerDayNoble;
	}

	function onUpdateRoster()
	{
		for( local roster = this.getRoster(); roster.getSize() < 4;  )
		{
			local character = roster.create("scripts/entity/tactical/humans/noble");
			character.setFaction(this.m.ID);
			character.m.HairColors = this.Const.HairColors.Lineage[this.m.HairColor];
			character.setAppearance();
			character.setTitle("von " + this.m.Name);
			character.assignRandomEquipment();
		}
	}

	function isReadyForContract()
	{
		return this.m.Contracts.len() == 0 && (this.m.LastContractTime == 0 || this.Time.getVirtualTimeF() > this.m.LastContractTime + this.World.getTime().SecondsPerDay * 3.0);
	}

	function onSerialize( _out )
	{
		this.faction.onSerialize(_out);
		_out.writeU8(this.m.HairColor);
	}

	function onDeserialize( _in )
	{
		this.faction.onDeserialize(_in);

		if (_in.getMetaData().getVersion() >= 52)
		{
			this.m.HairColor = _in.readU8();
		}

		if (this.getAction("send_caravan_action") == null)
		{
			local card = this.new("scripts/factions/actions/send_caravan_action");
			card.setFaction(this);
			this.m.Deck.push(card);
		}
	}

});

