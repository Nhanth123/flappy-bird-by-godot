extends CanvasLayer

@onready var score_label = $Score

func update_score(new_score):
	print("score at hud screen: " + str(new_score))
	score_label.text = str(new_score)
