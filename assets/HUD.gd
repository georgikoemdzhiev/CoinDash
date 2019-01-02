extends CanvasLayer

signal start_game

func update_score(score:int):
	$MarginContainer/ScoreLabel.text = str(score)

func update_timer(time:int):
	$MarginContainer/TimeLabel.text = str(time)

func show_message(text:String):
	$MessageLabel.text = text
	$MessageLabel.show()
	$MessageTimer.start()

func _on_MessageTimer_timeout():
	$MessageLabel.hide()

func game_over():
	show_message("Game Over")
	yield($MessageTimer, "timeout")
	$StartButton.show()
	$MessageLabel.text = "Coin Dash!"
	$MessageLabel.show()
	
func _on_Button_pressed():
	$MessageLabel.hide()
	$StartButton.hide()
	emit_signal("start_game")
