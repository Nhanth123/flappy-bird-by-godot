extends Node2D

signal score

@onready var point = $Point

const SPEED = 215

func _physics_process(delta):
	position.x += -SPEED * delta
	if global_position.x <= -450:
		queue_free()

func _on_wall_body_entered(body):
	if body is Player:
		if body.has_method("die"):
			body.die()

func _on_score_area_body_exited(body):
	if body is Player:
		point.play()
		score.emit()
