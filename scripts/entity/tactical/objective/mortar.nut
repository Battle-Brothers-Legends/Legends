this.mortar <- this.inherit("scripts/entity/tactical/actor", {
	m = {},
	function create()
	{
		this.m.IsAttackable = false;
		this.m.IsActingEachTurn = true;
		this.m.IsNonCombatant = true;
		this.m.IsShakingOnHit = false;
		this.m.Type = this.Const.EntityType.Mortar;
		this.m.BloodType = this.Const.BloodType.None;
		this.m.MoraleState = this.Const.MoraleState.Ignore;
		this.m.XP = 0;
		this.m.BloodSplatterOffset = this.createVec(0, 0);
		this.actor.create();
		this.m.Name = "Mortar";
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/mortar_agent");
		this.m.AIAgent.setActor(this);
	}

	function setFlipped( _f )
	{
		this.getSprite("body").setHorizontalFlipping(_f);
	}

	function onFactionChanged()
	{
		this.actor.onFactionChanged();
		local flip = this.isAlliedWithPlayer();
		this.getSprite("body").setHorizontalFlipping(flip);
	}

	function onInit()
	{
		this.actor.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.Mortar);
		b.IsImmuneToKnockBackAndGrab = true;
		b.IsImmuneToStun = true;
		b.IsImmuneToRoot = true;
		b.IsImmuneToBleeding = true;
		b.IsImmuneToPoison = true;
		b.IsAffectedByInjuries = false;
		b.IsAffectedByNight = false;
		b.IsMovable = false;
		b.TargetAttractionMult = 2.0;
		b.DamageReceivedTotalMult = 0.0;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.ActionPointCosts = this.Const.DefaultMovementAPCost;
		this.m.FatigueCosts = this.Const.DefaultMovementFatigueCost;
		this.addSprite("socket");
		local body = this.addSprite("body");
		body.setBrush("mortar_01");
		this.addDefaultStatusSprites();
		this.m.Skills.add(this.new("scripts/skills/actives/fire_mortar_skill"));
		this.m.Skills.update();
	}

	function onDeath( _killer, _skill, _tile, _fatalityType )
	{
		if (_tile != null)
		{
			_tile.spawnDetail("mortar_destroyed", this.Const.Tactical.DetailFlag.Corpse, false);
		}
	}

});

