extends Enemy

signal killed

func attack():
	pass

func act():
	pass

func die():
	GameManager.level += 1
	emit_signal("killed")
	queue_free()
