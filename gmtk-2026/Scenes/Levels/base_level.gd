extends Node2D

@onready var player = %Player
@onready var hud = %PlayerHud

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player.bullet_used.connect(hud._bullet_used)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
