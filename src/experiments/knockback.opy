#!mainFile "../../dev_main.opy"
# Define knockback intensity

globalvar RESPAWN_SIZE_CHECK = createWorkshopSetting(bool, "Experiments", "Knockback on Every Damage Event", false, 0)

rule "Add knockback on primary fire hit":
    @Event playerDealtDamage
    @Condition attacker != victim

    # Apply knockback
    victim.applyImpulse(
        directionTowards(eventPlayer, victim), # Direction from attacker to victim
        eventDamage,                  # Intensity of the knockback
        Relativity.TO_WORLD,                  # Apply the force relative to the world
        Impulse.CANCEL_CONTRARY_MOTION_XYZ    # Cancel any contrary motion to ensure clean knockback
    )
