extends Node2D

@onready var timer = $Timer

var global_obstacle = preload("res://obstacle.tscn")

func _ready():
	randomize()

func _on_timeout():
	spawn_obstacle()

func spawn_obstacle():
	var obstacle = global_obstacle.instantiate()
	add_child(obstacle)
	obstacle.position.y = randi()%400 + 150 #Get a random number between 150 - 550
	
func start():
	timer.start()

func stop():
	timer.stop()
