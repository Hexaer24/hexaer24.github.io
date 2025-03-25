class_name MusicPlayer extends FakeWindow

func _ready() -> void:
	app_name="Music Player"
	theme_path="res://resources/notepadGUI.tres"
	style_path="res://assets/music_playerGUI.png"
	super._ready()

func openFile(path):
	pass

func loadContent():
	var content = baseContent()
	var button_container=HBoxContainer.new()
	button_container.add_child(createButton(Rect2(0,0,16,16)))
	content.add_child(button_container)
	return content
