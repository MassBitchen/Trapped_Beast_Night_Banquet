extends CanvasLayer

@onready var ui_prop: Control = $ui_prop
@onready var options: Control = $options
@onready var memory: Control = $memory

class Inventory:
	signal changed
	
	var active_item :Item
	
	var _items := []
	var _current_item_index := -1
	
	func get_item_count() -> int:
		return _items.size()
	
	func get_current_item() -> Item:
		if _current_item_index == -1:
			return null
		return _items[_current_item_index]
	
	func add_item(item: Item):
		if item in _items:
			return
		_items.append(item)
		changed.emit()
	
	func remove_item(item: Item):
		var index := _items.find(item)
		if index == -1:
			return
		_items.remove_at(index)
		if _current_item_index > _items.size() - 1:
			_current_item_index = 0
		changed.emit()

var inventory := Inventory.new()

func  _ready() -> void:
	options.visibility_changed.connect(func ():
		get_tree().paused = options.visible
	)

func _on_m_pressed() -> void:
	memory.show()
	var memory_open_tween = create_tween()
	memory_open_tween.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE)
	memory_open_tween.tween_property(memory, "modulate", Color(1,1,1,1), 0.3).from(Color(1,1,1,0))
	
func _on_o_pressed() -> void:
	options.show()
	var options_open_tween = create_tween()
	options_open_tween.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE)
	options_open_tween.tween_property(options, "modulate", Color(1,1,1,1), 0.3).from(Color(1,1,1,0))
