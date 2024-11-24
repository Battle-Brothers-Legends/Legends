::mods_hookExactClass("items/weapons/named/named_goblin_spear", function(o) {
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Description = "A masterfully crafted goblin glaive. Accurate, fast and deadly in the hands of any skilled fighter.";
		this.m.Value = 2500;
		this.m.StaminaModifier = -5;
		this.m.RegularDamage = 30;
		this.m.RegularDamageMax = 40;
	}

	o.addSkill <- function( _skill )
	{
		if (_skill.getID() == "actives.thrust")
			_skill = this.new("scripts/skills/actives/legend_glaive_slash_skill");
		else if (_skill.getID() == "actives.spearwall")
			_skill.m.BaseAttackName = "Glaive Slash";

		named_weapon.addSkill(_skill);
	}
	
});
