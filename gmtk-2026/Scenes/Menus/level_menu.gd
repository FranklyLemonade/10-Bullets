extends Control

@onready var level_selector = $TextureRect/HBoxContainer
var buttons = []
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for child in level_selector.get_children():
		if child is TextureButton:
			buttons.append(child)
			child.pressed.connect(_on_button_pressed.bind(child))

func _on_button_pressed(button_node: TextureButton) -> void:
	get_tree().change_scene_to_file("res://Scenes/Levels/Level" + str(buttons.find(button_node)) + ".tscn")
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
