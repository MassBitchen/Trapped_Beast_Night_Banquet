extends Button
class_name ItemSlot

@export var item: Item : set = set_item

signal is_pressed()

func _ready() -> void:
	expand_icon = true
	pressed.connect(_on_pressed)

func _process(delta: float) -> void:
	disabled = item == null

func _on_pressed() -> void:
	emit_signal("is_pressed", item)

func set_item(v: Item) -> void:
	item = v
	if item == null:
		self.icon = null
		return
	self.icon = item.prop_texture
