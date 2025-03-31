class_name MusicPlayer extends FakeWindow

func _ready() -> void:
	app_name="Music Player"
	theme_path="res://resources/notepadGUI.tres"
	style_path="res://assets/music_playerGUI.png"
	super._ready()

func openFile(path):
	pass

func loadContent():
	var menu_button_size=Vector2(40,40)
	var content = baseContent()
	var button_container=HBoxContainer.new()
	var reverse= createButton(Rect2(32,0,16,16),menu_button_size)
	var play=createButton(Rect2(0,0,16,16),menu_button_size)
	var forward=createButton(Rect2(48,0,16,16),menu_button_size)
	button_container.add_child(reverse)
	button_container.add_child(play)
	button_container.add_child(forward)
	button_container.size_flags_vertical=Control.SIZE_SHRINK_END
	button_container.size_flags_horizontal=Control.SIZE_SHRINK_CENTER
	content.add_child(button_container)
	print(content.size)
	return content
