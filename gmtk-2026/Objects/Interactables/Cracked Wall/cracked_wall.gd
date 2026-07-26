extends StaticBody2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimatedSprite2D.play("default")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _break():
	$AnimatedSprite2D.play("break")
	$CollisionShape2D.set_deferred("disabled", true)
