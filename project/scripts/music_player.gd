class_name MusicPlayer extends FakeWindow
var texture_scale =10

func _ready() -> void:
	app_name="Music Player"
	theme_path="res://resources/music_playerGUI.tres"
	style_path="res://assets/music_playerGUI.png"
	super._ready()

func openFile(path):
	pass

func loadContent():
	var content = baseContent()
	var menu_button_size=Vector2(40,40)
	
	var scroll_container= ScrollContainer.new()
	var vbox_container=VBoxContainer.new()
	vbox_container.size_flags_horizontal=Control.SIZE_SHRINK_BEGIN
	vbox_container.size_flags_vertical=Control.SIZE_FILL

	var button=Button.new()
	button.custom_minimum_size=Vector2(50,20)
	vbox_container.add_child(button)
	
	var button_container=HBoxContainer.new()
	button_container.size_flags_vertical=Control.SIZE_SHRINK_END
	button_container.size_flags_horizontal=Control.SIZE_SHRINK_CENTER
	
	var reverse= createButton(Rect2(0*texture_scale,16*texture_scale,16*texture_scale,16*texture_scale),menu_button_size)
	var play=createButton(Rect2(0*texture_scale,0*texture_scale,16*texture_scale,16*texture_scale),menu_button_size)
	var forward=createButton(Rect2(16*texture_scale,16*texture_scale,16*texture_scale,16*texture_scale),menu_button_size)
	button_container.add_child(reverse)
	button_container.add_child(play)
	button_container.add_child(forward)
	content.add_child(vbox_container)
	content.add_child(button_container)
	return content
