this.perk_legend_specialist_cult_hood <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.legend_specialist_cult_hood";
		this.m.Name = this.Const.Strings.PerkName.LegendSpecCultHood;
		this.m.Description = this.Const.Strings.PerkDescription.LegendSpecCultHood;
		this.m.Icon = "ui/perks/dedication_circle.png";
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onAfterUpdate( _properties )
	{
		local actor = this.getContainer().getActor();
		local item = actor.getItems().getItemAtSlot(this.Const.ItemSlot.Head);
		local resolve = actor.getCurrentProperties().Bravery;
		if (item != null)
		{
			if (::mods_isClass(item, "legend_helmet") != null)
			{
				local layers = item.getUpgradeIDs();
				foreach(l in layers)
				{
					if (l != null && (l == "armor.head.legend_helmet_sack" || l == "armor.head.legend_helmet_cult_hood"))
					{
						_properties.MeleeDefense += this.Math.floor(resolve * 0.10);
						_properties.RangedDefense += this.Math.floor(resolve * 0.10);
						return;
					}
				}
			}
			else
			{
				switch (item.getID())
				{
					case "armor.head.cultist_hood":
					case "armor.head.cultist_leather_hood":
					case "armor.head.leather_helmet" :
					case "armor.head.decayed_closed_flat_top_with_sack":
					case "armor.head.mask_of_davkul":
						_properties.MeleeDefense += this.Math.floor(resolve * 0.10);
						_properties.RangedDefense += this.Math.floor(resolve * 0.10);
						break;
				}
			}
		}
	}

});
