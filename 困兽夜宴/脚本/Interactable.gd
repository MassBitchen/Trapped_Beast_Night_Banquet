extends Area2D
class_name Interactable

signal interacted()

var is_self := false

func _init() -> void:
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("tall") and is_self:
		interact()

func interact() -> void:
	# debug
	print("[Interact] %s" % name)
	interacted.emit()

func _on_mouse_entered() -> void:
	is_self = true

func _on_mouse_exited() -> void:
	is_self = false
	
