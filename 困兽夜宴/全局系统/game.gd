extends CanvasLayer

@onready var cutsences: ColorRect = $cutsences

const CONFIG_PATH := "user://config.ini"

func _ready() -> void:
	load_config()

# 切换场景
func change_sence(path: String) -> void:
	var tree := get_tree()
	tree.paused = true
	
	var tween := create_tween()
	tween.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE)
	tween.set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	tween.tween_property(cutsences, "color:a", 1, 0.2)
	await tween.finished
	
	get_tree().change_scene_to_file(path)
	
	await tree.tree_changed
	tree.paused = false
	
	tween = create_tween()
	tween.set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	tween.tween_property(cutsences, "color:a", 0, 0.2)

# 系统设置保存
func save_config() -> void:
	var config := ConfigFile.new()
	config.set_value("audio", "master", SoundManager.get_volume(SoundManager.Bus.MASTER))
	config.set_value("audio", "sfx", SoundManager.get_volume(SoundManager.Bus.SFX))
	config.set_value("audio", "bgm", SoundManager.get_volume(SoundManager.Bus.BGM))
	config.save(CONFIG_PATH)
func load_config() -> void:
	var config := ConfigFile.new()
	config.load(CONFIG_PATH)
	SoundManager.set_volume(
		SoundManager.Bus.MASTER,
		config.get_value("audio", "master", 0.5)
	)
	SoundManager.set_volume(
		SoundManager.Bus.SFX,
		config.get_value("audio", "sfx", 1.0)
	)
	SoundManager.set_volume(
		SoundManager.Bus.BGM,
		config.get_value("audio", "bgm", 1.0)
	)
