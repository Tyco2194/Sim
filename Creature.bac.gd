extends Node2D

#class_name Creature
var Name
var Sex
var Type
var Health
var Attack
var Defence
var Speed
var Stamina
var Spirit
var Moves = {}
var Stats = {}
var healthRegen
var stamRegen
var advantageList = {"Air":["Water"],"Fire":["Air"],"Neutral":[]}#Will be referenced somwhere else

#Stats can be condensed into an array
func _init(creatureName, creatureSex, creatureType, creatureHealth, creatureAttack, creatureDefence, creatureSpeed, creatureStamina, creatureSpirit,creatureMoves):
	Name = creatureName
	Sex = creatureSex
	Type = creatureType
	Health = creatureHealth
	Attack = creatureAttack
	Defence = creatureDefence
	Speed = creatureSpeed
	Stamina = creatureStamina
	Spirit = creatureSpirit
	Moves = creatureMoves
	healthRegen = 10
	stamRegen = 5
	return self

func applyDamage(creature,moveName = null):
	var availableMoves = []
	var damage = 0
	var multiplier = 1
	var attackMulti = float(Attack/100.0)
	if moveName == null:
		for move in Moves:
			if Moves[move].has(Spirit):
				availableMoves.append(move)
	moveName = availableMoves[rand_range(0,availableMoves.size())]
	var move = Moves[moveName]
	if Stamina >= move[4]:
		if advantageList[move[0]].has(creature.Type):
			multiplier = 2
		damage = move[1] * multiplier * attackMulti
		var specialDamage = move[4]
		creature.Stats[move[3]] - specialDamage
		if creature.Health >= damage:
			creature.Health -= damage 
		else:
			creature.Health = 0
		Stamina -= move[4]
		print(Name, " used ", moveName, " on ", creature.Name, " for ", damage , " Damage\n")
	else:
		print(Name, " is out of stamina\n")
#	print(creature.Name, " Remaining Health: ",creature.Health, " Remaining Stamina: ", Stamina,"\n")
	for stat in Stats:
		print(stat," ",Stats[stat])
	
	
