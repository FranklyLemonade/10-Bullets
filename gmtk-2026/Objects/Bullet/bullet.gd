extends Area2D

var direction
var speed = 700

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	speed *= direction


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.x += speed * delta


func screen_exited() -> void:
	queue_free()


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Enemies"):
		body.die()
		queue_free()
	if body.is_in_group("Breakables"):
		body.break()
		queue_free()
