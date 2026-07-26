extends CanvasLayer

var bullets = []
var i
@onready var bullet_container = %BulletContainer
@onready var center_display = $Control/CenterDisplay

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	bullet_container.visible = true
	for bullet in bullet_container.get_children():
		bullets.append(bullet)
	i = bullets.size() - 1
	$Control/CenterDisplay.visible = false
	for j in range(9,GameManager.level,-1):
		bullets[i].hide()
		i -= 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _bullet_used():
	bullets[i].hide()
	i -= 1

func _on_player_used_bullets() -> void:
	center_display.texture = load("res://Player/HUD/Sprites/out of bullets.png")
	center_display.visible = true
	
	var timer = get_tree().create_timer(3.0, true)
	await timer.timeout
	get_tree().reload_current_scene()
	

func _on_boss_killed() -> void:
	if GameManager.level == 10:
		center_display.texture = load("res://Player/HUD/Sprites/you win.png")
		center_display.visible = true
		get_tree().paused = true
		return
	
	center_display.texture = load("res://Player/HUD/Sprites/next level.png")
	center_display.visible = true
	
	var timer = get_tree().create_timer(3.0, true)
	await timer.timeout
	get_tree().change_scene_to_file("res://Scenes/Levels/Level" + str(GameManager.level) + ".tscn")


func _on_player_killed() -> void:
	center_display.texture = load("res://Player/HUD/Sprites/you died.png")
	center_display.visible = true
	
	var timer = get_tree().create_timer(3.0, true)
	await timer.timeout
	get_tree().reload_current_scene()
