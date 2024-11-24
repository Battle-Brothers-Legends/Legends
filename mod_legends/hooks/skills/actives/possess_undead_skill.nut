::mods_hookExactClass("skills/actives/possess_undead_skill", function(o)
{
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Description = "Allows you to boost the attacks of an undead minion";
		this.m.Icon = "skills/possess56_square.png";
		this.m.IconDisabled = "skills/possess56_square_bw.png";
		this.m.IsUsingHitchance = false;
		this.m.MaxRange = 9;
		this.m.Order = this.Const.SkillOrder.Any +10;
	}

	o.onAfterUpdate <- function ( _properties )
	{
		if (!this.getContainer().getActor().isPlayerControlled())
			this.m.MaxRange = 99;
	}

	o.onUse = function ( _user, _targetTile )
	{
		local target = _targetTile.getEntity();

		if (!_user.isHiddenToPlayer() || _targetTile.IsVisibleForPlayer)
		{
			this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_user) + " possesses " + this.Const.UI.getColorizedEntityName(target));

			if (this.m.SoundOnHit.len() != 0)
			{
				this.Sound.play(this.m.SoundOnHit[this.Math.rand(0, this.m.SoundOnHit.len() - 1)], this.Const.Sound.Volume.Skill * 1.2, _user.getPos());
			}
		}

		local possessed = this.new("scripts/skills/effects/possessed_undead_effect");
		possessed.setPossessor(_user);
		possessed.setPlayerControlled(_user.isPlayerControlled()); // from me combining both skills
		target.getSkills().add(possessed);
		target.setActionPoints(target.getCurrentProperties().ActionPoints);
		local possessing = this.new("scripts/skills/effects/possessing_undead_effect");
		possessing.setPossessed(target);
		_user.getSkills().add(possessing);
		return true;
	}
});
