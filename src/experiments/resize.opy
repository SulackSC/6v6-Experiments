#!mainFile "../../dev_main.opy"
# changes hero spec on death

#!include "utilities/custom_hp.opy"

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


rule "Respawn Size Change":
 
    @Event eachPlayer
    # @Condition eventPlayer.isAlive() == true
    @Condition eventPlayer.isHoldingButton(Button.INTERACT)


    eventPlayer.hero_size_multiplyer = random.uniform(0.2, 3)
    clearCustomHp()
    setCustomHp(eventPlayer.default_hp * eventPlayer.hero_size_multiplyer,
         eventPlayer.default_armor * eventPlayer.hero_size_multiplyer,
         eventPlayer.default_shields * eventPlayer.hero_size_multiplyer)
    damage(eventPlayer, null, eventPlayer.hero_size_multiplyer * -100)
    eventPlayer.startScalingSize(eventPlayer.hero_size_multiplyer, true)
