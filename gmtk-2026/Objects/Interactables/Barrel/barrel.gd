extends RigidBody2D

const EXPLOSION_SCN = preload("res://Objects/Explosion/explosion.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimatedSprite2D.play("default")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _break():
	var explosion = EXPLOSION_SCN.instantiate()
	explosion.global_position = position
	remove_from_group("Breakables")
	get_tree().current_scene.add_child(explosion)
	$AnimatedSprite2D.play("burn")
	await $AnimatedSprite2D.animation_finished
	queue_free()
