extends RichTextLabel
func _ready() -> void:
	append_text(get_txt_content("res://presentable/text/first_summer_job.txt"))
func get_txt_content(filePath):
	var file = FileAccess.open(filePath, FileAccess.READ)
	var content = file.get_as_text()
	return content if !content.is_empty() else "bugged"
