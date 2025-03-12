extends Control

@onready var back: Button = $Back

signal back_pressed()

func _ready() -> void:
	back.pressed.connect(_on_back)

func _on_back() -> void:
	back_pressed.emit()
	var close_tween = create_tween()
	close_tween.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE)
	close_tween.tween_property(self, "modulate", Color(1,1,1,0), 0.3).from(Color(1,1,1,1))
	close_tween.tween_callback(self.hide)
