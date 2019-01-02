extends Node2D

export (PackedScene) var Coin = preload("res://assets/coin/Coin.tscn")
export (int) var Playtime = 30

var level : int
var score : int
var time_left : int
var playing : bool
var screensize : Vector2


func _ready():
	randomize()
	screensize = get_viewport().size
	$Player.screenSize = screensize
	$Player.hide()
	
func new_game():
	playing = true
	level = 1
	score = 0
	time_left = Playtime
	$Player.start($PlayerStartPosition.position)
	$Player.show()
	$GameTimer.start()
	spawn_coins()
	$HUD.update_score(score)
	$HUD.update_time(time_left)
	
func spawn_coins():
	for i in range(4 + level):
		var c = Coin.instance()
		$CoinContainer.add_child(c)
		c.screensize = screensize
		c.position = Vector2(rand_range(0, screensize.x), rand_range(0, screensize.y))

func _process(delta):
	if playing and $CoinContainer.get_child_count() == 0:
		level += 1
		time_left += 5
		spawn_coins()

func _on_GameTimer_timeout():
	time_left -= 1
	$HUD.update_time(time_left)
	if time_left < 0:
		game_over()

func _on_Player_pickup():
	score += 1
	$HUD.update_score(score)
	
func _on_Player_hurt():
	game_over()

func game_over():
	playing = false
	$HUD.game_over()
	$GameTimer.stop()
	clear_any_remaining_coins()
	$Player.die()
	$HUD.game_over()

func clear_any_remaining_coins():
	for c in $CoinContainer.get_children():
		c.queue_free()

