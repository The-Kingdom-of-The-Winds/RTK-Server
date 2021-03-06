spy_dealer = {
	on_spawn = function(mob)
		mob.newMove = math.random(2000, 3000)
		mob.baseMove = mob.newMove
		mob.mobType = 1
		mob.gfxHair = math.random(1, 75)
		mob.gfxFace = math.random(200, 275)
		mob.gfxHairC = math.random(0, 31)
		mob.gfxFaceA = -1
		mob.gfxFaceAT = -1
		mob.gfxMantle = -1
		mob.gfxNeck = -1
		mob.gfxCrown = -1
		mob.gfxHelm = -1
		mob.gfxWeap = -1
		mob.gfxShield = -1
		mob.gfxArmor = 20
		mob.gfxArmorC = math.random(0, 255)
		mob.gfxClone = 1
		mob:updateState()
	end,

	on_healed = function(mob, healer)
	end,

	on_attacked = function(mob, attacker)
		if attacker.gmLevel == 99 then
			mob_ai_basic.on_attacked(mob, attacker)
		end
	end,

	move = function(mob, target)
		if math.random(1, 100) == 1 then
			mob:talk(0, "Dealer: Step right up and try your luck!")
		end
		mob.side = math.random(0, 3)
		mob:sendSide()
		mob:move()
	end,

	attack = function(mob, target)
		mob.side = math.random(0, 3)
		mob:sendSide()
		mob:move()
	end,

	after_death = function(mob, block)
	end
}
