this.legend_transformed_boar_effect <- this.inherit("scripts/skills/skill", {
	m = {
		TurnsLeft = 5,
		Body = "",
		Head = "",
		Injury = "",
		OriginalFaction = 0,
		OriginalAgent = null,
		OriginalSocket = null,
		Items = []
	},
	function create()
	{
		this.m.ID = "effect.legend_transformed_bear";
		this.m.Name = "Boar Form";
		this.m.Description = "This character is currently a boar";
		this.m.Icon = "ui/perks/bear_circle.png";
		this.m.IconMini = "status_effect_08_mini";
		this.m.Type = this.Const.SkillType.Terrain | this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsHidden = false;
		this.m.IsSerialized = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function getTooltip()
	{
		local ret = this.getDefaultTooltip();
		{
			ret.extend([
				{
					id = 11,
					type = "text",
					icon = "ui/icons/health.png",
					text = "[color=" + this.Const.UI.Color.PositiveValue + "]+100%[/color] stamina recovery rate"
				}
			]);
		}
		return ret;
	}


	function onAdded()
	{
	

		local actor = this.getContainer().getActor();
		local item = actor.getItems().getItemAtSlot(this.Const.ItemSlot.Accessory);
		if (("State" in this.Tactical) && this.Tactical.State != null) {
			if (actor.getTile().IsVisibleForPlayer)
			{
				if (this.Const.Tactical.TransformParticles.len() != 0)
				{
					for( local i = 0; i < this.Const.Tactical.TransformParticles.len(); i = ++i )
					{
						this.Tactical.spawnParticleEffect(false, this.Const.Tactical.TransformParticles[i].Brushes, actor.getTile(), this.Const.Tactical.TransformParticles[i].Delay, this.Const.Tactical.TransformParticles[i].Quantity, this.Const.Tactical.TransformParticles[i].LifeTimeQuantity, this.Const.Tactical.TransformParticles[i].SpawnRate, this.Const.Tactical.TransformParticles[i].Stages);
					}
				}
			}
		}
		
		//change the AI 
		this.m.OriginalAgent = actor.getAIAgent();
		this.m.OriginalFaction = actor.getFaction();
		
		if (actor.isPlayerControlled())
		{
			if (this.m.Container.hasSkill("perk.legend_surpress_urges") && !this.m.Container.hasSkill("perk.legend_control_instincts"))
			{
			// this.logDebug(this.getName() + " AI set to boar");
			// actor.setAIAgent(this.new("scripts/ai/tactical/agents/boar_agent"));
			// actor.getAIAgent().setActor(actor);
			//actor.setFaction(this.Const.Faction.PlayerAnimals);	
			this.logDebug(this.getName() + " has surpress urges, AI set to boar on added");
			actor.setAIAgent(this.new("scripts/ai/tactical/agents/boar_agent"));
			actor.getAIAgent().setActor(actor);			
			
			}
			else if (this.m.Container.hasSkill("perk.legend_surpress_urges") && this.m.Container.hasSkill("perk.legend_control_instincts"))
			{
			this.logDebug(this.getName() + " has control instincts, player retains control on added");
			}
			else	
			{
			this.logDebug(this.getName() + " has no control perks, AI set to boar on added");
			actor.setFaction(this.Const.Faction.Beasts);		
			actor.setAIAgent(this.new("scripts/ai/tactical/agents/boar_agent"));
			actor.getAIAgent().setActor(actor);
			}

		}
		else
		{
		// this.logDebug(this.getName() + " AI set to boar on added");
		// actor.setAIAgent(this.new("scripts/ai/tactical/agents/boar_agent"));
		// actor.getAIAgent().setActor(actor);
		}

	
		this.m.OriginalSocket = actor.getSprite("socket").getBrush().Name;
		actor.getSprite("socket").setBrush("bust_base_beasts");
		actor.setDirty(true);		
		
		// remove items 
		this.logDebug(this.getName() + " removing items");
		local items = actor.getItems();
		if (items.getItemAtSlot(this.Const.ItemSlot.Mainhand))
		{
			local item = items.getItemAtSlot(this.Const.ItemSlot.Mainhand);
			items.unequip(item);
			this.m.Items.push(item);
		}
		if (items.getItemAtSlot(this.Const.ItemSlot.Offhand))
		{
			local item = items.getItemAtSlot(this.Const.ItemSlot.Offhand);
			items.unequip(item);
			this.m.Items.push(item);
		}
		if (items.getItemAtSlot(this.Const.ItemSlot.Body))
		{
			local item = items.getItemAtSlot(this.Const.ItemSlot.Body);
			items.unequip(item);
			this.m.Items.push(item);
		}
		if (items.getItemAtSlot(this.Const.ItemSlot.Head))
		{
			local item = items.getItemAtSlot(this.Const.ItemSlot.Head);
			items.unequip(item);
			this.m.Items.push(item);
		}
		foreach (i in items.getAllItemsAtSlot(this.Const.ItemSlot.Bag))
		{
			items.unequip(i);
			this.m.Items.push(i);
		}

		foreach( i in this.m.Items )
			i.drop(this.getContainer().getActor().getTile());
		foreach( i in this.m.Items )
			i.clearSkills();
		this.m.Body = actor.getSprite("body").getBrush().Name;
		this.m.Head = actor.getSprite("head").getBrush().Name;

		actor.getSprite("body").setBrush("were_boar_body");
		actor.getSprite("head").setBrush("were_boar_head");
		actor.getSprite("injury").setBrush("were_boar_body_injured");
		if (!actor.isPlayerControlled())
		{
			actor.getSprite("body").setHorizontalFlipping(0);
			actor.getSprite("head").setHorizontalFlipping(0);
			actor.getSprite("injury").setHorizontalFlipping(0);
		}
		else
		{
			actor.getSprite("body").setHorizontalFlipping(1);
			actor.getSprite("head").setHorizontalFlipping(1);
			actor.getSprite("injury").setHorizontalFlipping(1);
		}

		actor.getSprite("armor").Alpha = 10;
		actor.getSprite("helmet").Alpha = 10;
		actor.getSprite("shield_icon").Alpha = 10;
		actor.getSprite("armor_layer_chain").Alpha = 10;
		actor.getSprite("armor_layer_plate").Alpha = 10;
		actor.getSprite("armor_layer_tabbard").Alpha = 10;
		actor.getSprite("armor_layer_tabbard").Alpha = 10;
		actor.getSprite("hair").Alpha = 10;
		actor.getSprite("beard").Alpha = 10;
		actor.getSprite("tattoo_head").Alpha = 10;
		actor.getSprite("tattoo_body").Alpha = 10;
		actor.getSprite("quiver").Alpha = 10;
		actor.getSprite("arms_icon").Alpha = 10;
		actor.getSprite("dirt").Alpha = 10;
		actor.getSprite("accessory").Alpha = 10;
		actor.getSprite("surcoat").Alpha = 10;
		actor.getSprite("armor_upgrade_back").Alpha = 10;
		actor.getSprite("armor_upgrade_front").Alpha = 10;
		actor.getSprite("socket").Alpha = 10;
		this.m.TurnsLeft = 3;

		if (this.getContainer().getActor().getSkills().hasSkill("perk.legend_true_form"))
		{
			this.m.TurnsLeft = 6;
		}

		this.m.Container.add(this.new("scripts/skills/actives/legend_boar_gore"));
		this.m.Container.add(this.new("scripts/skills/actives/legend_boar_charge"));
		if (!this.m.Container.hasSkill("actives.footwork"))
		{
			this.m.Container.add(this.new("scripts/skills/actives/footwork"));
		}
		
		this.logDebug(this.getName() + " transformation complete");
	}

	function onRemoved()
	{
		this.removeEffect();
	}
	
	function onCombatFinished()
	{
		this.removeSelf();
		this.removeEffect();
	}


	function onUpdate( _properties )
	{
		_properties.FatigueRecoveryRateMult *= 2.0;
		_properties.StaminaMult *= 1.5;
		_properties.HitpointsMult *= 1.5;
		_properties.BraveryMult *= 1.25;
	}

	function onTurnEnd()
	{
		if (--this.m.TurnsLeft <= 0)
		{
			this.removeSelf();
			this.removeEffect();
			return;
		}
		local actor = this.getContainer().getActor();
		if (!actor.isPlayerControlled() && actor.getAIAgent().getID() != "agent.boar")
		{
			this.logDebug(this.getName() + " AI set to boar on turn end");
			actor.setAIAgent(this.new("scripts/ai/tactical/agents/boar_agent"));
			actor.getAIAgent().setActor(actor);
		}
	}

	function removeEffect()
	{
		local actor = this.getContainer().getActor();
		
		//reset AI
		if (this.m.OriginalAgent != null)
		{
			actor.setAIAgent(this.m.OriginalAgent);
		}
		actor.setFaction(this.m.OriginalFaction);
		actor.getSprite("socket").setBrush(this.m.OriginalSocket);
		actor.setDirty(true);
		
		//change appearance 		
		actor.getSprite("body").setBrush(this.m.Body);
		actor.getSprite("head").setBrush(this.m.Head);
		actor.getSprite("armor").Alpha = 255;
		actor.getSprite("helmet").Alpha = 255;
		actor.getSprite("shield_icon").Alpha = 255;
		actor.getSprite("armor_layer_chain").Alpha = 255;
		actor.getSprite("armor_layer_plate").Alpha = 255;
		actor.getSprite("armor_layer_tabbard").Alpha = 255;
		actor.getSprite("armor_layer_cloak").Alpha = 255;
		actor.getSprite("hair").Alpha = 255;
		actor.getSprite("beard").Alpha = 255;
		actor.getSprite("tattoo_head").Alpha = 255;
		actor.getSprite("tattoo_body").Alpha = 255;
		actor.getSprite("quiver").Alpha = 255;
		actor.getSprite("arms_icon").Alpha = 255;
		actor.getSprite("dirt").Alpha = 255;
		actor.getSprite("accessory").Alpha = 255;
		actor.getSprite("surcoat").Alpha = 255;
		actor.getSprite("armor_upgrade_back").Alpha = 255;
		actor.getSprite("armor_upgrade_front").Alpha = 255;
		actor.getSprite("socket").Alpha = 255;
		if (actor.isPlayerControlled())
		{
			actor.getSprite("body").setHorizontalFlipping(0);
			actor.getSprite("head").setHorizontalFlipping(0);
			actor.getSprite("injury").setHorizontalFlipping(0);
		}
		if (("State" in this.Tactical) && this.Tactical.State != null) {
			local tile = actor.getTile(); //actor.getTile().IsVisibleForPlayer check was erroring, checking a more roundabout way now, not sure if thisis the right fix
			if (tile != null && tile.IsVisibleForPlayer) 
			{
				if (this.Const.Tactical.HideParticles.len() != 0)
				{
					for( local i = 0; i < this.Const.Tactical.HideParticles.len(); i = ++i )
					{
						this.Tactical.spawnParticleEffect(false, this.Const.Tactical.TransformParticles[i].Brushes, actor.getTile(), this.Const.Tactical.TransformParticles[i].Delay, this.Const.Tactical.TransformParticles[i].Quantity, this.Const.Tactical.TransformParticles[i].LifeTimeQuantity, this.Const.Tactical.TransformParticles[i].SpawnRate, this.Const.Tactical.TransformParticles[i].Stages);
					}
				}
			}
		}

		actor.getSkills().removeByID("actives.legend_boar_charge");
		actor.getSkills().removeByID("actives.gore");
		if (!actor.getSkills().hasSkill("perk.footwork"))
		{
			actor.getSkills().removeByID("actives.footwork");
		}
		local items = actor.getItems();
		items.getData()[this.Const.ItemSlot.Offhand][0] = null;
		items.getData()[this.Const.ItemSlot.Mainhand][0] = null;
	}
});

