class_name MusicPlayer extends FakeWindow

func _ready() -> void:
	app_name="Music Player"
	super._ready()

func openFile(path):
	var content = baseContent()
	return content
