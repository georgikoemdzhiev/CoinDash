extends Area2D

var screensize = Vector2()

func _ready():
	$Tween.interpolate_property(
		$AnimatedSprite, "scale",
		$AnimatedSprite.scale,
		$AnimatedSprite.scale * 3, 0.3,
		Tween.TRANS_QUAD,Tween.EASE_IN_OUT)
		
	$Tween.interpolate_property(
		$AnimatedSprite, "modulate",
		Color(1,1,1,1),
		Color(1,1,1,0), 0.3,
		Tween.TRANS_QUAD, Tween.EASE_IN_OUT)


func pickup():
	# Setting monitoring to false ensures that the area_enter() signal won't be emitted
	# if the player touches the coin during the tween animation.
	monitoring = false
	$Tween.start()

func _on_Tween_tween_completed(object, key):
	queue_free()
