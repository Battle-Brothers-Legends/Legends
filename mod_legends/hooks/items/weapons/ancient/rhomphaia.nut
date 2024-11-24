::mods_hookExactClass("items/weapons/ancient/rhomphaia", function(o) {
	o.addSkill <- function( _skill )
	{
		if (_skill.getID() == "actives.slash")
			_skill = ::new("scripts/skills/actives/legend_great_slash"); // replace slash with great slash

		weapon.addSkill(_skill);
	}
});