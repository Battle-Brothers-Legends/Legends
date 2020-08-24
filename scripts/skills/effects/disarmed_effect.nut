this.disarmed_effect <- this.inherit("scripts/skills/skill", {
	m = {
		TurnsLeft = 1,
		WeaponID = ""
	},
	function create()
	{
		this.m.ID = "effects.disarmed";
		this.m.Name = "Disarmed";
		this.m.Icon = "skills/status_effect_111.png";
		this.m.IconMini = "status_effect_111_mini";
		this.m.Overlay = "status_effect_111";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function getDescription()
	{
		return "This character has been temporarily disarmed for [color=" + this.Const.UI.Color.NegativeValue + "]" + this.m.TurnsLeft + "[/color] more turn(s) and is unable to use any weapon skills. Switching to a different weapon will remove this effect immediately.";
	}

	function addTurns( _t )
	{
		this.m.TurnsLeft += _t;
	}

	function setTurns( _t )
	{
		if (this.getContainer() != null)
		{
			this.m.TurnsLeft = this.Math.max(1, _t + this.getContainer().getActor().getCurrentProperties().NegativeStatusEffectDuration);
		}
	}

	function onAdded()
	{
		local items = this.m.Container.getActor().getItems();

		if (items.getItemAtSlot(this.Const.ItemSlot.Mainhand) != null && !this.m.Container.getActor().getCurrentProperties().IsImmuneToDisarm)
		{
			this.m.WeaponID = items.getItemAtSlot(this.Const.ItemSlot.Mainhand).getInstanceID();
			this.m.Container.removeByID("effects.spearwall");
			this.m.Container.removeByID("effects.riposte");
			this.m.Container.removeByID("effects.return_favor");
		}
		else
		{
			this.m.IsGarbage = true;
		}
	}

	function onRemoved()
	{
		local actor = this.getContainer().getActor();
		actor.getSprite("arms_icon").Visible = true;

		if (!this.getContainer().hasSkill("effects.stunned"))
		{
			if (actor.hasSprite("status_stunned"))
			{
				actor.getSprite("status_stunned").Visible = false;
			}
		}

		actor.setDirty(true);
	}

	function onUpdate( _properties )
	{
		local actor = this.getContainer().getActor();

		if (actor.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand) == null || actor.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand).getInstanceID() != this.m.WeaponID)
		{
			this.removeSelf();
			return;
		}

		if (!actor.getCurrentProperties().IsImmuneToDisarm)
		{
			if (this.m.TurnsLeft != 0)
			{
				_properties.IsAbleToUseWeaponSkills = false;
				actor.getSprite("arms_icon").Visible = false;

				if (!this.getContainer().hasSkill("effects.stunned") && actor.hasSprite("status_stunned"))
				{
					actor.getSprite("status_stunned").setBrush("bust_disarmed");
					actor.getSprite("status_stunned").Visible = true;
				}

				actor.setDirty(true);
			}
			else
			{
				actor.getSprite("arms_icon").Visible = true;

				if (!this.getContainer().hasSkill("effects.stunned") && actor.hasSprite("status_stunned"))
				{
					actor.getSprite("status_stunned").Visible = false;
				}

				actor.setDirty(true);
			}
		}
		else
		{
			this.removeSelf();
		}
	}

	function onTurnEnd()
	{
		if (--this.m.TurnsLeft <= 0)
		{
			this.removeSelf();
			local actor = this.getContainer().getActor();
			actor.getSprite("arms_icon").Visible = true;

			if (!this.getContainer().hasSkill("effects.stunned"))
			{
				if (actor.hasSprite("status_stunned"))
				{
					actor.getSprite("status_stunned").Visible = false;
				}
			}

			actor.setDirty(true);
		}
	}

});

