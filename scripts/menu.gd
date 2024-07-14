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
	
	
func disappear():
	visible = false
	start_message.visible = false
	

func init_game_over_menu(score, highscore):
	gameover_menu.visible = true
	print("Go to game over screen")
	score_label.text = "SCORE: " + str(score)
	high_score_label.text = "BEST: " + str(highscore)

func _on_restart_btn_pressed():
	get_tree().reload_current_scene()
