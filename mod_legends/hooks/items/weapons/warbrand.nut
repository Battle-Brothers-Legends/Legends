::mods_hookExactClass("items/weapons/warbrand", function(o) {
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Value = 1700;
	}

	o.addSkill <- function( _skill )
	{
		if (_skill.getID() == "actives.slash")
			_skill = ::new("scripts/skills/actives/legend_great_slash"); // replace slash with great slash

		weapon.addSkill(_skill);
	}
});
