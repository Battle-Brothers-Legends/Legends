this.sand_golem <- this.inherit("scripts/entity/tactical/actor", {
	m = {
		Size = 1,
		Variant = 1,
		ScaleStartTime = 0,
		BackupFaction = 0,
		BackupWorldParty = null,
		IsShrinking = false,
		IsSpawningOnTile = false
	},
	function getSize()
	{
		return this.m.Size;
	}

	function getIdealRange()
	{
		if (this.m.Size == 1)
		{
			return 1;
		}
		else
		{
			return 5;
		}
	}

	function create()
	{
		this.m.Type = this.Const.EntityType.SandGolem;
		this.m.BloodType = this.Const.BloodType.Sand;
		this.m.XP = this.Const.Tactical.Actor.SandGolem.XP;
		this.m.MoraleState = this.Const.MoraleState.Ignore;
		this.m.BloodSplatterOffset = this.createVec(0, 15);
		this.actor.create();
		this.m.Sound[this.Const.Sound.ActorEvent.DamageReceived] = [
			"sounds/enemies/dlc6/sand_golem_hurt_01.wav",
			"sounds/enemies/dlc6/sand_golem_hurt_02.wav",
			"sounds/enemies/dlc6/sand_golem_hurt_03.wav",
			"sounds/enemies/dlc6/sand_golem_hurt_04.wav"
		];
		this.m.Sound[this.Const.Sound.ActorEvent.Death] = [
			"sounds/enemies/dlc6/sand_golem_death_01.wav",
			"sounds/enemies/dlc6/sand_golem_death_02.wav",
			"sounds/enemies/dlc6/sand_golem_death_03.wav",
			"sounds/enemies/dlc6/sand_golem_death_04.wav"
		];
		this.m.Sound[this.Const.Sound.ActorEvent.Idle] = [
			"sounds/enemies/dlc6/sand_golem_idle_01.wav",
			"sounds/enemies/dlc6/sand_golem_idle_02.wav",
			"sounds/enemies/dlc6/sand_golem_idle_03.wav",
			"sounds/enemies/dlc6/sand_golem_idle_04.wav",
			"sounds/enemies/dlc6/sand_golem_idle_05.wav",
			"sounds/enemies/dlc6/sand_golem_idle_06.wav",
			"sounds/enemies/dlc6/sand_golem_idle_07.wav",
			"sounds/enemies/dlc6/sand_golem_idle_08.wav",
			"sounds/enemies/dlc6/sand_golem_idle_09.wav"
		];
		this.m.Sound[this.Const.Sound.ActorEvent.Other1] = [
			"sounds/enemies/dlc6/sand_golem_assemble_01.wav",
			"sounds/enemies/dlc6/sand_golem_assemble_02.wav",
			"sounds/enemies/dlc6/sand_golem_assemble_03.wav"
		];
		this.m.Sound[this.Const.Sound.ActorEvent.Other2] = [
			"sounds/enemies/dlc6/sand_golem_disassemble_01.wav",
			"sounds/enemies/dlc6/sand_golem_disassemble_02.wav",
			"sounds/enemies/dlc6/sand_golem_disassemble_03.wav",
			"sounds/enemies/dlc6/sand_golem_disassemble_04.wav"
		];
		this.m.SoundPitch = 1.1;
		local onArmorHitSounds = this.getItems().getAppearance().ImpactSound;
		onArmorHitSounds[this.Const.BodyPart.Body] = this.m.Sound[this.Const.Sound.ActorEvent.DamageReceived];
		onArmorHitSounds[this.Const.BodyPart.Head] = this.m.Sound[this.Const.Sound.ActorEvent.DamageReceived];
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/golem_agent");
		this.m.AIAgent.setActor(this);
	}

	function onDamageReceived( _attacker, _skill, _hitInfo )
	{
		_hitInfo.BodyPart = this.Const.BodyPart.Body;
		return this.actor.onDamageReceived(_attacker, _skill, _hitInfo);
	}

	function onDeath( _killer, _skill, _tile, _fatalityType )
	{
		if (!this.Tactical.State.isScenarioMode() && _killer != null && _killer.isPlayerControlled())
		{
			this.updateAchievement("StoneMason", 1, 1);
		}

		this.m.BackupFaction = this.getFaction();
		this.m.BackupWorldParty = this.m.WorldTroop != null && ("Party" in this.m.WorldTroop) && this.m.WorldTroop.Party != null && !this.m.WorldTroop.Party.isNull() ? this.m.WorldTroop.Party : null;

		if (_tile != null && this.getSize() > 1)
		{
			local freeTiles = [];

			for( local i = 0; i < 6; i = ++i )
			{
				if (!_tile.hasNextTile(i))
				{
				}
				else
				{
					local nextTile = _tile.getNextTile(i);

					if (nextTile.Level > _tile.Level + 1)
					{
					}
					else if (nextTile.IsEmpty)
					{
						freeTiles.push(nextTile);
					}
				}
			}

			if (freeTiles.len() != 0)
			{
				local n = 2;
				n = --n;

				while (n >= 0 && freeTiles.len() >= 1)
				{
					local r = this.Math.rand(0, freeTiles.len() - 1);
					local tile = freeTiles[r];
					freeTiles.remove(r);
					local rock = this.Tactical.spawnEntity("scripts/entity/tactical/enemies/sand_golem", tile.Coords.X, tile.Coords.Y);
					rock.setFaction(this.getFaction());

					if (this.getWorldTroop() != null && ("Party" in this.getWorldTroop()) && this.getWorldTroop().Party != null && !this.m.WorldTroop.Party.isNull())
					{
						local e;

						if (this.getSize() == 3)
						{
							e = this.Const.World.Common.addTroop(this.getWorldTroop().Party.get(), {
								Type = this.Const.World.Spawn.Troops.SandGolemMEDIUM
							}, false);
						}
						else
						{
							e = this.Const.World.Common.addTroop(this.getWorldTroop().Party.get(), {
								Type = this.Const.World.Spawn.Troops.SandGolem
							}, false);
						}

						rock.setWorldTroop(e);
					}

					rock.getSprite("body").Color = this.getSprite("body").Color;
					rock.getSprite("body").Saturation = this.getSprite("body").Saturation;

					if (tile.IsVisibleForPlayer)
					{
						for( local i = 0; i < this.Const.Tactical.SandGolemParticles.len(); i = ++i )
						{
							this.Tactical.spawnParticleEffect(false, this.Const.Tactical.SandGolemParticles[i].Brushes, tile, this.Const.Tactical.SandGolemParticles[i].Delay, this.Const.Tactical.SandGolemParticles[i].Quantity, this.Const.Tactical.SandGolemParticles[i].LifeTimeQuantity, this.Const.Tactical.SandGolemParticles[i].SpawnRate, this.Const.Tactical.SandGolemParticles[i].Stages);
						}
					}

					if (this.getSize() == 3)
					{
						rock.grow(true);
					}
				}

				if (n > 0)
				{
					this.m.IsSpawningOnTile = true;
				}
			}
			else
			{
				this.m.IsSpawningOnTile = true;
			}
		}
		else
		{
			this.m.IsSpawningOnTile = true;
		}

		local flip = this.Math.rand(0, 100) < 50;
		local sprite_body = this.getSprite("body");

		if (_tile != null)
		{
			local decal;
			local skin = this.getSprite("body");
			this.m.IsCorpseFlipped = flip;
			decal = _tile.spawnDetail(sprite_body.getBrush().Name + "_dead", this.Const.Tactical.DetailFlag.Corpse, flip);
			decal.Color = skin.Color;
			decal.Saturation = skin.Saturation;
			decal.Scale = 0.9;
			decal.setBrightness(0.9);
			this.spawnTerrainDropdownEffect(_tile);
			local corpse = clone this.Const.Corpse;
			corpse.CorpseName = "An " + this.getName();
			corpse.Tile = _tile;
			corpse.Value = 2.0;
			corpse.IsResurrectable = false;
			corpse.IsConsumable = false;
			corpse.Armor = this.m.BaseProperties.Armor;
			corpse.IsHeadAttached = true;
			_tile.Properties.set("Corpse", corpse);
			this.Tactical.Entities.addCorpse(_tile);

			if ((_killer == null || _killer.getFaction() == this.Const.Faction.Player || _killer.getFaction() == this.Const.Faction.PlayerAnimals) && this.Math.rand(1, 100) <= 40)
			{
				local n = 0 + this.Math.rand(0, 1) + (!this.Tactical.State.isScenarioMode() && this.Math.rand(1, 100) <= this.World.Assets.getExtraLootChance() ? 1 : 0);

				for( local i = 0; i < n; i = ++i )
				{
					local loot = this.new("scripts/items/misc/sulfurous_rocks_item");
					loot.drop(_tile);
				}

				if (this.Math.rand(1, 100) <= 10)
				{
					local loot = this.new("scripts/items/loot/glittering_rock_item");
					loot.drop(_tile);
				}
			}

			this.actor.onDeath(_killer, _skill, _tile, _fatalityType);
		}
	}

	function onAfterDeath( _tile )
	{
		if (!this.m.IsSpawningOnTile)
		{
			return;
		}

		if (this.getSize() == 1)
		{
			return;
		}

		local rock = this.Tactical.spawnEntity("scripts/entity/tactical/enemies/sand_golem", _tile.Coords.X, _tile.Coords.Y);
		rock.setFaction(this.m.BackupFaction);

		if (this.m.BackupWorldParty != null)
		{
			local e;

			if (this.getSize() == 3)
			{
				e = this.Const.World.Common.addTroop(this.m.BackupWorldParty.get(), {
					Type = this.Const.World.Spawn.Troops.SandGolemMEDIUM
				}, false);
			}
			else
			{
				e = this.Const.World.Common.addTroop(this.m.BackupWorldParty.get(), {
					Type = this.Const.World.Spawn.Troops.SandGolem
				}, false);
			}

			rock.setWorldTroop(e);
		}

		if (this.getSize() == 3)
		{
			rock.grow(true);
		}
	}

	function onInit()
	{
		this.actor.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.SandGolem);
		b.IsAffectedByNight = false;
		b.IsImmuneToDisarm = true;
		b.IsImmuneToBleeding = true;
		b.IsImmuneToPoison = true;
		b.IsImmuneToStun = true;
		b.IsImmuneToFire = true;
		b.IsAffectedByInjuries = false;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.ActionPointCosts = this.Const.DefaultMovementAPCost;
		this.m.FatigueCosts = this.Const.DefaultMovementFatigueCost;
		this.m.Variant = this.Math.rand(1, 2);
		this.addSprite("socket").setBrush("bust_base_beasts");
		local body = this.addSprite("body");
		body.setBrush("bust_golem_body_0" + this.m.Variant + "_small");
		body.varySaturation(0.2);
		body.varyColor(0.06, 0.06, 0.06);
		this.addDefaultStatusSprites();
		this.getSprite("status_rooted").Scale = 0.45;
		this.setSpriteOffset("status_rooted", this.createVec(-4, 7));
		this.m.Skills.add(this.new("scripts/skills/racial/golem_racial"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_pathfinder"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_crippling_strikes"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_steel_brow"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_hold_out"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_bullseye"));
		this.m.Skills.add(this.new("scripts/skills/actives/merge_golem_skill"));
		this.m.Skills.add(this.new("scripts/skills/actives/throw_golem_skill"));
		this.m.Skills.add(this.new("scripts/skills/actives/headbutt_skill"));
	}

	function grow( _instant = false )
	{
		if (this.m.Size == 3)
		{
			return;
		}

		if (!_instant && this.m.Sound[this.Const.Sound.ActorEvent.Other1].len() != 0)
		{
			this.Sound.play(this.m.Sound[this.Const.Sound.ActorEvent.Other1][this.Math.rand(0, this.m.Sound[this.Const.Sound.ActorEvent.Other1].len() - 1)], this.Const.Sound.Volume.Actor, this.getPos());
		}

		this.m.Size = this.Math.min(3, this.m.Size + 1);
		this.m.IsShrinking = false;
		local b = this.m.BaseProperties;
		b.IsImmuneToKnockBackAndGrab = false;

		if (this.m.Size == 2)
		{
			this.getSprite("body").setBrush("bust_golem_body_0" + this.m.Variant + "_medium");

			if (!_instant)
			{
				this.setRenderCallbackEnabled(true);
				this.m.ScaleStartTime = this.Time.getVirtualTimeF();
			}

			this.getSprite("status_rooted").Scale = 0.5;
			this.getSprite("status_rooted_back").Scale = 0.5;
			this.setSpriteOffset("status_rooted", this.createVec(-4, 10));
			this.setSpriteOffset("status_rooted_back", this.createVec(-4, 10));

			if (this.m.WorldTroop != null && ("Party" in this.m.WorldTroop) && this.m.WorldTroop.Party != null && !this.m.WorldTroop.Party.isNull())
			{
				this.m.WorldTroop.Script = this.Const.World.Spawn.Troops.SandGolemMEDIUM.Script;
				this.m.WorldTroop.Strength = this.Const.World.Spawn.Troops.SandGolemMEDIUM.Strength;
			}
		}
		else if (this.m.Size == 3)
		{
			this.getSprite("body").setBrush("bust_golem_body_0" + this.m.Variant + "_big");

			if (!_instant)
			{
				this.setRenderCallbackEnabled(true);
				this.m.ScaleStartTime = this.Time.getVirtualTimeF();
			}

			this.getSprite("status_rooted").Scale = 0.6;
			this.getSprite("status_rooted_back").Scale = 0.6;
			this.setSpriteOffset("status_rooted", this.createVec(-7, 14));
			this.setSpriteOffset("status_rooted_back", this.createVec(-7, 14));
			b.IsImmuneToKnockBackAndGrab = true;

			if (this.m.WorldTroop != null && ("Party" in this.m.WorldTroop) && this.m.WorldTroop.Party != null && !this.m.WorldTroop.Party.isNull())
			{
				this.m.WorldTroop.Script = this.Const.World.Spawn.Troops.SandGolemHIGH.Script;
				this.m.WorldTroop.Strength = this.Const.World.Spawn.Troops.SandGolemHIGH.Strength;
			}
		}

		this.m.SoundPitch = 1.2 - this.m.Size * 0.1;
		this.m.Skills.update();
		this.setDirty(true);
	}

	function shrink( _instant = false )
	{
		if (this.m.Size == 1)
		{
			return;
		}

		if (!_instant && this.m.Sound[this.Const.Sound.ActorEvent.Other2].len() != 0)
		{
			this.Sound.play(this.m.Sound[this.Const.Sound.ActorEvent.Other2][this.Math.rand(0, this.m.Sound[this.Const.Sound.ActorEvent.Other2].len() - 1)], this.Const.Sound.Volume.Actor, this.getPos());
		}

		this.m.Size = this.Math.max(1, this.m.Size - 1);
		this.m.IsShrinking = true;
		local b = this.m.BaseProperties;
		b.IsImmuneToKnockBackAndGrab = false;

		if (this.m.Size == 2)
		{
			this.getSprite("body").setBrush("bust_golem_body_0" + this.m.Variant + "_medium");

			if (!_instant)
			{
				this.setRenderCallbackEnabled(true);
				this.m.ScaleStartTime = this.Time.getVirtualTimeF();
			}

			this.getSprite("status_rooted").Scale = 0.5;
			this.getSprite("status_rooted_back").Scale = 0.5;
			this.setSpriteOffset("status_rooted", this.createVec(-4, 10));
			this.setSpriteOffset("status_rooted_back", this.createVec(-4, 10));

			if (this.m.WorldTroop != null && ("Party" in this.m.WorldTroop) && this.m.WorldTroop.Party != null)
			{
				this.m.WorldTroop.Script = this.Const.World.Spawn.Troops.SandGolemMEDIUM.Script;
				this.m.WorldTroop.Strength = this.Const.World.Spawn.Troops.SandGolemMEDIUM.Strength;
			}
		}
		else if (this.m.Size == 1)
		{
			this.getSprite("body").setBrush("bust_golem_body_0" + this.m.Variant + "_small");

			if (!_instant)
			{
				this.setRenderCallbackEnabled(true);
				this.m.ScaleStartTime = this.Time.getVirtualTimeF();
			}

			this.getSprite("status_rooted").Scale = 0.6;
			this.getSprite("status_rooted_back").Scale = 0.6;
			this.setSpriteOffset("status_rooted", this.createVec(-7, 14));
			this.setSpriteOffset("status_rooted_back", this.createVec(-7, 14));

			if (this.m.WorldTroop != null && ("Party" in this.m.WorldTroop) && this.m.WorldTroop.Party != null)
			{
				this.m.WorldTroop.Script = this.Const.World.Spawn.Troops.SandGolem.Script;
				this.m.WorldTroop.Strength = this.Const.World.Spawn.Troops.SandGolem.Strength;
			}
		}

		this.m.SoundPitch = 1.2 - this.m.Size * 0.1;
		this.m.Skills.update();
		this.setDirty(true);
	}

	function onRender()
	{
		this.actor.onRender();

		if (this.m.IsShrinking)
		{
			if (this.m.Size == 2)
			{
				this.getSprite("body").Scale = this.Math.maxf(1.0, 1.04 - 0.04 * ((this.Time.getVirtualTimeF() - this.m.ScaleStartTime) / 0.3));

				if (this.moveSpriteOffset("body", this.createVec(0, 1), this.createVec(0, 0), 0.3, this.m.ScaleStartTime))
				{
					this.setRenderCallbackEnabled(false);
				}
			}
			else if (this.m.Size == 1)
			{
				this.getSprite("body").Scale = this.Math.maxf(1.0, 1.04 - 0.04 * ((this.Time.getVirtualTimeF() - this.m.ScaleStartTime) / 0.3));

				if (this.moveSpriteOffset("body", this.createVec(0, 1), this.createVec(0, 0), 0.3, this.m.ScaleStartTime))
				{
					this.setRenderCallbackEnabled(false);
				}
			}
		}
		else if (this.m.Size == 2)
		{
			this.getSprite("body").Scale = this.Math.minf(1.0, 0.96 + 0.04 * ((this.Time.getVirtualTimeF() - this.m.ScaleStartTime) / 0.3));

			if (this.moveSpriteOffset("body", this.createVec(0, -1), this.createVec(0, 0), 0.3, this.m.ScaleStartTime))
			{
				this.setRenderCallbackEnabled(false);
			}
		}
		else if (this.m.Size == 3)
		{
			this.getSprite("body").Scale = this.Math.minf(1.0, 0.94 + 0.06 * ((this.Time.getVirtualTimeF() - this.m.ScaleStartTime) / 0.3));

			if (this.moveSpriteOffset("body", this.createVec(0, -1), this.createVec(0, 0), 0.3, this.m.ScaleStartTime))
			{
				this.setRenderCallbackEnabled(false);
			}
		}
	}

	function onMovementStep( _tile, _levelDifference )
	{
		for( local i = 0; i < this.Const.Tactical.DustParticles.len(); i = ++i )
		{
			this.Tactical.spawnParticleEffect(false, this.Const.Tactical.DustParticles[i].Brushes, _tile, this.Const.Tactical.DustParticles[i].Delay, this.Const.Tactical.DustParticles[i].Quantity * 0.15 * this.m.Size, this.Const.Tactical.DustParticles[i].LifeTimeQuantity * 0.15 * this.m.Size, this.Const.Tactical.DustParticles[i].SpawnRate, this.Const.Tactical.DustParticles[i].Stages);
		}

		return this.actor.onMovementStep(_tile, _levelDifference);
	}

	function onRemovedFromMap()
	{
		this.actor.onRemovedFromMap();

		if (!this.m.IsAlive && this.m.WorldTroop != null && ("Party" in this.m.WorldTroop) && this.m.WorldTroop.Party != null && !this.m.WorldTroop.Party.isNull())
		{
			this.m.WorldTroop.Party.removeTroop(this.m.WorldTroop);
		}
	}

});

