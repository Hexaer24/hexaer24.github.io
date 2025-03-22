extends Node

class_name FileManager

var file_associations := {
	"txt": Notepad,
	"mp3": "MusicPlayer",
	"png": "ImageViewer"
}

func open_file(file_path: String):
	var extension = file_path.get_extension()
	if extension in file_associations:
		var app_name = file_associations[extension]
		var app_instance =app_name.new()
		app_instance.openFile(file_path)
		return app_instance
	else:
		print("No application associated with this file type: " + extension)
		return
