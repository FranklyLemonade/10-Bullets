class_name Enemy
extends CharacterBody2D

@export var SPEED = 200.0
@export var JUMP_VELOCITY = -400.0

var can_attack = true

var player: Node2D = null
var player_detected = false
var post: Vector2

@onready var animator = %Animator

func _ready() -> void:
	post = position
	animator.play("idle")
	
	animator.flip_h = false

func _physics_process(delta: float) -> void:
	# gravity
	if not is_on_floor():
		velocity += get_gravity() * delta

	if player_detected and is_instance_valid(player):
		act()
	else:
		var dist = post.x - position.x
		if abs(dist) < 10:
			velocity.x = 0
		else:
			velocity.x = sign(dist) * SPEED / 2
	if velocity.x <= 0:
		transform.x.x = 1
	elif velocity.x > 0:
		transform.x.x = -1
	
	move_and_slide()


func act():
	# get position of player
	var rel_player_pos = player.position - position
	
	# move towards player or attack
	if rel_player_pos.x > 50:
		velocity.x = SPEED
		# animator.play("run")
	elif rel_player_pos.x < -50:
		velocity.x = SPEED * -1
		# animator.play("run")
	else:
		velocity.x = 0
		if abs(rel_player_pos.y) <= 50:
			attack()
	
	# jump
	if rel_player_pos.y < 0 and is_on_floor():
		velocity.y = JUMP_VELOCITY

func attack():
	if !can_attack:
		return
	
	if is_instance_valid(player):
		animator.play("punch")
		player.die()
		can_attack = false

func die():
	queue_free()

func _on_viewbox_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player_detected = true
		player = body

func _on_viewbox_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player_detected = false
		player = null
