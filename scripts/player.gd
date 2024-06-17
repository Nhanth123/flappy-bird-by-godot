extends RigidBody2D

class_name Player

signal died

@export var FLAP_FORCE = -340

@onready var animator = $AnimationPlayer

const MAX_ROTATION_DEGREES = -30.0

var started = false
var alive = true

func _physics_process(_delta):
	if Input.is_action_just_pressed("flap") && alive:
		if !started:
			start()
		flap()
	
	if rotation_degrees <= MAX_ROTATION_DEGREES:
		angular_velocity = 0
		rotation_degrees = MAX_ROTATION_DEGREES
	
	if linear_velocity.y > 0:
		if rotation_degrees <= 90:
			angular_velocity = 5
		else:
			angular_velocity = 0
	
func start():
	if started: return
	started = true
	gravity_scale = 1.0
	animator.play("flap")
	
func flap():
	linear_velocity.y = FLAP_FORCE
	angular_velocity = -8.0

func die():
	if !alive: return
	alive = false
	animator.stop()
	emit_signal("died")
	
