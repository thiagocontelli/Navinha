class_name Player extends CharacterBody2D

signal killed

var bullet = preload("res://scenes/bullet.tscn")

const SPEED = 600.0
const FIRE_RATE = 0.2

var can_fire = true

func _process(delta):
	if Input.is_action_pressed("fire") and can_fire:
		var bullet_instance = bullet.instantiate()
		bullet_instance.position = $BulletPoint.get_global_position()
		get_tree().get_root().add_child(bullet_instance)
		can_fire = false
		await get_tree().create_timer(FIRE_RATE).timeout
		can_fire = true

func _physics_process(delta):
	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	global_position = global_position.clamp(Vector2.ZERO, get_viewport_rect().size)
	
func die():
	killed.emit()
	queue_free()
