extends Node2D

var score: int  = 0
var highscore: int = 0

@onready var obstacle_spawner = $ObstacleSpawner
@onready var hud = $HUD
@onready var ground = $Ground
@onready var menu = $Menu

const save_file_path = "user://savedata_flappy_bird.save"


func _ready():
	obstacle_spawner.connect("obstacle_created", _on_obstacle_created)
	#hud.update_score(0)
	load_score()
	
func set_score(new_score):
	score = new_score
	hud.update_score(score)

func player_score():
	score += 1
	set_score(score)

func _on_obstacle_created(obs):
	obs.connect("score", player_score)

func new_game():
	obstacle_spawner.start()

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
	
	menu.init_game_over_menu(score, highscore)

func _on_menu_start_game():
	new_game()

func save_highscore():
	var file = FileAccess.open(save_file_path, FileAccess.WRITE)
	file.store_var(highscore)
	print("saving high score to disk...")
	file.close()

func load_score():
	if FileAccess.file_exists(save_file_path):
		var file = FileAccess.open(save_file_path, FileAccess.READ)
		highscore = file.get_var()
		print("Load score from file: " + str(highscore))
		file.close()
	else:
		print("File doesn't exsit...")
		highscore = 0
