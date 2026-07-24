extends CanvasLayer

var bullets = []
var i
@onready var bullet_container = %BulletContainer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for bullet in bullet_container.get_children():
		bullets.append(bullet)
	i = bullets.size() - 1


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _bullet_used():
	bullets[i].hide()
	i -= 1
