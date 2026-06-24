class_name MusicPlayer extends FakeWindow
var texture_scale =10
var audio_node:AudioStreamPlayer
var reverse
var play
var forward
var playback:int

func _ready() -> void:
	app_name="Music Player"
	theme_path="res://resources/music_playerGUI.tres"
	style_path="res://assets/music_playerGUI.png"
	super._ready()

func openFile(path):
	audio_node=AudioStreamPlayer.new()
	add_child(audio_node)
	audio_node.stream = load(path)
	audio_node.play()


func togglePlayPause():
	if audio_node.playing:
		playback=audio_node.get_playback_position()
		audio_node.stop()
	else:
		audio_node.play(playback)

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
	
	reverse= createButton(Rect2(0*texture_scale,16*texture_scale,16*texture_scale,16*texture_scale),menu_button_size)
	play=createButton(Rect2(0*texture_scale,0*texture_scale,16*texture_scale,16*texture_scale),menu_button_size)
	forward=createButton(Rect2(16*texture_scale,16*texture_scale,16*texture_scale,16*texture_scale),menu_button_size)
	button_container.add_child(reverse)
	button_container.add_child(play)
	button_container.add_child(forward)
	content.add_child(vbox_container)
	content.add_child(button_container)
	
	play.pressed.connect(togglePlayPause)
	
	openFile(file_path)
	return content
