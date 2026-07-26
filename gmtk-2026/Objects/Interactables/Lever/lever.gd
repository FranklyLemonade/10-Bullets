extends Area2D

@export var platform: Node2D


var flicked = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimatedSprite2D.play("default")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _break():
	if !flicked:
		platform.act()
		flicked = true
		$AnimatedSprite2D.play("flicked")
