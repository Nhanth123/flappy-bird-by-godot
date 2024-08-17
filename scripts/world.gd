extends Node2D

@onready var obstacle_spawner = $ObstacleSpawner
@onready var hud = $HUD
@onready var ground = $Ground
@onready var menu = $Menu

const save_file_path = "user://savedata_flappy_bird.save"

var score := 0:
	set(value):
		score = value
		hud.score_label = score

var highscore: int = 0

func _ready():
	score = 0
	obstacle_spawner.obstacle_created.connect(_on_obstacle_created)
	load_score()

func _process(_delta):
	if Input.is_action_just_pressed("reset"):
		get_tree().reload_current_scene()
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()


func _on_deathzone_body_entered(body):
	if body is Player:
		if body.has_method("die"):
			body.die()

func _on_player_died():
	game_over()

func game_over():
	obstacle_spawner.stop()
	ground.get_node("AnimationPlayer").stop()
	get_tree().call_group("obstacles", "set_physics_process", false)
	
	if score > highscore:
		highscore = score
		save_highscore()
	
	await get_tree().create_timer(1).timeout
	menu.init_game_over_menu(score, highscore)


func save_highscore():
	var file = FileAccess.open(save_file_path, FileAccess.WRITE)
	file.store_var(highscore)
	file.close()

func load_score():
	if FileAccess.file_exists(save_file_path):
		var file = FileAccess.open(save_file_path, FileAccess.READ)
		highscore = file.get_var()
		file.close()
	else:
		highscore = 0
		
func _on_obs_player_score():
	score = score + 1

func _on_obstacle_created(obs):
	obs.score.connect(_on_obs_player_score)
