extends Node2D

var score: int  = 0
var highscore: int = 0

@onready var obstacle_spawner = $ObstacleSpawner
@onready var hud = $HUD

func _ready():
	print("score at ready method: " + str(score))
	obstacle_spawner.connect("obstacle_created", _on_obstacle_created)
	hud.update_score(0)

func set_score(new_score):
	score = new_score
	print("Got score: " + str(score))
	hud.update_score(score)

func player_score():
	score += 1
	print(score)

func _on_obstacle_created(obs):
	obs.connect("score", player_score)
