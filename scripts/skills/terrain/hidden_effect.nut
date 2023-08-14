this.hidden_effect <- this.inherit("scripts/skills/skill", {
	m = {
		ToRemove = false
	}, // CD turns added
	function create()
	{
		this.m.ID = "terrain.hidden";
		this.m.Name = "Hidden";
		this.m.Description = "This character is hidden, being lightly armored will allow the best stealth allowing them to hide in plain sight and not be revealed until directly adjacent to an enemy. Medium armor still allows for some stealth but enemies can hear you coming from 3 tiles away. Heavy armor is just not designed for stealth and enemies will hear you coming from 5 tiles away. Ranged attacks will always reveal at the end of the round.";
		this.m.Icon = "skills/status_effect_08.png";
		this.m.IconMini = "status_effect_08_mini";
		this.m.Type = this.Const.SkillType.Terrain | this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsHidden = false;
		this.m.IsSerialized = false;
	}

	function getDescription()
	{
		local ret = this.m.Description;
		return ret;
	}

	function getTooltip()
	{
		local ret = [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			}
		];

		local actor = this.getContainer().getActor();
		if (actor.getSkills().hasSkill("perk.legend_assassinate"))
		{
			ret.extend([
				{
					id = 11,
					type = "text",
					icon = "ui/icons/regular_damage.png",
					text = "[color=" + this.Const.UI.Color.PositiveValue + "]+50%[/color] Minimum and Maximum Damage from the Assassinate perk"
				}
			]);
		}

		if (actor.getSkills().hasSkill("background.legend_assassin") || actor.getSkills().hasSkill("background.assassin") || actor.getSkills().hasSkill("background.assassin_southern"))
		ret.extend([
			{
				id = 13,
				type = "text",
				icon = "ui/icons/regular_damage.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+50%[/color] Maximum Damage from being an assassin"
			}
		]);

		if (actor.getSkills().hasSkill("background.legend_commander_assassin"))
		ret.extend([
			{
				id = 13,
				type = "text",
				icon = "ui/icons/regular_damage.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+75%[/color] Maximum Damage from being an experienced assassin"
			}
		]);

		if(this.m.ToRemove){
			ret.extend([
				{
					id = 15,
					type = "text",
					text = "Will be revealed at the end of the round"
				}
			]);
		}

		else{
			ret.extend([
				{
					id = 15,
					type = "text",
					text = "Will remain hidden"
				}
			]);
		}

		return ret;
	}

	//added all this missing code from legend_hidden_effect which seemingly controls the hidden graphics--
	function onMovementCompleted( _tile )
	{
		//initialise variables
		local body = 0;
		local head = 0;
		local actor = this.getContainer().getActor();
		
		//get the items
		local bodyItem = this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Body);
		local headItem = this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Head);

		//check if the item exists to stop the error: getStaminaModifier does not exist
		
		if (bodyItem != null)
		{
		//update the variables
		body = bodyItem.getStaminaModifier();
		}
		
		if (headItem != null)
		{	
		head = headItem.getStaminaModifier();
		}
		
		//calculate either on the initial or updated variable
		
		local fat = ::Math.abs(head + body);

		local entites = this.Tactical.Entities.getAllHostilesAsArray();

		local outOfEarshot3 = true;
		if(fat > 15 && fat <=35){

			foreach( unit in entites )
			{
	            if (unit.getID() == actor.getID())
	            {
	                continue;
	            }
				if (unit.getTile().getDistanceTo(_tile) <= 3)
				{
					outOfEarshot3 = false;
					break;
				}
			}

			if (!outOfEarshot3)
			{
				this.m.ToRemove = true;
				effect();
				return;
			}
		}

		local outOfEarshot5 = true;
		if(fat > 35){
			foreach( unit in entites )
			{
	            if (unit.getID() == actor.getID())
	            {
	                continue;
	            }
				if (unit.getTile().getDistanceTo(_tile) <= 5)
				{
					outOfEarshot5 = false;
					break;
				}
			}

			if (!outOfEarshot5)
			{
				this.m.ToRemove = true;
				effect();
				return;
			}
		}
		if(fat <= 15){
			if (_tile.hasZoneOfControlOtherThan(actor.getAlliedFactions()))
			{
				this.m.ToRemove = true;
				effect()
				return;
			}
		}
		// commented: AI can X-ray hidden bros uncommented: No AI X-ray
		this.getContainer().getActor().setHidden(true);
	}

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		this.getContainer().getActor().setHidden(false);
		effect();
		this.m.ToRemove = true;
	}

	function onTargetMissed( _skill, _targetEntity )
	{
		this.getContainer().getActor().setHidden(false);
		effect();
		this.m.ToRemove = true;
	}

	function onAdded()
	{
		local actor = this.getContainer().getActor();
//		actor.setHidden(true);
		if (actor.getTile().IsVisibleForPlayer)
		{
			if (this.Const.Tactical.HideParticles.len() != 0)
			{
				for( local i = 0; i < this.Const.Tactical.HideParticles.len(); i = ++i )
				{
					this.Tactical.spawnParticleEffect(false, this.Const.Tactical.HideParticles[i].Brushes, actor.getTile(), this.Const.Tactical.HideParticles[i].Delay, this.Const.Tactical.HideParticles[i].Quantity, this.Const.Tactical.HideParticles[i].LifeTimeQuantity, this.Const.Tactical.HideParticles[i].SpawnRate, this.Const.Tactical.HideParticles[i].Stages);
				}
			}
		}

		//actor.setBrushAlpha(10);
		//actor.getSprite("hair").Visible = false;
		//actor.getSprite("beard").Visible = false;
		//actor.setHidden(true);
		//actor.setDirty(true);
	}

		function effect()
		{
		local actor = this.getContainer().getActor();
//		actor.setHidden(true);
		if (actor.getTile().IsVisibleForPlayer && this.m.ToRemove == false)
		{
			if (this.Const.Tactical.HideParticles.len() != 0)
			{
				for( local i = 0; i < this.Const.Tactical.HideParticles.len(); i = ++i )
				{
					this.Tactical.spawnParticleEffect(false, this.Const.Tactical.HideParticles[i].Brushes, actor.getTile(), this.Const.Tactical.HideParticles[i].Delay, this.Const.Tactical.HideParticles[i].Quantity, this.Const.Tactical.HideParticles[i].LifeTimeQuantity, this.Const.Tactical.HideParticles[i].SpawnRate, this.Const.Tactical.HideParticles[i].Stages);
				}
			}
		}

		//actor.setBrushAlpha(10);
		//actor.getSprite("hair").Visible = false;
		//actor.getSprite("beard").Visible = false;
		//actor.setHidden(true);
		//actor.setDirty(true);
		}

	function onRemoved()
	{
		this.getContainer().getActor().setHidden(false);
		local actor = this.getContainer().getActor();
		//actor.setBrushAlpha(255);
		//actor.getSprite("hair").Visible = true;
		//actor.getSprite("beard").Visible = true;
		//actor.setDirty(true);
		//foreach (i in actor.getItems().getAllItems())
		//	i.updateAppearance();
		if (!::Tactical.State.isBattleEnded() && actor.isPlacedOnMap()){
			if (actor.getTile().IsVisibleForPlayer)
			{
				if (this.Const.Tactical.HideParticles.len() != 0)
				{
					for( local i = 0; i < this.Const.Tactical.HideParticles.len(); i = ++i )
					{
						this.Tactical.spawnParticleEffect(false, this.Const.Tactical.HideParticles[i].Brushes, actor.getTile(), this.Const.Tactical.HideParticles[i].Delay, this.Const.Tactical.HideParticles[i].Quantity, this.Const.Tactical.HideParticles[i].LifeTimeQuantity, this.Const.Tactical.HideParticles[i].SpawnRate, this.Const.Tactical.HideParticles[i].Stages);
					}
				}
			}
		}
	}
	// added graphics control code end here --

	function onUpdate( _properties )
	{
		local actor = this.getContainer().getActor();
        if (actor.getSkills().hasSkill("perk.legend_assassinate"))
        {
            _properties.DamageRegularMin *= 1.2;
            _properties.DamageRegularMax *= 1.2;

            if (actor.getSkills().hasSkill("background.legend_assassin") || actor.getSkills().hasSkill("background.assassin") || actor.getSkills().hasSkill("background.assassin_southern"))
            {
                _properties.DamageRegularMax *= 1.3;
            }
            if (actor.getSkills().hasSkill("background.legend_commander_assassin"))
            {
                _properties.DamageRegularMax *= 1.5;
            }
        }
        //this missing for graphics start --
        //actor.setBrushAlpha(10);
		//actor.getSprite("hair").Visible = false;
		//actor.getSprite("beard").Visible = false;
		//actor.setHidden(true);
		//actor.setDirty(true);
		// end --
	}
    // added missing turn end graphics control --
	function onRoundEnd()
	{
		if (this.m.ToRemove)
		{
			this.getContainer().getActor().setHidden(false);
			this.removeSelf();
		}
	}

	function onCombatFinished()
	{
		this.removeSelf();
		this.m.IsHidden = true;
	}
});
