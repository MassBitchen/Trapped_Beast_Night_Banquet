extends Interactable
class_name Telepoter

@export_file("*.tscn") var path: String

func _init() -> void:
	super()
	interacted.connect(_on_interacted)

func _on_interacted() -> void:
	Game.change_sence(path)
