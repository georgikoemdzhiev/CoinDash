extends Area2D

signal pickup
signal hurt

export (int) var Speed = 350
var velocity: Vector2 = Vector2()
var screenSize: Vector2 = Vector2(480,720)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	get_input()
	
	position += velocity * delta
	position.x = clamp(position.x, 0, screenSize.x)
	position.y = clamp(position.y, 0, screenSize.y)
	
	if velocity.length() > 0:
		$AnimatedSprite.animation = "run"
		$AnimatedSprite.flip_h = velocity.x < 0
	else:
		$AnimatedSprite.animation = "idle"
	
func get_input():
	velocity = Vector2()
	if Input.is_action_pressed("ui_left"):
 		velocity.x -= 1
	if Input.is_action_pressed("ui_right"):
        velocity.x += 1
	if Input.is_action_pressed("ui_up"):
        velocity.y -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if velocity.length() > 0:
		velocity = velocity.normalized() * Speed

func start(pos : Vector2):
	position = pos
	set_process(true)
	$AnimatedSprite.animation = "idle"

func die():
	$AnimatedSprite.animation = "hurt"
	set_process(false)

func _on_Player_area_entered(area: Area2D):
	if area.is_in_group("coins"):
		area.pickup()
		emit_signal("pickup")
	if area.is_in_group("obstacles"):
		emit_signal("hurt")
		die()
