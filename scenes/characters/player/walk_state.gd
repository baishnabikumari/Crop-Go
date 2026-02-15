extends NodeState

@export var player: Player
@export var animated_sprite_2d: AnimatedSprite2D
@export var speed: int = 50

func _on_process(_delta : float) -> void:
	pass
	
func _on_physics_process(_delta : float) -> void:
	var direction: Vector2 = GameInputEvents.movement_input()
	
	print("walk state active", direction)
	
	if direction == Vector2.UP:
		animated_sprite_2d.play("walk_back")
	elif direction == Vector2.RIGHT:
		animated_sprite_2d.play("walk_right")
	elif direction == Vector2.DOWN:
		animated_sprite_2d.play("walk_front")
	elif direction == Vector2.LEFT:
		animated_sprite_2d.play("walk_left")
		
	if direction != Vector2.ZERO and player:
		player.player_direction = direction
		print("setting player direction to", direction)
	
	if player:
		player.velocity = direction * speed
		print("setting velocity to", player.velocity)
		player.move_and_slide()
		print("after move_and_slide position: ", player.position)
	else:
		print("player is null")
	
func _on_next_transition() -> void:
	if !GameInputEvents.is_movement_input():
		transition.emit("Idle")

func _on_enter() -> void:
	pass
	
func _on_exit() -> void:
	animated_sprite_2d.stop()
