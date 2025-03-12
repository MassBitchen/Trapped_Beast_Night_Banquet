extends HSlider
class_name VolumeSlider

@export var bus: StringName = "Master"

@onready var bus_index := AudioServer.get_bus_index(bus)

func _ready() -> void:
	max_value = 1.0
	step = 0.0
	value = SoundManager.get_volume(bus_index)
	print(SoundManager.get_volume(bus_index))
	
	value_changed.connect(func (v: float):
		SoundManager.set_volume(bus_index, v)
		Game.save_config()
	)
