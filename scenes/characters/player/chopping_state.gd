extends NodeState

@export var player: Player
@export var animated_sprite_2d: AnimatedSprite2D
@export var axe_hitbox: Area2D

var is_chopping: bool = false
	
func _on_physics_process(_delta : float) -> void:
	if player:
		player.velocity = Vector2.ZERO
		player.move_and_slide()
		
func _on_next_transition() -> void:
	if not is_chopping:
		transition.emit("Idle")

func _on_enter() -> void:
	print("started copping")
	is_chopping = true

	if player:
		if player.player_direction == Vector2.UP:
			animated_sprite_2d.play("chopping_back")
		elif player.player_direction == Vector2.RIGHT:
			animated_sprite_2d.play("chopping_right")
		elif player.player_direction == Vector2.DOWN:
			animated_sprite_2d.play("chopping_front")
		elif player.player_direction == Vector2.LEFT:
			animated_sprite_2d.play("chopping_left")
		else:
			animated_sprite_2d.play("chopping_front")
			
	if not animated_sprite_2d.animation_finished.is_connected(_on_animation_finished):
		animated_sprite_2d.animation_finished.connect(_on_animation_finished)
	if axe_hitbox and player:
		position_hitbox()
		await get_tree().create_timer(0.15).timeout
		if axe_hitbox:
			print("Enabling axe hitbox!")
			axe_hitbox.monitoring = true
			axe_hitbox.monitorable = true
			await get_tree().create_timer(0.2).timeout
			if axe_hitbox:
				axe_hitbox.monitoring = false
				axe_hitbox.monitorable = false
	
func _on_exit() -> void:
	print("chop finished")
	is_chopping = false
	
	if axe_hitbox:
		axe_hitbox.monitoring = false
		axe_hitbox.monitorable = false
		
func _on_animation_finished():
	is_chopping = false
	
func position_hitbox():
	if not axe_hitbox or not player:
		return
		
	var offset = Vector2.ZERO
	var distance = 12
	
	if player.player_direction == Vector2.UP:
		offset = Vector2(0, -distance)
	elif player.player_direction == Vector2.RIGHT:
		offset = Vector2(distance, 0)
	elif player.player_direction == Vector2.DOWN:
		offset = Vector2(0, distance)
	elif player.player_direction == Vector2.LEFT:
		offset = Vector2(-distance, 0)
		
	axe_hitbox.position = offset
	print("Hitbox positioned at: ", offset)
