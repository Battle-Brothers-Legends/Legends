this.legend_transformed_tree_effect <- this.inherit("scripts/skills/skill", {
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
		this.m.ID = "effect.legend_transformed_tree";
		this.m.Name = "Tree Form";
		this.m.Description = "This character is currently a schrat";
		this.m.Icon = "ui/perks/tree_circle.png";
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
					icon = "ui/icons/special.png",
					text = " Can regenerate shield"
				}
			]);
		}




		return ret;

	}


	function onAdded()
	{


		local actor = this.getContainer().getActor();
		if (("State" in this.Tactical) && this.Tactical.State != null) {
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

		//change the AI
		this.m.OriginalAgent = actor.getAIAgent();
		this.m.OriginalFaction = actor.getFaction();

		if (actor.isPlayerControlled())
		{
			if (this.m.Container.hasSkill("perk.legend_surpress_urges") && !this.m.Container.hasSkill("perk.legend_control_instincts"))
			{
			actor.setAIAgent(this.new("scripts/ai/tactical/agents/schrat_agent"));
			actor.getAIAgent().setActor(actor);
			}
			else if (this.m.Container.hasSkill("perk.legend_surpress_urges") && this.m.Container.hasSkill("perk.legend_control_instincts"))
			{
			}
			else
			{
			actor.setFaction(this.Const.Faction.Beasts);
			actor.setAIAgent(this.new("scripts/ai/tactical/agents/schrat_agent"));
			actor.getAIAgent().setActor(actor);
			}

		}
		else
		{
		}

		this.m.OriginalSocket = actor.getSprite("socket").getBrush().Name;
		actor.getSprite("socket").setBrush("bust_base_beasts");
		actor.setDirty(true);

		//remove items

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

		actor.getSprite("body").setBrush("bust_schrat_body_01");
		actor.getSprite("head").setBrush("bust_schrat_head_01");
		if (!actor.isPlayerControlled())
		{
			actor.getSprite("body").setHorizontalFlipping(0);
			actor.getSprite("head").setHorizontalFlipping(0);
		}
		else
		{
			actor.getSprite("body").setHorizontalFlipping(1);
			actor.getSprite("head").setHorizontalFlipping(1);
		}

		actor.getSprite("armor").Alpha = 10;
		actor.getSprite("helmet_vanity_lower").Alpha = 10;
		actor.getSprite("helmet").Alpha = 10;
		actor.getSprite("helmet_damage").Alpha = 10;
		actor.getSprite("helmet_helm").Alpha = 10;
		actor.getSprite("helmet_top").Alpha = 10;
		actor.getSprite("helmet_vanity").Alpha = 10;

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

		if (!this.m.Container.hasSkill("racial.schrat"))
		{
			this.m.Container.add(this.new("scripts/skills/racial/schrat_racial"));
		}

		if (!this.m.Container.hasSkill("actives.uproot"))
		{
			this.m.Container.add(this.new("scripts/skills/actives/uproot_skill"));
		}

		if (!this.m.Container.hasSkill("actives.grow_shield"))
		{
			this.m.Container.add(this.new("scripts/skills/actives/grow_shield_skill"));
		}


	}

	function onRemoved()
	{
		this.removeEffect();
	}

	function onUpdate( _properties )
	{
		_properties.MovementAPCostAdditional += 1;
	}

	function onCombatFinished()
	{
		this.removeSelf();
		this.removeEffect();
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
		if (!actor.isPlayerControlled() && actor.getAIAgent().getID() != "agent.schrat")
		{
			actor.setAIAgent(this.new("scripts/ai/tactical/agents/schrat_agent"));
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
		actor.getSprite("helmet_vanity_lower").Alpha = 255;
		actor.getSprite("helmet").Alpha = 255;
		actor.getSprite("helmet_damage").Alpha = 255;
		actor.getSprite("helmet_helm").Alpha = 255;
		actor.getSprite("helmet_top").Alpha = 255;
		actor.getSprite("helmet_vanity").Alpha = 255;
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
			local tile = actor.getTile(); //actor.getTile().IsVisibleForPlayer check was erroring, checking a more roundabout way now
			if (tile != null && tile.IsVisibleForPlayer) 
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


		actor.getSkills().removeByID("actives.uproot");
		actor.getSkills().removeByID("actives.grow_shield");
		actor.getSkills().removeByID("racial.schrat");
		local items = actor.getItems();

		local generics = actor.getSkills().getAllSkillsByID("items.generic");
		foreach ( s in generics )
		{
			local i = s.getItem();
			if (i != null && i.getID() == "shield.schrat")
			{
				s.setItem(null);
				break;
			}
		}
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Offhand));
	}
});

