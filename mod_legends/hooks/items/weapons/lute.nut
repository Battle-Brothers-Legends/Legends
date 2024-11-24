::mods_hookExactClass("items/weapons/lute", function(o) {
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Categories = "Musical Instrument, Mace, Two-Handed";
		this.m.IsDoubleGrippable = false;
		this.m.Value = 50;
		this.m.Condition = 30.0;
		this.m.ConditionMax = 30.0;
		this.m.RegularDamageMax = 20;
	}

	local onEquip = o.onEquip;
	o.onEquip = function ()
	{
		this.addSkill(this.new("scripts/skills/actives/legend_lute_bash_skill")); // move it up here so knock back skill is placed before this skill as both has the same skill order
		onEquip();
	}
});
