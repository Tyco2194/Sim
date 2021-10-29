extends Node2D

var value1_type = 5
var value1 = "dict:[1,2,3]"
func _ready():
	if value1_type == 5:
		var value1 = value1.split(":",false,0)
		print(value1)
