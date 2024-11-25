this.perk_legend_piercing_shot <- this.inherit("scripts/skills/skill", {
	m = {
		BonusRange = 1,
	},
	function create()
	{
		this.m.ID = "perk.legend_piercing_shot";
		this.m.Name = this.Const.Strings.PerkName.LegendPiercingShot;
		this.m.Description = this.Const.Strings.PerkDescription.LegendPiercingShot;
		this.m.Icon = "ui/perks/PiercingBoltPerk.png";
		this.m.IconDisabled = "ui/perks/PiercingBoltPerk_bw.png"
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onAfterUpdate( _properties )
	{
		local s = this.getContainer().getSkillByID("actives.fire_handgonne");
		if (s != null)
		{
			s.m.MaxRange += this.m.BonusRange;
			// The getTooltip() function in fire_handgonne_skill has logic to display this bonus
		}
	}
});
