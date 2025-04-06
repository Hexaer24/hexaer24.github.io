class_name FakeWindow extends PanelContainer
var dragging :=false; var drag_offset := Vector2.ZERO
var resizing := false; var resize_direction := Vector2.ZERO
var drag_start_pos := Vector2.ZERO; var drag_start_size := Vector2.ZERO
var min_size := Vector2(100, 100); var max_size := Vector2(1000,600)
var is_maximized = false
var style_path; var theme_path; var app_name; var file_path
var prev_size = Vector2.ZERO
var prev_position
const button_size = Vector2(20,20)
const viewport:NodePath="../../../"
static var windows:Dictionary

func _ready() -> void:
	z_index=1
	size=Vector2(400,200)
	scale=Vector2.ZERO
	prev_position=position
	createWindow()
	var tween= get_tree().create_tween()
	tween.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CIRC)
	tween.tween_property(self,"scale",Vector2(1,1),0.5)

func loadSeparation():
	var slice = BoxContainer.new()
	slice.theme=load(theme_path)
	slice.vertical=true
	slice.add_theme_constant_override("separation",0)
	return slice

func baseContent():
	var content= PanelContainer.new()
	content.size_flags_vertical = Control.SIZE_EXPAND_FILL
	return content

func createWindow(): #Order is still important now
	var slice = loadSeparation()
	add_child(slice)
	slice.add_child(loadTitle())
	slice.add_child(loadContent())
	add_child(resize())
	
func resize():
	var resize_handle = Control.new()
	resize_handle.custom_minimum_size = button_size  #Resize area size
	resize_handle.set_anchors_preset(Control.PRESET_BOTTOM_RIGHT)
	resize_handle.size_flags_vertical =Control.SIZE_SHRINK_END
	resize_handle.size_flags_horizontal =Control.SIZE_SHRINK_END
	resize_handle.mouse_default_cursor_shape = Control.CURSOR_FDIAGSIZE
	resize_handle.connect("gui_input", _on_resize_handle_input)
	return resize_handle

func loadContent():         #Would be abstract
	var content= ColorRect.new()
	content.color=Color(1,1,1)
	return content

func loadTitle():
	var titleBar=PanelContainer.new()
	titleBar.add_child(loadTitleName())
	titleBar.size_flags_horizontal =Control.SIZE_EXPAND_FILL
	titleBar.size_flags_vertical = Control.SIZE_SHRINK_BEGIN
	titleBar.size.y =  button_size.y
	titleBar.connect("gui_input", _on_titlebar_gui_input)
	loadButtons(titleBar)
	titleBar.mouse_filter=Control.MOUSE_FILTER_PASS
	return titleBar

func loadTitleName():
	var title_name=RichTextLabel.new()
	title_name.mouse_filter=Control.MOUSE_FILTER_IGNORE
	title_name.append_text("[font_size=14]"+app_name+"[/font_size]")
	return title_name

func createButton(region,b_size=size)->TextureButton:
	var button:TextureButton = TextureButton.new()
	button.custom_minimum_size=b_size
	var button_texture=AtlasTexture.new()
	button_texture.set_atlas(load(style_path))
	button_texture.set_region(region)
	button.ignore_texture_size=true
	button.stretch_mode=TextureButton.STRETCH_SCALE
	button.focus_mode = Control.FOCUS_NONE
	button.texture_normal=button_texture
	return button
	
func loadButtons(title):
	var button_container= HBoxContainer.new()
	button_container.add_theme_constant_override("separation", 0)
	button_container.custom_minimum_size.y=button_size.y
	button_container.size_flags_horizontal=Control.SIZE_SHRINK_END
	
	var close = createButton(Rect2(550,90,90,90),button_size)
	close.connect("button_down", _on_close_input)
	
	var maximize_button = createButton(Rect2(470,90,80,90),button_size)
	maximize_button.connect("button_down", _on_maximize_pressed)
	
	button_container.add_child(maximize_button)
	button_container.add_child(close)
	title.add_child(button_container)
	
func _on_titlebar_gui_input(event):
	if event is InputEventMouseButton:
		dragging = event.pressed
		drag_offset = event.position if dragging else drag_offset
	elif event is InputEventMouseMotion and dragging:
		global_position += event.position - drag_offset
		
func _on_resize_handle_input(event):
	if event is InputEventMouseButton:
		if event.pressed:
			resizing = true
			drag_start_pos = event.global_position
			drag_start_size = size
		else:
			resizing = false
	elif event is InputEventMouseMotion and resizing:
		var delta = event.global_position - drag_start_pos
		var new_size = drag_start_size + delta
		size = new_size.clamp(min_size, max_size)  # Ensure min/max limits

func _on_close_input():
	var tween= get_tree().create_tween()
	tween.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_EXPO)
	pivot_offset=size/2
	tween.tween_property(self,"scale",Vector2.ZERO,0.5)
	await tween.finished
	windows.erase(self)
	queue_free()

func _on_maximize_pressed():
	var tween= get_tree().create_tween()
	tween.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_EXPO)
	if is_maximized:
		tween.parallel().tween_property(self,"size",prev_size,0.2)
		tween.parallel().tween_property(self,"position",prev_position,0.2)
	else:
		prev_size = size
		prev_position = position
		tween.parallel().tween_property(self,"size",Vector2(get_node(viewport).size),0.2)
		tween.parallel().tween_property(self,"position",Vector2(0,0),0.2)
	is_maximized = !is_maximized  # Toggle maximize state
