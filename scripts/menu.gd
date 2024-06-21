extends CanvasLayer

signal start_game

@onready var start_message = $StartMenu/StartMessage
@onready var score_label = $GameoverMenu/VBoxContainer/ScoreLabel
@onready var high_score_label = $GameoverMenu/VBoxContainer/HighScoreLabel
@onready var gameover_menu = $GameoverMenu

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
	tween.tween_property(self, "modulate:a", 0, fade_duration)
	return tween

func init_game_over_menu(score):
	print("go to game over screen")
	score_label.text = "SCORE: " + str(score)
	gameover_menu.visible = true

func _on_restart_btn_pressed():
	get_tree().reload_current_scene()
