extends OptionButton
class_name LanguageButton

func _ready() -> void:
	item_selected.connect(_on_selected)

func _on_selected(index: int) -> void:
	if selected == 0:
		TranslationServer.set_locale("CH")
	elif selected == 1:
		TranslationServer.set_locale("EN")
