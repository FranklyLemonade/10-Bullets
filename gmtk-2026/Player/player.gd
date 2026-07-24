extends CharacterBody2D

var bullet_count = 10
var shoot_cd = true
const BULLET_SCENE = preload("res://Objects/Bullet/bullet.tscn")

var facing = 1
const SPEED = 300.0
const JUMP_VELOCITY = -400.0

signal bullet_used

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
		facing = direction
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	move_and_slide()
	
	# Code for shooting
	if Input.is_action_just_pressed("shoot") and shoot_cd and bullet_count > 0:
		var bullet = BULLET_SCENE.instantiate()
		bullet.position = position
		bullet.direction = facing
		get_parent().add_child(bullet)
		cd_timer(0.5)
		bullet_count -= 1
		bullet_used.emit()


func cd_timer(cd: float):
	shoot_cd = false
	await get_tree().create_timer(cd).timeout
	shoot_cd = true

func die():
	get_tree().reload_current_scene()
