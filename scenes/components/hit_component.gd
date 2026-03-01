class_name HitComponent
extends Area2D

@export var current_tool : DataTypes.Tools = DataTypes.Tools.None
@export var hit_damage : int = 1

func _ready():
	print("Hit component ready on: ", get_parent().name)
	print("tool type", current_tool, "damage", hit_damage)
