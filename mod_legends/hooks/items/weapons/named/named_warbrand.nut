::mods_hookExactClass("items/weapons/named/named_warbrand", function(o) {

	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Variants = [1,2,3]
		this.m.Variant = this.m.Variants[this.Math.rand(0, this.m.Variants.len() -1)];
		this.m.Value = 4200;
	}

	o.addSkill <- function( _skill )
	{
		if (_skill.getID() == "actives.slash")
			_skill = ::new("scripts/skills/actives/legend_great_slash"); // replace slash with great slash

		named_weapon.addSkill(_skill);
	}
});
