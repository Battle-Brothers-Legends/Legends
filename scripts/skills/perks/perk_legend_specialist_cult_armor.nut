this.perk_legend_specialist_cult_armor <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.legend_specialist_cult_armor";
		this.m.Name = this.Const.Strings.PerkName.LegendSpecCultArmor;
		this.m.Description = "This character is gaining increased Maximum Damage because of adjacent opponents.";
		this.m.Icon = "ui/perks/penance_circle.png";
		this.m.Type = this.Const.SkillType.Perk | this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false; 
	}

	//constant passive
	function getDescription()
	{
		local bonus = this.getBonus() * 100;
		return "This character gains +[color=" + this.Const.UI.Color.PositiveValue + "]" + bonus + "%[/color] maximum damage of the weapon's base maximum because of adjacent opponents.";
	}

	function getTooltip()
	{
		local ret = this.skill.getTooltip();
		local bonus = this.getBonus() * 100;
		ret.push({
			id = 10,
			type = "text",
			icon = "ui/icons/damage_dealt.png",
			text = "+[color=" + this.Const.UI.Color.NegativeValue + "]" + bonus + "[/color] Maximum Damage"
		});

		return ret;
	}

	function isOpponent( _actor, _tag )
	{
		if (this.Math.abs(_actor.getTile().Level - _tag.Actor.getTile().Level) > 1)
		{
			return;
		}

		if (!_actor.isAlliedWithPlayer())
		{
			++_tag.Opponents;
		}
	}

	function getBonus()
	{
		local actor = this.getContainer().getActor();
		return ::Tactical.Entities.getHostileActors(actor.getFaction(), actor.getTile(), 1).len() * 0.05;
	}

	function onUpdate( _properties )
	{
		this.m.IsHidden = this.getBonus() == 0.0;
	}

	function getCultistPieces(){
		local item = this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Body);
		local cultItems = []
		if (item != null)
		{
			if(item.isItemType(this.Const.Items.ItemType.Cultist)) cultItems.push(item)
			if (!::Legends.Mod.ModSettings.getSetting("UnlayeredArmor").getValue() && ::mods_isClass(item, "legend_armor"))
			{
				foreach( upgrade in item.m.Upgrades )
				{
					if (upgrade != null && upgrade.isItemType(this.Const.Items.ItemType.Cultist)){
						cultItems.push(upgrade);
					}
				}
			}
		}
		return cultItems
	}

	//equipment check
	function onAfterUpdate( _properties )
	{
		local actor = this.getContainer().getActor();
		local item = actor.getItems().getItemAtSlot(this.Const.ItemSlot.Body);
		local healthMissing = actor.getHitpointsMax() - actor.getHitpoints();

		if (this.getCultistPieces().len() > 0) _properties.Bravery += this.Math.floor(healthMissing * 0.75);

		local bonus = this.getBonus();
		if (bonus == 0) return;
		item = this.getContainer().getActor().getMainhandItem();
		if (item != null)
		{
			_properties.DamageRegularMax += item.m.RegularDamageMax * bonus; //perk damage += item damage
		}
	}

});
