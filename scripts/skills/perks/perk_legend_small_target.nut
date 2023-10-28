this.perk_legend_small_target <- this.inherit("scripts/skills/skill", {
	m = {
		BonusMin = 0
	},
	function create()
	{
		this.m.ID = "perk.legend_small_target";
		this.m.Name = this.Const.Strings.PerkName.LegendSmallTarget;
		this.m.Description = "Gains increased Melee and Ranged defense by being small";
		this.m.Icon = "ui/perks/small_target.png";
		this.m.Type = this.Const.SkillType.Perk | this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function getTooltip()
	{
		local tooltip = this.skill.getTooltip();

		if (this.getContainer().getActor().getBodyItem() == null)
		{
			tooltip.push({
				id = 6,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "This character is not wearing any body armor and receives no bonus from this perk"
			});
			return tooltip;
		}

		local bonus = this.getBonus();
		if (bonus > this.m.BonusMin)
		{
			tooltip.push({
				id = 6,
				type = "text",
				icon = "ui/icons/melee_defense.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + bonus + "[/color] Melee Defense"
			});
			tooltip.push({
				id = 6,
				type = "text",
				icon = "ui/icons/ranged_defense.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + bonus + "[/color] Ranged Defense"
			});
		}

		return tooltip;
	}

	function getBonus()
	{
		local actor = this.getContainer().getActor();
		local bodyItem = actor.getItems().getItemAtSlot(this.Const.ItemSlot.Body);
		if (bodyItem == null)
		{
			return 0;
		}

		local stackTotal = 0;
		local health = 0;
		health = actor.getBaseProperties().Hitpoints;
		local bodyArmor = 0;
		local headItem = actor.getItems().getItemAtSlot(this.Const.ItemSlot.Head);
		local headArmor = 0;
		
		if (bodyItem != null)
		{
			bodyArmor = actor.getArmor(this.Const.BodyPart.Body);
		}
		
		if (headItem != null)
		{
			headArmor = actor.getArmor(this.Const.BodyPart.Head);
		}

		local stackTotal = health + headArmor + bodyArmor;
		
		if (actor.getSkills().hasSkill("perk.legend_fashionable"))
			{
		
				if (bodyItem != null)
				{
					local tabard = bodyItem .getUpgrade(this.Const.Items.ArmorUpgrades.Tabbard);
					local cloak = bodyItem .getUpgrade(this.Const.Items.ArmorUpgrades.Cloak)
					
					if (tabard != null)
					{
					local tabardArmor = tabard.getRepair();
					stackTotal -= tabardArmor;
					}
					
					if (cloak != null)
					{
					local cloakArmor = cloak.getRepair();
					stackTotal -= cloakArmor;
					}
				}

				
			
				if (headItem != null)
				{
					local vanity = headItem.getUpgrade(this.Const.Items.HelmetUpgrades.Vanity);
					local extra = headItem.getUpgrade(this.Const.Items.HelmetUpgrades.ExtraVanity)
					
					if (vanity != null)
					{
					local vanityArmor = vanity.getRepair();
					stackTotal -= vanityArmor;
					}
					
					if (extra  != null)
					{
					local extraArmor = extra.getRepair();
					stackTotal -= extraArmor;
					}
				}
			}
		local bonus = this.Math.max(5, 100 - stackTotal); 
		return this.Math.floor(bonus);
	}

	function onUpdate( _properties )
	{
		local bonus = this.getBonus();
		_properties.MeleeDefense += bonus;
		_properties.RangedDefense += bonus;
	}
});
