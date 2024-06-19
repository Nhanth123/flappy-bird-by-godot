extends CanvasLayer

signal start_game

@onready var start_message = $StartMenu/StartMessage

var game_started = false
var fade_duration = 0.5

func _input(event):
	if event.is_action_pressed("flap") && !game_started:
		emit_signal("start_game")
		game_started = true
		disappear()

func appear():
	visible = true
	
	var tween = get_tree().create_tween()
	tween.tween_property(self, "modulate:a", 1.0, fade_duration)
	return tween
	
func disappear():
	visible = false
	start_message.visible = false
	
	var tween = get_tree().create_tween()
	tween.set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	return tween
