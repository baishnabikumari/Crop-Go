class_name HurtComponent
extends Area2D

@export var tool : DataTypes.Tools = DataTypes.Tools.None

signal hurt

func _ready() -> void:
	area_entered.connect(_on_area_entered)
	print("HurtComponent ready on:", get_parent().name)

func _on_area_entered(area: Area2D) -> void:
	print("HurtComponent collision deletected with", area.name)
	var hit_component = area as HitComponent
	
	if !hit_component:
		print("Not a hit component, ignore it")
		return
		
	print("Hit component found")
	print("Required tool", tool, "hit tool", hit_component.current.tool)
	
	if tool == hit_component.current_tool:
		print("Tool match", hit_component.hit_damage,"Damage")
		hurt.emit(hit_component.hit_damage)
	else:
		print("Tool Mismatch, no damage")
