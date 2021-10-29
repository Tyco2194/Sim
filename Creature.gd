extends Node2D

class_name Creature
var Name
var Sex
var Type
var Spirit
var Moves = {}
var Stats = {}
var healthRegen
var stamRegen
var minStam
var advantageList = {"Air":["Water"],"Fire":["Air"],"Neutral":[]}#Will be referenced somwhere else
var exhausted = false
var alive = true
var maxHealth

#Stats can be condensed into an array
func _init(creatureName, creatureSex, creatureType, creatureStats ,creatureSpirit,creatureMoves):
	Name = creatureName
	Sex = creatureSex
	Type = creatureType
	Stats = creatureStats
	Spirit = creatureSpirit
	Moves = creatureMoves
	healthRegen = Stats["Health"]/100
	stamRegen = 10
	minStam = Stats["Stamina"]/2
	maxHealth = Stats["Health"]
	
	return self

func applyDamage(creature,moveName = null):
	var availableMoves = []
	var damage = 0
	var bonusDamage
	var attackMulti = float(Stats["Attack"]/100.0)
	if Stats["Stamina"] > minStam && exhausted == true:
		exhausted = false
	if moveName == null:
		for move in Moves:
			if Moves[move].has(Spirit):
				availableMoves.append(move)
		moveName = availableMoves[rand_range(0,availableMoves.size())]
	var move = Moves[moveName]  
	if Stats["Stamina"] >= move[4] && exhausted == false:
		damage = move[1] * attackMulti
		if advantageList[move[0]].has(creature.Type):
			bonusDamage = damage * 20/100 #will be a var
			damage += bonusDamage
		var specialDamage = move[3]
		var cstat = move[2]
		creature.Stats[cstat] -= (creature.Stats[cstat] * specialDamage/100) #Should this be a status effect?
		if creature.Stats["Health"] <= damage:
			creature.Stats["Health"] = 0
		else:
			damage -= creature.Stats["Defense"]/10
			creature.Stats["Health"] -= damage
		Stats["Stamina"] -= move[4]
		print("\n",Name, " used ", moveName, " on ", creature.Name, " for ", damage , " Damage\n")
	else:
		print("\n",Name, " is exhausted")
		if exhausted == false:
			exhausted = true
#	print(creature.Name, " Remaining Health: ",creature.Stats["Health"], " Remaining Stamina: ", Stats["Stamina"],"\n")
	if creature.Stats["Health"] == 0:
		creature.alive = false	
		
		
		
		
		
		
		
		
		
		
		
		
		

#########################  Set Gets  #########################
func healthGet():
	return Stats["Health"]

func healthSet(value):
	Stats["Health"] = value

func staminaGet():
	return Stats["Stamina"]

func staminaSet(value):
	Stats["Stamina"] = value
	
func attackGet():
	return Stats["Attack"]

func attackSet(value):
	Stats["Attack"] = value

func defenceGet():
	return Stats["Defense"]

func defenseSet(value):
	Stats["Defense"] = value
	
func speedGet():
	return Stats["speed"]

func speedSet(value):
	Stats["Speed"] = value
#
#func damageGet():
#
#	return damage
#
	
	
