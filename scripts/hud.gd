extends CanvasLayer

@onready var score_label = $ScoreLabel:
	set(value):
		score_label.text = str(value)
	
