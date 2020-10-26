this.accessory_dog <- this.inherit("scripts/items/accessory/accessory", {
	m = {
		Skill = null,
		Entity = null,
		Script = "",
		ArmorScript = null,
		UnleashSounds = [
			"sounds/combat/unleash_wardog_01.wav",
			"sounds/combat/unleash_wardog_02.wav",
			"sounds/combat/unleash_wardog_03.wav",
			"sounds/combat/unleash_wardog_04.wav"
		]
	},

	function create()
	{
		this.accessory.create();
		this.m.SlotType = this.Const.ItemSlot.Accessory;
		this.m.ItemType = this.Const.Items.ItemType.Accessory;
		this.m.IsUsable = false;
		this.m.IsAllowedInBag = true;
		this.m.IsDroppedAsLoot = true;
		this.m.ShowOnCharacter = false;
		this.m.IsChangeableInBattle = true;
	}

	function isAllowedInBag(_actor)
	{
		//Wierd work around - since player stash queries this in order to enabled drag/drop onto
		//paperdoll - but there is no actor or container yet so we have to allow
		//all wardogs to be allowed in bag , and then when the addToBag check calls
		//this function again, we can check actor and set it to false if not perk
		//is present
		if (_actor == null && this.getContainer() == null)
		{
			return true;
		}

		if (_actor == null && this.getContainer() != null)
		{
			_actor = this.getContainer().getActor();
		}

		if (_actor.getSkills().hasSkill("perk.legend_packleader"))
		{
			return true;
		}

		return false;
	}

	function isChangeableInBattle(_actor)
	{
		//Wierd work around - since player stash queries this in order to enabled drag/drop onto
		//paperdoll - but there is no actor or container yet so we have to allow
		//all wardogs to be allowed in bag , and then when the addToBag check calls
		//this function again, we can check actor and set it to false if not perk
		//is present
		local act = _actor;
		
		if ( typeof act == "instance" )
		{
			act = act.get()
			this.logInfo("Getting accessory_dog typeof was instance -> should not be anymore?")
		}

		if (act == null && this.getContainer() == null)
		{
			return true;
		}

		if (act == null && this.getContainer() != null)
		{
			act = this.getContainer().getActor();
		}

		

		if (act.getSkills().hasSkill("perk.legend_packleader"))
		{
			return true;
		}

		return false;
	}

	function isUnleashed()
	{
		return this.m.Entity != null;
	}

	function getScript()
	{
		return this.m.Script;
	}

	function getArmorScript()
	{
		return this.m.ArmorScript;
	}

	function playInventorySound( _eventType )
	{
		this.Sound.play("sounds/inventory/wardog_inventory_0" + this.Math.rand(1, 3) + ".wav", this.Const.Sound.Volume.Inventory);
	}

	function updateVariant()
	{
		this.setEntity(this.m.Entity);
	}

	function setName( _n )
	{
		this.m.Name = _n;
	}

	function onPutIntoBag()
	{
		//this.onEquip();
	}

	function onCombatFinished()
	{
		this.setEntity(null);
	}

	function onActorDied( _onTile )
	{
		if (!this.isUnleashed() && _onTile != null)
		{
			local entity = this.Tactical.spawnEntity(this.getScript(), _onTile.Coords.X, _onTile.Coords.Y);
			entity.setItem(this);
			entity.setName(this.getName());
			entity.setVariant(this.getVariant());
			if (this.getContainer().getActor().getSkills().hasSkill("perk.legend_dogwhisperer"))
			{
				entity.getSkills().add(this.new("scripts/skills/perks/perk_fortified_mind"));
				entity.getSkills().add(this.new("scripts/skills/perks/perk_colossus"));
				entity.getSkills().add(this.new("scripts/skills/perks/perk_underdog"));
			}

			this.setEntity(entity);
			entity.setFaction(this.Const.Faction.PlayerAnimals);

			if (this.m.ArmorScript != null)
			{
				local item = this.new(this.m.ArmorScript);
				entity.getItems().equip(item);
			}

			this.Sound.play(this.m.UnleashSounds[this.Math.rand(0, this.m.UnleashSounds.len() - 1)], this.Const.Sound.Volume.Skill, _onTile.Pos);
		}
	}

	function onCombatFinished()
	{
		this.setEntity(null);
	}

	function onEquip()
	{
		this.accessory.onEquip();
	}

	function onSerialize( _out )
	{
		this.accessory.onSerialize(_out);
		_out.writeString(this.m.Name);
	}

	function onDeserialize( _in )
	{
		this.accessory.onDeserialize(_in);
		this.m.Name = _in.readString();
	}

});

