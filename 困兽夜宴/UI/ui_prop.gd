extends Control

@onready var expand: Button = $Expand
@onready var close: Button = $Close
@onready var bag: GridContainer = $PanelContainer/bag/bag

@onready var item_texture: TextureRect = $Control/item_texture
@onready var item_description: RichTextLabel = $Control/item_description
@onready var item_name: Label = $Control/item_name

@onready var page_button: Button = $page

var page :int = 1
var now_page :int = 1

func _ready() -> void:
	item_texture.texture = null
	item_description.text = str("")
	item_name.text = str("")
	
	expand.pressed.connect(_on_expand_pressed)
	close.pressed.connect(_on_close_pressed)
	_on_updata_bag()
	UiMain.inventory.connect("changed", Callable(self,"_on_updata_bag"))
	for child in bag.get_children():
		child.connect("is_pressed", Callable(self,"_on_updata_itemdata"))

func _on_updata_itemdata(item: Item) -> void:
	if item:
		item_texture.texture = item.prop_texture
		item_description.text = item.description
		item_name.text = str(item.item_name)
	else:
		item_texture.texture = null
		item_description.text = str("")
		item_name.text = str("")

func _on_updata_bag() -> void:
	var i = page
	page = ceil(float(UiMain.inventory.get_item_count())/6)
	if i != page:
		now_page = page
	if page > 1:
		page_button.visible = true
	else:
		page_button.visible = false
	if now_page > page:
		now_page = 1
	for child in bag.get_children():
		child.item = null
	print(now_page)
	if now_page == 1:
		var k := 0
		for item in UiMain.inventory._items:
			bag.get_child(k).item = item
			k += 1
			if k == 6:
				break
	elif now_page == 2:
		var k := 0
		for item in UiMain.inventory._items:
			if k > 5:
				bag.get_child(k-6).item = item
			k += 1
			if k == 12:
				break
	elif now_page == 3:
		var k := 0
		for item in UiMain.inventory._items:
			bag.get_child(k).item = item
			k += 1
			if k == 6:
				break

func _on_page_pressed() -> void:
	item_texture.texture = null
	item_description.text = str("")
	if now_page < page:
		now_page += 1
	else:
		now_page = 1
	_on_updata_bag()

func _on_expand_pressed() -> void:
	var expand_tween = create_tween()
	expand_tween.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE)
	expand_tween.tween_property(self, "position", Vector2(0,0), 0.3).from(Vector2(1782,0))

func _on_close_pressed() -> void:
	var close_tween = create_tween()
	close_tween.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE)
	close_tween.tween_property(self, "position", Vector2(1782,0), 0.3).from(Vector2(0,0))
