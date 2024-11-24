::mods_hookExactClass("items/weapons/greenskins/goblin_spear", function(o) {
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Description = "A long shaft with a sharp metal blade at the top.";
		this.m.Value = 500;
		this.m.StaminaModifier = -6;
		this.m.RegularDamage = 30;
		this.m.RegularDamageMax = 40;
	}

	o.addSkill <- function( _skill )
	{
		if (_skill.getID() == "actives.thrust")
			_skill = this.new("scripts/skills/actives/legend_glaive_slash_skill");
		else if (_skill.getID() == "actives.spearwall")
			_skill.m.BaseAttackName = "Glaive Slash";

		weapon.addSkill(_skill);
	}
	
});
