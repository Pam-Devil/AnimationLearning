extends AnimatedSprite
class_name Player_Animations

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func play_animation(animation:String) -> void:
		play(animation)
