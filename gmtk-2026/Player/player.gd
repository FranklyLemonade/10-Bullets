extends CharacterBody2D

var jumping = false
var shooting = false
var bullet_count = 10
var shoot_cd = true
const BULLET_SCENE = preload("res://Objects/Bullet/bullet.tscn")

var facing = 1
const SPEED = 300.0
const JUMP_VELOCITY = -500.0
const PUSH_FORCE = 50.0

signal bullet_used

func _physics_process(delta: float) -> void:
	# Add the gravity.
	
	
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		jump()

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
		facing = direction
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	if velocity.x < 0:
		$AnimatedSprite2D.flip_h = true
	elif velocity.x > 0:
		$AnimatedSprite2D.flip_h = false
	
	if is_on_floor():
		jumping = false
	
	if !shooting:
		if !is_on_floor():
			if !jumping:
				$AnimatedSprite2D.play("jump")
				jumping = true
		elif direction:
			$AnimatedSprite2D.play("run")
		else:
			$AnimatedSprite2D.play("idle")
	
	move_and_slide()
	
	# Code for shooting
	if Input.is_action_just_pressed("shoot") and shoot_cd and bullet_count > 0:
		shoot()
	
	# Applying force
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
		if collider is RigidBody2D:
			var push_direction = -collision.get_normal()
			collider.apply_central_impulse(push_direction * PUSH_FORCE)

func jump():
	velocity.y = JUMP_VELOCITY

func shoot():
	shooting = true
	$AnimatedSprite2D.play("shoot")
	while $AnimatedSprite2D.frame < 5:
		await $AnimatedSprite2D.frame_changed
	var bullet = BULLET_SCENE.instantiate()
	bullet.position = position + Vector2(25,-15)
	bullet.direction = facing
	get_parent().add_child(bullet)
	cd_timer(0.5)
	bullet_count -= 1
	bullet_used.emit()
	await $AnimatedSprite2D.animation_finished
	shooting = false

func cd_timer(cd: float):
	shoot_cd = false
	await get_tree().create_timer(cd).timeout
	shoot_cd = true

func die():
	get_tree().reload_current_scene()
