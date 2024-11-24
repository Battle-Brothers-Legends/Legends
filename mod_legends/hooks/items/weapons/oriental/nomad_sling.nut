::mods_hookExactClass("items/weapons/oriental/nomad_sling", function(o) {
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Categories = "Sling, Two-Handed";
		this.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.RangedWeapon | this.Const.Items.ItemType.Defensive | this.Const.Items.ItemType.TwoHanded;
	}
});
