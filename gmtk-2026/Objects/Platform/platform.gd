extends AnimatableBody2D

@export var move_offset: Vector2 = Vector2(0, -100)
@export var move_duration: float = 1.5

var start_pos: Vector2
var _tween: Tween

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	start_pos = position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func act():
	_tween = create_tween()
	_tween.set_loops()
	_tween.set_trans(Tween.TRANS_SINE)
	_tween.set_ease(Tween.EASE_IN_OUT)
	
	_tween.tween_property(self, "position", start_pos + move_offset, move_duration)
	_tween.tween_property(self, "position", start_pos, move_duration)
