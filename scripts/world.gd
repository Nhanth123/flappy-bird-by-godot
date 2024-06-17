extends Node2D

var score: int  = 0
var highscore: int = 0

@onready var obstacle_spawner = $ObstacleSpawner
@onready var hud = $HUD
@onready var ground = $Ground

func _ready():
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

func _on_death_zone_body_entered(body):
	if body is Player:
		if body.has_method("die"):
			body.die()

func _on_player_died():
	game_over()
	
func game_over():
	obstacle_spawner.stop()
	ground.get_node("AnimationPlayer").stop()
	get_tree().call_group("obstacles","set_physics_process", false)
