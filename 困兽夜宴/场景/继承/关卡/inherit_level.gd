extends Node2D
class_name Level

@onready var camera_2d: Camera2D = $Camera2D

func _ready() -> void:
	var entry_tween = create_tween()
	entry_tween.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE)
	entry_tween.tween_property(self, "scale", Vector2.ONE, 0.3).from(Vector2.ONE * 1.05)
