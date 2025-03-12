extends Node2D
class_name Npc

# 对话框
@onready var dialog: CanvasLayer = $dialog
@onready var panel_container: PanelContainer = $dialog/PanelContainer
@onready var content: RichTextLabel = $dialog/PanelContainer/MarginContainer/Content
@onready var dialog_bg: ColorRect = $dialog/PanelContainer/dialogBG
@onready var continue_dialog: Interactable = $dialog/continue_dialog
var dialogs = []
var current = -1
var content_tween: Tween
var panel_tween: Tween

func _ready() -> void:
	hide_dialog_box()

func _unhandled_input(event: InputEvent) -> void:
	pass

func show_dialog_box(_dialogs):
	if not panel_container.visible:
		dialogs = _dialogs
		panel_container.show()
		continue_dialog.show()
		panel_tween = create_tween()
		panel_tween.tween_property(panel_container, "scale", Vector2.ONE, 0.2).from(Vector2.ONE * 0.9)
		_show_dialog(0)

func _show_dialog(index):
	current = index
	var dialog = dialogs[current]
	content.visible_ratio = 0
	content.text = tr(dialog.text)
	content_tween = create_tween()
	content_tween.tween_property(content, "visible_ratio", 1, 1)
	
	panel_tween = create_tween()
	panel_tween.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BACK)
	panel_tween.tween_property(panel_container, "scale", Vector2.ONE, 0.3).from(Vector2.ONE * 0.9)

func hide_dialog_box() -> void:
	panel_container.hide()
	continue_dialog.hide()


func _on_interactable_interacted() -> void:
	show_dialog_box([
		{text = "欢迎来到酒馆"},
		{text = "这里准备了一些食物"},
		{text = "你也可以不吃回去"},
		{text = "我想吃火锅"}
		])

func _on_continue_dialog_interacted() -> void:
	if panel_container.visible:
		if content_tween.is_running():
			content_tween.custom_step(1)
		elif current + 1 < dialogs.size(): 
			_show_dialog(current + 1)
		else:
			hide_dialog_box()
	get_viewport().set_input_as_handled()
