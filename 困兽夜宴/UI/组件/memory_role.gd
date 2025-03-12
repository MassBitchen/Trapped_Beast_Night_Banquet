extends HBoxContainer

@onready var animals: GridContainer = $CanvasLayer/animals
@onready var spy_board: Control = $CanvasLayer/spy_board

@onready var back: Button = $CanvasLayer/spy_board/Back
# 要删除
@onready var text: Label = $guess/text
@onready var color_rect: ColorRect = $CanvasLayer/ColorRect

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("tall"):
		animals.hide()
		color_rect.hide()

func _ready() -> void:
	back.pressed.connect(_on_back)

func _on_guess_pressed() -> void:
	if animals.visible:
		animals.hide()
		color_rect.hide()
	elif not animals.visible:
		animals.show()
		color_rect.show()

func _on_real_pressed() -> void:
	animals.hide()
	color_rect.hide()
	spy_board.show()
	var spy_tween = create_tween()
	spy_tween.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE)
	spy_tween.tween_property(spy_board, "modulate", Color(1,1,1,1), 0.3).from(Color(1,1,1,0))

func _on_back() -> void:
	var close_tween = create_tween()
	close_tween.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE)
	close_tween.tween_property(spy_board, "modulate", Color(1,1,1,0), 0.3).from(Color(1,1,1,1))
	close_tween.tween_callback(spy_board.hide)

func _on_ani_1_pressed() -> void:
	text.text = str(1)
	animals.hide()
	color_rect.hide()
func _on_ani_2_pressed() -> void:
	text.text = str(2)
	animals.hide()
	color_rect.hide()
func _on_ani_3_pressed() -> void:
	text.text = str(3)
	animals.hide()
	color_rect.hide()
func _on_ani_4_pressed() -> void:
	text.text = str(4)
	animals.hide()
	color_rect.hide()
func _on_ani_5_pressed() -> void:
	text.text = str(5)
	animals.hide()
	color_rect.hide()
func _on_ani_6_pressed() -> void:
	text.text = str(6)
	animals.hide()
	color_rect.hide()
func _on_ani_7_pressed() -> void:
	text.text = str(7)
	animals.hide()
	color_rect.hide()
func _on_ani_8_pressed() -> void:
	text.text = str(8)
	animals.hide()
	color_rect.hide()
