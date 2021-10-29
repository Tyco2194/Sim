extends Node2D
#Move list array = [Type, damage, stat damaged,damage to stat, stamina, spirit ]



var bar_red = preload("res://Assets/Damage.jpg")
var bar_green = preload("res://Assets/Health.jpg")
var bar_yellow = preload("res://Assets/Yellow.jpg")

onready var healthbar = $HealthBar2

var creature1 
var creature2
var creatures = []
func _ready():
	hide()
#	healthbar.fill_mode = 1
	var moveList1 = {"Grasp":["Neutral", 10, "Speed", 10, 10,"Agressive"],"Fire Punch":["Fire", 20, "Stamina", 10 , 20, "Agressive"]}
	var moveList2 = {"Grasp":["Neutral", 10, "Speed", 10, 10,"Agressive"],"Aerial Graze":["Air", 20, "Stamina", 10 , 20,"Agressive"]}
	var stats1 = {"Health":200,"Attack":123,"Defense":150,"Speed":100,"Stamina":100}
	var stats2 = {"Health":200,"Attack":157,"Defense":100,"Speed":100,"Stamina":100}
	creature1 = Creature.new("Fucker1", "M", "Fire", stats1, "Agressive", moveList1)
	creature2 = Creature.new("Fucker2", "M", "Air", stats2, "Agressive", moveList2)
	healthbar.max_value = creature2.Stats["Health"]
#	add_child(creature1)Why no work?
#	add_child(creature2)

	creatures = [creature1,creature2]

	###Move this to creature
func _process(_delta):
	if Input.is_action_just_pressed("ui_select"):

		if creature1.Stats["Health"] > 0 && creature2.Stats["Health"] > 0:
			for creature in creatures:
				if creature.Stats["Health"] < 100:#Will eventually be a Max Health var
					creature.Stats["Health"] += creature.healthRegen
				if creature.Stats["Stamina"] < 100:#Will eventually be a MaxStam var
					creature.Stats["Stamina"] += creature.stamRegen
			damage(creature1,creature2)
			for creature in creatures:
				print("\n",creature.Name, " Stats:")
				for stat in creature.Stats:
					print(stat," ",creature.Stats[stat])
			if creature1.Stats["Health"] == 0 || creature2.Stats["Health"] == 0:
				for creature in creatures:
					if creature.Stats["Health"] > 0:
						print(creature.Name, " Wins!")
		update_healthbar2(creature2.Stats["Health"])
				


func damage(Creature1,Creature2):
	while Creature1.alive == true && Creature1.alive == true:
		if Creature1.Stats["Speed"] > Creature2.Stats["Speed"]:
			Creature1.applyDamage(Creature2)
			Creature2.applyDamage(Creature1)
		elif Creature2.Stats["Speed"] < Creature1.Stats["Speed"]:
			Creature2.applyDamage(Creature1)
			Creature1.applyDamage(Creature2)
		else:
			randomize()
			var i = .2#randf()
			if i > 0.5:
				Creature1.applyDamage(Creature2)
				Creature2.applyDamage(Creature1)
			else:
				Creature2.applyDamage(Creature1)
				if creature1.alive == false:
					break
				Creature1.applyDamage(Creature2)
			print(i)
		break

#func battle(Creature1,Creature2):
	
	pass
		
func update_healthbar2(value):
	healthbar.texture_progress = bar_green
	if value < healthbar.max_value * 0.7:
		healthbar.texture_progress = bar_yellow
	if value < healthbar.max_value * 0.35:
		healthbar.texture_progress = bar_red
	if value < healthbar.max_value:
		show()
	healthbar.value = value
