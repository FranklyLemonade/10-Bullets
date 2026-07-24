extends Area2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await get_tree().physics_frame
	await get_tree().physics_frame
	
	var objects_hit = self.get_overlapping_bodies()
	for object in objects_hit:
		if object.is_in_group("Enemies"):
			object.die()
		elif object.is_in_group("Player"):
			object.die()
		elif object.is_in_group("Breakables"):
			object._break()
	
	$AnimatedSprite2D.play("explode")
	await $AnimatedSprite2D.animation_finished
	queue_free()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
