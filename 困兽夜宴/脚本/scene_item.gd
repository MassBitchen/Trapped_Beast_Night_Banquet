@tool
extends Interactable
class_name scene_item

@export var item: Item : set = set_item
@export var texture: Texture

func _init() -> void:
	super()
	interacted.connect(_on_interacted)

func _ready() -> void:
	if Engine.is_editor_hint():
		return
	if Global.flags.has(_get_flag()):
		queue_free()

func _on_interacted() -> void:
	Global.flags.add(_get_flag())
	UiMain.inventory.add_item(item)
	
	var sprite := Sprite2D.new()
	sprite.name = "InteractEffect"
	sprite.texture = item.scene_texture
	sprite.global_position = self.global_position
	sprite.scale = Vector2.ONE
	get_parent().add_child(sprite)
	
	var queue_tween := create_tween().bind_node(sprite).set_parallel(false)
	queue_tween.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BACK)
	queue_tween.tween_property(sprite, "scale", Vector2.ZERO, 0.5)
	queue_tween.tween_callback(sprite.queue_free)
	queue_free()

func _get_flag() -> String:
	return "picked:" + item.resource_path.get_file()

func set_item(v: Item) -> void:
	item = v
	texture = v.scene_texture
	
	for node in get_children():
		if node.owner == null:
			node.queue_free()
	if texture == null:
		return
	var sprtie := Sprite2D.new()
	sprtie.texture = texture
	add_child(sprtie)
	
	var rect := RectangleShape2D.new()
	rect.size = Vector2(texture.get_size())
	var collider := CollisionShape2D.new()
	collider.shape = rect
	add_child(collider)
