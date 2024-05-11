#!mainFile "../dev_main.opy"
# changes hero spec on death

#!include "utilities/custom_hp.opy"

globalvar HERO_SIZE_SCALE = createWorkshopSetting(float[0.3:10], "Experiments", "Scale Heroes", 1)
globalvar HEALTH_SIZE_SCALE_CHECK_CHECK = createWorkshopSetting(bool, "Experiments", "Scale Health With Size", false, 0)
globalvar RESPAWN_SIZE_CHECK = createWorkshopSetting(bool, "Experiments", "Scale Health With Size On Respawn", false, 0)

playervar hero_size_multiplyer
playervar default_hp
playervar default_armor
playervar default_shields


rule "Set Default Health Variables":
    @Event eachPlayer
    # @Condition eventPlayer.hasSpawned()
    @Condition eventPlayer.default_hp == null


    wait(1)
    eventPlayer.default_hp = eventPlayer.getMaxHealthOfType(Health.NORMAL)
    eventPlayer.default_armor = eventPlayer.getMaxHealthOfType(Health.ARMOR)
    eventPlayer.default_shields = eventPlayer.getMaxHealthOfType(Health.SHIELDS)

rule "Set Hero Size":

    @Event eachPlayer
    @Condition RESPAWN_SIZE_CHECK == false
    @Condition eventPlayer.isInSpawnRoom()

    wait(1)
    eventPlayer.hero_size_multiplyer = random.uniform(0.2, 3)
    clearCustomHp()
    setCustomHp(eventPlayer.default_hp * HERO_SIZE_SCALE,
         eventPlayer.default_armor * HERO_SIZE_SCALE,
         eventPlayer.default_shields * HERO_SIZE_SCALE)
    damage(eventPlayer, null, HERO_SIZE_SCALE * -100)
    eventPlayer.startScalingSize(HERO_SIZE_SCALE, true)
    waitUntil(eventPlayer.isInSpawnRoom() == false, 20)


rule "Respawn Size Change":

    @Event eachPlayer
    @Condition eventPlayer.isAlive()
    @Condition RESPAWN_SIZE_CHECK == true

    wait(1)
    eventPlayer.hero_size_multiplyer = random.uniform(0.2, HERO_SIZE_SCALE)
    clearCustomHp()
    setCustomHp(eventPlayer.default_hp * eventPlayer.hero_size_multiplyer,
         eventPlayer.default_armor * eventPlayer.hero_size_multiplyer,
         eventPlayer.default_shields * eventPlayer.hero_size_multiplyer)
    damage(eventPlayer, null, eventPlayer.hero_size_multiplyer * -100)
    eventPlayer.startScalingSize(eventPlayer.hero_size_multiplyer, true)
