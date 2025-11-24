class_name Notepad extends FakeWindow

func _ready() -> void:
	#TODO merge both image and theme
	style_path="res://assets/notepadGUI.png"
	theme_path="res://resources/notepadGUI.tres"
	app_name="Notepad"
	super._ready()

func openFile(path):
	var text_res=load(path) as TextResource
	windows[self]= path
	var content_text=RichTextLabel.new()
	print(path)
	content_text.append_text(text_res.text)
	content_text.bbcode_enabled=true
	content_text.connect("meta_clicked",handle_url)
	return content_text
	
func handle_url(type):
	OS.shell_open(str(type))
	
func loadContent():
	var content = baseContent()
	
	var background = ColorRect.new()
	background.color= Color(0.2,0.2,0.2)
	
	var content_text= openFile(file_path)

	content.add_child(background)
	content.add_child(content_text)
	return content

func get_txt_content(filePath):
	var file = FileAccess.open(filePath, FileAccess.READ)
	var content = file.get_as_text()
	return content
