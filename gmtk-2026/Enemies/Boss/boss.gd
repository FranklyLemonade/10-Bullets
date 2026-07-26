extends Enemy

func attack():
	pass

func act():
	pass

func die():
	GameManager.level += 1
	get_tree().change_scene_to_file("res://Scenes/Menus/LevelMenu.tscn")
