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
	var play=createButton(Rect2(0,0,16,16))
	play.size_flags_vertical=Control.SIZE_SHRINK_BEGIN
	button_container.set_anchors_preset(Control.PRESET_CENTER_BOTTOM)
	button_container.add_child(play)
	content.add_child(button_container)
	print(content.size)
	return content
