class_name Folder extends FakeWindow

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	style_path="res://assets/notepadGUI.png"
	theme_path="res://resources/notepadGUI.tres"
	app_name="folder"
	super._ready()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func loadContent():
	var content = baseContent()
	var background = ColorRect.new()
	background.color= Color(0.2,0.2,0.2)
	content.add_child(background)
	background.add_child(openFile(file_path))
	return content

func openFile(path):
	var grid:GridFlowContainer=GridFlowContainer.new()
	var dir:DirAccess=DirAccess.open(path)
	var files:PackedStringArray=dir.get_files()
	for file in files:
		var button:DesktopButton=DesktopButton.new()
		button.path=path+file
		button.set_button("txt")
		grid.add_child(button)
	return grid
