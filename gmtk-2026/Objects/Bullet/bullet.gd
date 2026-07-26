extends Area2D

var direction
var speed = 1000

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	speed *= direction
	if direction < 0:
		$Sprite2D.flip_h = true
		position = position - Vector2(50, 0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.x += speed * delta


func screen_exited() -> void:
	queue_free()



func _on_body_entered(body: Node2D) -> void:
	handle_hit(body)


func _on_area_entered(area: Area2D) -> void:
	handle_hit(area)


func handle_hit(body):
	if body.is_in_group("Enemies"):
		body.die()
		queue_free()
	if body.is_in_group("Breakables"):
		body._break()
		queue_free()
