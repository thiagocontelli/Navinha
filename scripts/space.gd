extends Node2D

@export var enemy_scenes: Array[PackedScene] = []
@onready var enemy_container = $EnemyContainer
@onready var hud = $UILayer/HUD
@onready var gos = $UILayer/GameOverScreen
@onready var player = $Player
@onready var enemy_spawn_timer = $EnemySpawnTimer

var score := 0:
	set(value):
		score = value
		hud.score = score
		
var high_score

func _ready():
	var save_file = FileAccess.open("user://save.data", FileAccess.READ)
	if save_file != null:
		high_score = save_file.get_32()
	else:
		high_score = 0
		save_game()
	score = 0
	player.killed.connect(_on_player_killed)
	
func _process(delta):
	if enemy_spawn_timer.wait_time > 0.25:
		enemy_spawn_timer.wait_time -= delta * 0.005
		
	if enemy_spawn_timer.wait_time < 0.25:
		enemy_spawn_timer.wait_time = 0.25

func save_game():
	var save_file = FileAccess.open("user://save.data", FileAccess.WRITE)
	save_file.store_32(high_score)

func _on_enemy_spawn_timer_timeout():
	var enemy_instance = enemy_scenes.pick_random().instantiate()
	enemy_instance.position = Vector2(randf_range(50, 1870), -50)
	enemy_instance.killed.connect(_on_enemy_killed)
	enemy_container.add_child(enemy_instance)
	
func _on_enemy_killed(points):
	score += points
	if score > high_score:
		high_score = score
	
func _on_player_killed():
	gos.set_score(score)
	gos.set_high_score(high_score)
	save_game()
	await get_tree().create_timer(0.75).timeout
	gos.visible = true
	
	
