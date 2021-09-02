this.human <- this.inherit("scripts/entity/tactical/actor", {
	m = {
		Bodies = this.Const.Bodies.AllMale,
		Faces = null,
		Hairs = null,
		HairColors = null,
		Beards = null,
		BeardChance = 60,
		Body = 0,
		Surcoat = null,
		Ethnicity = 0,
		Gender = 0,
		VoiceSet = 0,
		IsEyesClosed = false,
		NextBlinkTime = 0.0
	},
	function getEthnicity()
	{
		return this.m.Ethnicity;
	}

	function setEyesClosed( _f )
	{
		this.m.IsEyesClosed = _f;
	}

	function create()
	{
		this.actor.create();
		this.setGender(0);
		this.getFlags().add("human");
	}

	function getPronoun(_neuter)
	{
		return this.Const.LegendMod.getPronoun(this.getGender(), _neuter);
	}

	// -1 = Default Male, 0 = Male, 1 = Female
	function getGender()
	{
		return this.m.Gender;
	}

	function setGender( _v, _reroll = true)
	{

		if ("LegendMod" in this.World && !this.LegendsMod.Configs().LegendGenderEnabled())
		{
			_v = 0;
		}

		this.m.Gender = _v
		if(this.m.Gender == 1)
		{
			this.m.Faces = this.Const.Faces.AllFemale;
			this.m.Beards = null;
			this.m.Bodies = this.Const.Bodies.AllFemale;
			this.m.BeardChance = 0;
			this.m.Hairs = this.Const.Hair.AllFemale;
			if (this.m.Ethnicity == 1)
			{
				this.m.Bodies = this.Const.Bodies.SouthernFemale;
				this.m.Faces = this.Const.Faces.SouthernFemale;
				this.m.Hairs = this.Const.Hair.SouthernFemale;
				this.m.HairColors = this.Const.HairColors.Southern;
			}

			if (_reroll)
			{
				this.m.VoiceSet = this.Math.rand(0, this.Const.WomanSounds.len() - 1);
				this.m.Body = this.Math.rand(0, this.m.Bodies.len() - 1);
			}

			this.m.Sound[this.Const.Sound.ActorEvent.NoDamageReceived] = this.Const.WomanSounds[this.m.VoiceSet].NoDamageReceived;
			this.m.Sound[this.Const.Sound.ActorEvent.DamageReceived] = this.Const.WomanSounds[this.m.VoiceSet].DamageReceived;
			this.m.Sound[this.Const.Sound.ActorEvent.Death] = this.Const.WomanSounds[this.m.VoiceSet].Death;
			this.m.Sound[this.Const.Sound.ActorEvent.Flee] = this.Const.WomanSounds[this.m.VoiceSet].Flee;
			this.m.Sound[this.Const.Sound.ActorEvent.Fatigue] = this.Const.WomanSounds[this.m.VoiceSet].Fatigue;
			this.m.SoundPitch = this.Math.rand(105, 115) * 0.01;
		}
		else
		{
			if (_reroll)
			{
				this.m.VoiceSet = this.Math.rand(0, this.Const.HumanSounds.len() - 1);
				this.m.Body = this.Math.rand(0, this.m.Bodies.len() - 1);
			}
			this.m.Sound[this.Const.Sound.ActorEvent.NoDamageReceived] = this.Const.HumanSounds[this.m.VoiceSet].NoDamageReceived;
			this.m.Sound[this.Const.Sound.ActorEvent.DamageReceived] = this.Const.HumanSounds[this.m.VoiceSet].DamageReceived;
			this.m.Sound[this.Const.Sound.ActorEvent.Death] = this.Const.HumanSounds[this.m.VoiceSet].Death;
			this.m.Sound[this.Const.Sound.ActorEvent.Flee] = this.Const.HumanSounds[this.m.VoiceSet].Fatigue;
			this.m.Sound[this.Const.Sound.ActorEvent.Fatigue] = this.Const.HumanSounds[this.m.VoiceSet].Fatigue;
			this.m.SoundPitch = this.Math.rand(95, 105) * 0.01;
		}

		this.m.SoundVolume[this.Const.Sound.ActorEvent.NoDamageReceived] = 1.4;
		this.m.SoundVolume[this.Const.Sound.ActorEvent.DamageReceived] = 1.5;
		this.m.SoundVolume[this.Const.Sound.ActorEvent.Death] = 1.5;
		this.m.SoundVolume[this.Const.Sound.ActorEvent.Flee] = 1.1;
		this.m.SoundVolume[this.Const.Sound.ActorEvent.Fatigue] = 0.95;
	}

	function playSound( _type, _volume, _pitch = 1.0 )
	{
		if (this.m.Sound[_type].len() == 0)
		{
			return;
		}

		local volume = 1.0;
		if(this.m.Gender == 1)
		{
			if (this.m.VoiceSet > this.Const.WomanSounds.len() - 1)
			{
				this.m.VoiceSet = this.Math.rand(0, this.Const.WomanSounds.len() - 1);
			}
			volume *= this.Const.WomanSounds[this.m.VoiceSet].Volume
		}
		else
		{
			volume *= this.Const.HumanSounds[this.m.VoiceSet].Volume
		}

		this.Sound.play(this.m.Sound[_type][this.Math.rand(0, this.m.Sound[_type].len() - 1)], volume, this.getPos(), _pitch);
	}

	function onUpdateInjuryLayer()
	{
		if (!this.hasSprite("injury"))
		{
			return;
		}

		local injury = this.getSprite("injury");
		local injury_body = this.getSprite("injury_body");
		local p = this.m.Hitpoints / this.getHitpointsMax();

		if (p > 0.66)
		{
			this.setDirty(this.m.IsDirty || injury.Visible || injury_body.Visible);
			injury.Visible = false;
			injury_body.Visible = false;
		}
		else
		{
			this.setDirty(this.m.IsDirty || !injury.Visible || !injury_body.Visible);
			injury.Visible = true;
			injury_body.Visible = true;

			if (p > 0.33)
			{
				injury.setBrush("bust_head_injured_01");
			}
			else
			{
				injury.setBrush("bust_head_injured_02");
			}

			if (p > 0.4)
			{
				injury_body.Visible = false;
			}
			else
			{
				injury_body.Visible = true;
			}
		}
	}

	function onDeath( _killer, _skill, _tile, _fatalityType )
	{
		local isResurrectable = _fatalityType == this.Const.FatalityType.None || _fatalityType == this.Const.FatalityType.Disemboweled;
		local appearance = this.getItems().getAppearance();
		appearance.HideHair = false;
		local flip = this.Math.rand(0, 100) < 50;
		this.m.IsCorpseFlipped = flip;

		if (_tile != null)
		{
			local sprite_body = this.getSprite("body");
			local sprite_head = this.getSprite("head");
			local sprite_hair = this.getSprite("hair");
			local sprite_beard = this.getSprite("beard");
			local sprite_beard_top = this.getSprite("beard_top");
			local sprite_surcoat = this.getSprite("surcoat");
			local sprite_accessory = this.getSprite("accessory");
			local sprite_accessory_special = this.getSprite("accessory_special");
			local sprite_body_tattoo = this.getSprite("tattoo_body");
			local sprite_head_tattoo = this.getSprite("tattoo_head");
			local decal = _tile.spawnDetail(sprite_body.getBrush().Name + "_dead", this.Const.Tactical.DetailFlag.Corpse, flip, false, this.Const.Combat.HumanCorpseOffset);
			decal.Color = sprite_head.Color;
			decal.Saturation = sprite_head.Saturation;
			decal.Scale = 0.9;
			decal.setBrightness(0.9);

			if (sprite_body_tattoo.HasBrush && this.doesBrushExist(sprite_body_tattoo.getBrush().Name + "_dead"))
			{
				local decal = _tile.spawnDetail(sprite_body_tattoo.getBrush().Name + "_dead", this.Const.Tactical.DetailFlag.Corpse, flip, false, this.Const.Combat.HumanCorpseOffset);
				decal.Color = sprite_head.Color;
				decal.Saturation = sprite_head.Saturation;
				decal.Scale = 0.9;
				decal.setBrightness(0.9);
			}

			if (appearance.CorpseArmor != "")
			{
				decal = _tile.spawnDetail(appearance.CorpseArmor, this.Const.Tactical.DetailFlag.Corpse, flip, false, this.Const.Combat.HumanCorpseOffset);
				decal.Scale = 0.9;
				decal.setBrightness(0.9);
			}

			if (this.m.Surcoat != null)
			{
				decal = _tile.spawnDetail("surcoat_" + (this.m.Surcoat < 10 ? "0" + this.m.Surcoat : this.m.Surcoat) + "_dead", this.Const.Tactical.DetailFlag.Corpse, flip, false, this.Const.Combat.HumanCorpseOffset);
				decal.Scale = 0.9;
				decal.setBrightness(0.9);
			}

			if (appearance.CorpseArmorUpgradeBack != "")
			{
				decal = _tile.spawnDetail(appearance.CorpseArmorUpgradeBack, this.Const.Tactical.DetailFlag.Corpse, flip, false, this.Const.Combat.HumanCorpseOffset);
				decal.Scale = 0.9;
				decal.setBrightness(0.9);
			}

			if (sprite_accessory.HasBrush && this.doesBrushExist(sprite_accessory.getBrush().Name + "_dead"))
			{
				decal = _tile.spawnDetail(sprite_accessory.getBrush().Name + "_dead", this.Const.Tactical.DetailFlag.Corpse, flip, false, this.Const.Combat.HumanCorpseOffset);
				decal.Scale = 0.9;
				decal.setBrightness(0.9);
			}

			if (sprite_accessory_special.HasBrush && this.doesBrushExist(sprite_accessory_special.getBrush().Name + "_dead"))
			{
				decal = _tile.spawnDetail(sprite_accessory_special.getBrush().Name + "_dead", this.Const.Tactical.DetailFlag.Corpse, flip, false, this.Const.Combat.HumanCorpseOffset);
				decal.Scale = 0.9;
				decal.setBrightness(0.9);
			}

			if (_fatalityType == this.Const.FatalityType.None && (!_skill || _skill.getProjectileType() == this.Const.ProjectileType.None) && this.Math.rand(1, 100) <= 33)
			{
				decal = _tile.spawnDetail("dead_body_splatter", this.Const.Tactical.DetailFlag.Corpse, flip, false, this.Const.Combat.HumanCorpseOffset);
				decal.Alpha = 160;
			}

			if (_fatalityType == this.Const.FatalityType.Disemboweled)
			{
				decal = _tile.spawnDetail("bust_body_guts_0" + this.Math.rand(1, 3), this.Const.Tactical.DetailFlag.Corpse, flip, false, this.Const.Combat.HumanCorpseOffset);
				decal.Scale = 0.9;
			}
			else if (_skill && _skill.getProjectileType() == this.Const.ProjectileType.Arrow)
			{
				if (appearance.CorpseArmor != "")
				{
					decal = _tile.spawnDetail(appearance.CorpseArmor + "_arrows", this.Const.Tactical.DetailFlag.Corpse, flip, false, this.Const.Combat.HumanCorpseOffset);
				}
				else
				{
					decal = _tile.spawnDetail(appearance.Corpse + "_arrows", this.Const.Tactical.DetailFlag.Corpse, flip, false, this.Const.Combat.HumanCorpseOffset);
				}

				decal.Scale = 0.9;
			}
			else if (_skill && _skill.getProjectileType() == this.Const.ProjectileType.Javelin)
			{
				if (appearance.CorpseArmor != "")
				{
					decal = _tile.spawnDetail(appearance.CorpseArmor + "_javelin", this.Const.Tactical.DetailFlag.Corpse, flip, false, this.Const.Combat.HumanCorpseOffset);
				}
				else
				{
					decal = _tile.spawnDetail(appearance.Corpse + "_javelin", this.Const.Tactical.DetailFlag.Corpse, flip, false, this.Const.Combat.HumanCorpseOffset);
				}

				decal.Scale = 0.9;
			}

			if (_fatalityType != this.Const.FatalityType.Decapitated)
			{
				if (!appearance.HideCorpseHead)
				{
					local decal = _tile.spawnDetail(sprite_head.getBrush().Name + "_dead", this.Const.Tactical.DetailFlag.Corpse, flip, false, this.Const.Combat.HumanCorpseOffset);
					decal.Color = sprite_head.Color;
					decal.Saturation = sprite_head.Saturation;
					decal.Scale = 0.9;
					decal.setBrightness(0.9);
				}

				if (sprite_head_tattoo.HasBrush && this.doesBrushExist(sprite_head_tattoo.getBrush().Name + "_dead"))
				{
					local decal = _tile.spawnDetail(sprite_head_tattoo.getBrush().Name + "_dead", this.Const.Tactical.DetailFlag.Corpse, flip, false, this.Const.Combat.HumanCorpseOffset);
					decal.Color = sprite_head.Color;
					decal.Saturation = sprite_head.Saturation;
					decal.Scale = 0.9;
					decal.setBrightness(0.9);
				}

				if (!appearance.HideBeard && !appearance.HideCorpseHead && sprite_beard.HasBrush)
				{
					local decal = _tile.spawnDetail(sprite_beard.getBrush().Name + "_dead", this.Const.Tactical.DetailFlag.Corpse, flip, false, this.Const.Combat.HumanCorpseOffset);
					decal.Color = sprite_beard.Color;
					decal.Saturation = sprite_beard.Saturation;
					decal.Scale = 0.9;
					decal.setBrightness(0.9);

					if (sprite_beard_top.HasBrush)
					{
						local decal = _tile.spawnDetail(sprite_beard_top.getBrush().Name + "_dead", this.Const.Tactical.DetailFlag.Corpse, flip, false, this.Const.Combat.HumanCorpseOffset);
						decal.Color = sprite_beard.Color;
						decal.Saturation = sprite_beard.Saturation;
						decal.Scale = 0.9;
						decal.setBrightness(0.9);
					}
				}

				if (!appearance.HideHair && !appearance.HideCorpseHead && sprite_hair.HasBrush)
				{
					local decal = _tile.spawnDetail(sprite_hair.getBrush().Name + "_dead", this.Const.Tactical.DetailFlag.Corpse, flip, false, this.Const.Combat.HumanCorpseOffset);
					decal.Color = sprite_hair.Color;
					decal.Saturation = sprite_hair.Saturation;
					decal.Scale = 0.9;
					decal.setBrightness(0.9);
				}

				if (_fatalityType == this.Const.FatalityType.Smashed)
				{
					decal = _tile.spawnDetail("bust_head_smashed_01", this.Const.Tactical.DetailFlag.Corpse, flip, false, this.Const.Combat.HumanCorpseOffset);
					decal.Scale = 0.9;
				}
				else if (appearance.HelmetCorpse != "")
				{
					local decal = _tile.spawnDetail(this.getItems().getAppearance().HelmetCorpse, this.Const.Tactical.DetailFlag.Corpse, flip, false, this.Const.Combat.HumanCorpseOffset);
					if (decal != null)
					{
						decal.Scale = 0.9;
						decal.setBrightness(0.9);
					}
				}
			}
			else if (_fatalityType == this.Const.FatalityType.Decapitated)
			{
				local layers = [];

				if (!appearance.HideCorpseHead)
				{
					layers.push(sprite_head.getBrush().Name + "_dead");
				}

				if (!appearance.HideCorpseHead && sprite_head_tattoo.HasBrush && this.doesBrushExist(sprite_head_tattoo.getBrush().Name + "_dead"))
				{
					layers.push(sprite_head_tattoo.getBrush().Name + "_dead");
				}

				if (!appearance.HideBeard && sprite_beard.HasBrush)
				{
					layers.push(sprite_beard.getBrush().Name + "_dead");
				}

				if (!appearance.HideHair && sprite_hair.HasBrush)
				{
					layers.push(sprite_hair.getBrush().Name + "_dead");
				}

				if (appearance.HelmetCorpse.len() != 0)
				{
					layers.push(appearance.HelmetCorpse);
				}

				if (!appearance.HideBeard && sprite_beard_top.HasBrush)
				{
					layers.push(sprite_beard_top.getBrush().Name + "_dead");
				}

				local decap = this.Tactical.spawnHeadEffect(this.getTile(), layers, this.createVec(0, 0), -90.0, "bust_head_dead_bloodpool");
				local idx = 0;

				if (!appearance.HideCorpseHead)
				{
					decap[idx].Color = sprite_head.Color;
					decap[idx].Saturation = sprite_head.Saturation;
					decap[idx].Scale = 0.9;
					decap[idx].setBrightness(0.9);
					idx = ++idx;
				}

				if (!appearance.HideCorpseHead && sprite_head_tattoo.HasBrush && this.doesBrushExist(sprite_head_tattoo.getBrush().Name + "_dead"))
				{
					decap[idx].Scale = 0.9;
					decap[idx].setBrightness(0.9);
					idx = ++idx;
				}

				if (!appearance.HideBeard && sprite_beard.HasBrush)
				{
					decap[idx].Color = sprite_beard.Color;
					decap[idx].Saturation = sprite_beard.Saturation;
					decap[idx].Scale = 0.9;
					decap[idx].setBrightness(0.9);
					idx = ++idx;
				}

				if (!appearance.HideHair && sprite_hair.HasBrush)
				{
					decap[idx].Color = sprite_hair.Color;
					decap[idx].Saturation = sprite_hair.Saturation;
					decap[idx].Scale = 0.9;
					decap[idx].setBrightness(0.9);
					idx = ++idx;
				}

				if (appearance.HelmetCorpse.len() != 0)
				{
					decap[idx].Scale = 0.9;
					decap[idx].setBrightness(0.9);
					idx = ++idx;
				}

				if (!appearance.HideBeard && sprite_beard_top.HasBrush)
				{
					decap[idx].Color = sprite_beard.Color;
					decap[idx].Saturation = sprite_beard.Saturation;
					decap[idx].Scale = 0.9;
					decap[idx].setBrightness(0.9);
				}
			}

			if (appearance.CorpseArmorUpgradeFront != "")
			{
				decal = _tile.spawnDetail(appearance.CorpseArmorUpgradeFront, this.Const.Tactical.DetailFlag.Corpse, flip, false, this.Const.Combat.HumanCorpseOffset);
				decal.Scale = 0.9;
				decal.setBrightness(0.9);
			}

			this.spawnTerrainDropdownEffect(_tile);
			this.spawnFlies(_tile);
			local custom = {
				IsZombified = false,
				InjuryType = 4,
				Face = sprite_head.getBrush().Name,
				Body = sprite_body.getBrush().Name,
				TattooBody = null,
				TattooHead = null,
				Hair = sprite_hair.HasBrush ? sprite_hair.getBrush().Name : null,
				HairColor = sprite_hair.Color,
				HairSaturation = sprite_hair.Saturation,
				Beard = sprite_beard.HasBrush ? sprite_beard.getBrush().Name : null,
				Surcoat = this.m.Surcoat,
				Ethnicity = this.m.Ethnicity
			};
			local corpse = clone this.Const.Corpse;
			corpse.Type = "scripts/entity/tactical/enemies/zombie_player";
			corpse.Faction = this.getFaction();
			corpse.CorpseName = this.getName();
			corpse.Tile = _tile;
			corpse.Value = 8.0;
			corpse.Hitpoints = 1.0;
			corpse.IsResurrectable = isResurrectable;
			corpse.IsConsumable = _fatalityType != this.Const.FatalityType.Unconscious;
			corpse.Armor = this.m.BaseProperties.Armor;
			corpse.Name = "Wiederganger " + this.getName();
			corpse.Items = _fatalityType != this.Const.FatalityType.Unconscious ? this.getItems() : null;
			corpse.Color = sprite_head.Color;
			corpse.Saturation = sprite_head.Saturation;
			corpse.Custom = custom;
			corpse.IsHeadAttached = _fatalityType != this.Const.FatalityType.Decapitated;

			corpse.isHuman = 1;

			_tile.Properties.set("Corpse", corpse);
			this.Tactical.Entities.addCorpse(_tile);
		}

		if (_fatalityType != this.Const.FatalityType.Unconscious)
		{
			this.getItems().dropAll(_tile, _killer, !flip);
		}

		if (_tile != null && !this.Tactical.State.isScenarioMode() && !this.Tactical.State.getStrategicProperties().IsArenaMode && this.World.FactionManager.isUndeadScourge() && isResurrectable && this.Math.rand(1, 100) <= 33)
		{
			local corpse = _tile.Properties.get("Corpse");
			corpse.Faction = this.World.FactionManager.getFactionOfType(this.Const.FactionType.Zombies).getID();
			corpse.Hitpoints = 1.0;
			corpse.Items = this.getItems();
			corpse.IsConsumable = false;
			corpse.IsResurrectable = false;
			this.Time.scheduleEvent(this.TimeUnit.Rounds, this.Math.rand(2, 3), this.Tactical.Entities.resurrect, corpse);
		}

		this.actor.onDeath(_killer, _skill, _tile, _fatalityType);
	}

	function onFactionChanged()
	{
		this.actor.onFactionChanged();
		local flip = !this.isAlliedWithPlayer();
		this.getSprite("background").setHorizontalFlipping(flip);
		this.getSprite("quiver").setHorizontalFlipping(flip);
		this.getSprite("body").setHorizontalFlipping(flip);
		this.getSprite("tattoo_body").setHorizontalFlipping(flip);
		this.getSprite("injury_body").setHorizontalFlipping(flip);
		this.getSprite("armor").setHorizontalFlipping(flip);
		this.getSprite("armor_layer_chain").setHorizontalFlipping(flip);
		this.getSprite("armor_layer_plate").setHorizontalFlipping(flip);
		this.getSprite("armor_layer_tabbard").setHorizontalFlipping(flip);
		this.getSprite("armor_layer_cloak").setHorizontalFlipping(flip);
		this.getSprite("surcoat").setHorizontalFlipping(flip);
		this.getSprite("armor_upgrade_back").setHorizontalFlipping(flip);
		this.getSprite("armor_upgrade_front").setHorizontalFlipping(flip);
		this.getSprite("shaft").setHorizontalFlipping(flip);
		this.getSprite("head").setHorizontalFlipping(flip);
		this.getSprite("closed_eyes").setHorizontalFlipping(flip);
		this.getSprite("eye_rings").setHorizontalFlipping(flip);
		this.getSprite("tattoo_head").setHorizontalFlipping(flip);
		this.getSprite("injury").setHorizontalFlipping(flip);
		this.getSprite("beard").setHorizontalFlipping(flip);
		this.getSprite("hair").setHorizontalFlipping(flip);

		foreach (a in this.Const.CharacterSprites.Helmets)
		{
			if (!this.hasSprite(a))
			{
				continue;
			}
			this.getSprite(a).setHorizontalFlipping(flip);
		}

		this.getSprite("beard_top").setHorizontalFlipping(flip);
		this.getSprite("body_blood").setHorizontalFlipping(flip);
		this.getSprite("accessory").setHorizontalFlipping(flip);
		this.getSprite("accessory_special").setHorizontalFlipping(flip);
		this.getSprite("dirt").setHorizontalFlipping(flip);
		this.getSprite("permanent_injury_1").setHorizontalFlipping(flip);
		this.getSprite("permanent_injury_2").setHorizontalFlipping(flip);
		this.getSprite("permanent_injury_3").setHorizontalFlipping(flip);
		this.getSprite("permanent_injury_4").setHorizontalFlipping(flip);
		this.getSprite("permanent_injury_scarred").setHorizontalFlipping(flip);
		this.getSprite("permanent_injury_burned").setHorizontalFlipping(flip);
		this.getSprite("bandage_1").setHorizontalFlipping(flip);
		this.getSprite("bandage_2").setHorizontalFlipping(flip);
		this.getSprite("bandage_3").setHorizontalFlipping(flip);
	}

	function updateInjuryVisuals( _setDirty = true )
	{
		local injuries = this.getSkills().query(this.Const.SkillType.Injury);
		this.getSprite("bandage_1").Visible = false;
		this.getSprite("bandage_1").setBrush("bandage_01");
		this.getSprite("bandage_2").Visible = false;
		this.getSprite("bandage_2").setBrush("bandage_02");
		this.getSprite("bandage_3").Visible = false;
		this.getSprite("bandage_3").setBrush("bandage_03");

		foreach( inj in injuries )
		{
			inj.showInjury();
		}

		this.setDirty(_setDirty);
	}

	function onInit()
	{
		this.actor.onInit();
		this.m.ActionPointCosts = this.Const.DefaultMovementAPCost;
		this.m.FatigueCosts = this.Const.DefaultMovementFatigueCost;
		local app = this.getItems().getAppearance();
		app.Quiver = this.Const.Items.Default.PlayerQuiver;
		app.Body = this.m.Bodies[this.m.Body];
		app.Corpse = this.m.Bodies[this.m.Body] + "_dead";
		this.addSprite("background");
		this.addSprite("socket").setBrush("bust_base_player");
		this.addSprite("quiver");
		local body = this.addSprite("body");
		body.setBrush(this.m.Bodies[this.m.Body]);
		this.addSprite("tattoo_body");
		this.addSprite("scar_body");
		local injury_body = this.addSprite("injury_body");
		injury_body.Visible = false;
		injury_body.setBrush("bust_naked_body_0" + this.m.Body + "_injured");
		this.addSprite("armor");
		this.addSprite("armor_layer_chain");
		this.addSprite("armor_layer_plate");
		this.addSprite("armor_layer_tabbard");
		this.addSprite("surcoat");
		this.addSprite("armor_layer_cloak");
		this.addSprite("armor_upgrade_back");
		local bandage2 = this.addSprite("bandage_2");
		bandage2.Visible = false;
		bandage2.setBrush("bandage_clean_02");
		local bandage3 = this.addSprite("bandage_3");
		bandage3.Visible = false;
		bandage3.setBrush("bandage_clean_03");
		this.addSprite("shaft");
		this.addSprite("head");
		local eye_rings = this.addSprite("eye_rings");
		eye_rings.setBrush("bust_eye_rings");
		eye_rings.Visible = false;
		local closed_eyes = this.addSprite("closed_eyes");
		closed_eyes.setBrush("sleep_eyes");
		closed_eyes.Visible = false;
		this.addSprite("tattoo_head");
		this.addSprite("scar_head");
		this.addSprite("injury").Visible = false;
		this.addSprite("permanent_injury_3");
		this.addSprite("permanent_injury_2");
		this.addSprite("permanent_injury_scarred");
		this.addSprite("permanent_injury_burned");
		local beard = this.addSprite("beard");
		local hair = this.addSprite("hair");
		this.addSprite("permanent_injury_4");
		this.addSprite("permanent_injury_1");

		foreach (a in this.Const.CharacterSprites.Helmets)
		{
			this.addSprite(a)
		}

		this.addSprite("accessory");
		this.addSprite("accessory_special");
		local beard_top = this.addSprite("beard_top");
		this.addSprite("armor_upgrade_front");
		local bandage1 = this.addSprite("bandage_1");
		bandage1.Visible = false;
		bandage1.setBrush("bandage_clean_01");
		local body_blood = this.addSprite("body_blood");
		body_blood.setBrush("bust_body_bloodied_02");
		body_blood.Visible = false;
		local body_dirt = this.addSprite("dirt");
		body_dirt.setBrush("bust_body_dirt_02");
		body_dirt.Visible = false;
		this.addDefaultStatusSprites();
		this.getSprite("status_rooted").Scale = 0.55;
		this.setSpriteOffset("status_rooted", this.createVec(0, 5));
		this.m.Skills.add(this.new("scripts/skills/actives/hand_to_hand"));

		if (this.Const.DLC.Unhold)
		{
			this.m.Skills.add(this.new("scripts/skills/actives/wake_ally_skill"));
		}

		this.m.Skills.add(this.new("scripts/skills/special/double_grip"));
		this.m.Skills.add(this.new("scripts/skills/effects/captain_effect"));
		this.m.Skills.add(this.new("scripts/skills/effects/legend_demon_hound_aura_effect"));
	}

	function setAppearance()
	{
		if (this.m.HairColors == null)
		{
			return;
		}

		local hairColor = this.m.HairColors[this.Math.rand(0, this.m.HairColors.len() - 1)];

		if (this.m.Faces != null)
		{
			local sprite = this.getSprite("head");
			sprite.setBrush(this.m.Faces[this.Math.rand(0, this.m.Faces.len() - 1)]);
			sprite.Color = this.createColor("#fbffff");
			sprite.varyColor(0.05, 0.05, 0.05);
			sprite.varySaturation(0.1);
			local body = this.getSprite("body");
			body.Color = sprite.Color;
			body.Saturation = sprite.Saturation;
		}

		if (this.m.Hairs != null && this.Math.rand(0, this.m.Hairs.len()) != this.m.Hairs.len())
		{
			local sprite = this.getSprite("hair");
			sprite.setBrush("hair_" + hairColor + "_" + this.m.Hairs[this.Math.rand(0, this.m.Hairs.len() - 1)]);

			if (hairColor != "grey")
			{
				sprite.varyColor(0.1, 0.1, 0.1);
			}
			else
			{
				sprite.varyBrightness(0.1);
			}
		}
		else
		{
			this.getSprite("hair").Visible = false;
		}

		if (this.m.Beards != null && this.Math.rand(1, 100) <= this.m.BeardChance)
		{
			local beard = this.getSprite("beard");
			beard.setBrush("beard_" + hairColor + "_" + this.m.Beards[this.Math.rand(0, this.m.Beards.len() - 1)]);
			beard.Color = this.getSprite("hair").Color;

			if (this.doesBrushExist(beard.getBrush().Name + "_top"))
			{
				local sprite = this.getSprite("beard_top");
				sprite.setBrush(beard.getBrush().Name + "_top");
				sprite.Color = this.getSprite("hair").Color;
			}
		}
		else
		{
			this.getSprite("beard").Visible = false;
		}

		if (this.m.Ethnicity == 1 && hairColor != "grey")
		{
			local hair = this.getSprite("hair");
			hair.Saturation = 0.8;
			hair.setBrightness(0.4);
			local beard = this.getSprite("beard");
			beard.Color = hair.Color;
			beard.Saturation = hair.Saturation;
			local beard_top = this.getSprite("beard_top");
			beard_top.Color = hair.Color;
			beard_top.Saturation = hair.Saturation;
		}
	}

	function setArmorAlpha(level)
	{
		foreach (a in this.Const.CharacterSprites.Armor)
		{
			if (!this.hasSprite(a))
			{
				continue;
			}
			this.getSprite(a).Alpha = level;
		}
	}

	function setArmorSaturation(level)
	{
		foreach (a in this.Const.CharacterSprites.Armor)
		{
			if (!this.hasSprite(a))
			{
				continue;
			}
			this.getSprite(a).Saturation = level;
		}
	}

	function setArmorBrightness(level)
	{
		foreach (a in this.Const.CharacterSprites.Armor)
		{
			if (!this.hasSprite(a))
			{
				continue;
			}
			this.getSprite(a).setBrightness(level);
		}
	}

	function setBrushAlpha(level)
	{
		this.setArmorAlpha(10);
		foreach (a in this.Const.CharacterSprites.Human)
		{
			if (!this.hasSprite(a))
			{
				continue;
			}
			this.getSprite(a).Alpha = level;
		}
	}

	function onDamageReceived( _attacker, _skill, _hitInfo )
	{
		if (_hitInfo.DamageRegular == 0 && _hitInfo.DamageArmor == 0)
		{
			return 0;
		}

		if (this.m.Surcoat != null && this.getSprite("surcoat").HasBrush)
		{
			this.getSprite("surcoat").setBrush("surcoat_" + (this.m.Surcoat < 10 ? "0" + this.m.Surcoat : this.m.Surcoat) + "_damaged");
		}

		this.actor.onDamageReceived(_attacker, _skill, _hitInfo);
	}

	function onSerialize( _out )
	{
		this.actor.onSerialize(_out);
		if (this.m.Surcoat != null)
		{
			_out.writeU8(this.m.Surcoat);
		}
		else
		{
			_out.writeU8(0);
		}

		_out.writeU8(this.m.Ethnicity);
		_out.writeU8(this.m.Gender);
		_out.writeU8(this.m.VoiceSet);
		_out.writeU8(this.m.Body);
		_out.writeBool(false);
	}

	function onDeserialize( _in )
	{
		this.actor.onDeserialize(_in);
		this.m.Surcoat = _in.readU8();

		if (this.m.Surcoat == 0)
		{
			this.m.Surcoat = null;
		}

		this.m.Ethnicity = _in.readU8();
		this.m.Gender = _in.readU8();
		this.m.VoiceSet = _in.readU8();
		this.m.Body = _in.readU8();
		this.setGender(this.m.Gender, false)
		_in.readBool();
	}

});

