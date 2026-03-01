extends StaticBody2D

@export var hurt_component: HurtComponent
@export var damage_component: DamageComponent
@export var canopy: Sprite2D
@export var trunk: Sprite2D

# Optional: preload log scene to drop when tree is chopped
var log_scene = preload("res://scenes/objects/trees/log.tscn")

func _ready():
	print("Tree initialized: ", name)
	
	# Connect signals
	if hurt_component:
		hurt_component.hurt.connect(_on_hurt)
		print("HurtComponent connected!")
	else:
		print("WARNING: HurtComponent not assigned!")
	
	if damage_component:
		damage_component.max_damaged_reached.connect(_on_tree_destroyed)
		print("DamageComponent connected!")
	else:
		print("WARNING: DamageComponent not assigned!")

func _on_hurt(damage_amount: int):
	print("Tree was hit! Taking ", damage_amount, " damage")
	
	if damage_component:
		damage_component.apply_damage(damage_amount)
		print("Tree damage: ", damage_component.current_damage, "/", damage_component.max_damage)
	
	shake_tree()

func _on_tree_destroyed():
	print("Tree has been chopped down!")
	drop_log()
	queue_free()

func shake_tree():
	if canopy:
		var tween = create_tween()
		tween.tween_property(canopy, "position:x", 2, 0.05)
		tween.tween_property(canopy, "position:x", -2, 0.05)
		tween.tween_property(canopy, "position:x", 0, 0.05)

func drop_log():
	print("Log dropped at: ", global_position)
	if log_scene:
		var log = log_scene.instantiate()
		get_parent().add_child(log)
		log.global_position = global_position + Vector2(0, 8)
		print("Log spawned")
	else:
		print("Log scene not found")
