class_name InteractZone extends Area3D
@export_node_path("Marker3D") var marker_path:NodePath
@export_node_path() var look_object_path
var marker
var look_object
var info
var not_camera:Node3D
var label:Label
var mid_point_bezier=Vector3(0,1,0)

func _ready() -> void:
	marker=get_node(marker_path)
	if look_object_path!=null:
		look_object=get_node(look_object_path)
	
	not_camera=get_node("/root/world/player/Marker3D")
	connect("body_entered", _on_body_entered)
	connect("body_exited", _on_body_exited)
	add_hitbox()
	label = add_label("Appuyer sur E pour intéragir")

func _on_body_entered(body) -> void:
	if (body is CharacterBody3D):
		body.is_in_zone=true
		body.in_zone(self)
		label.visible=true

func _on_body_exited(body) -> void:
	if (body is CharacterBody3D):
		body.is_in_zone=false
		label.visible=false
		if body.is_in_cutscene:
			cam_move(body)

func cam_move(player:CharacterBody3D):
	if !player.is_in_cutscene:
		Broadcast.emit_signal("player_cutscene_entered")
		not_camera.move_camera_to(mid_point_bezier,marker,look_object)
		player.visible=false
		label.visible=false
	else:
		Broadcast.emit_signal("player_cutscene_exited")
		not_camera.move_camera_to(mid_point_bezier,not_camera)
		player.visible=true
	player.is_in_cutscene=!player.is_in_cutscene

func add_label(text:String):
	var label_add=Label.new()
	label_add.text=text
	label_add.add_theme_color_override("font_outline_color",Color.BLACK)
	label_add.add_theme_constant_override("outline_size",4)
	label_add.set_anchors_preset(Control.PRESET_CENTER)
	add_child(label_add)
	label_add.visible=false
	return label_add

func add_hitbox():
	var hitbox= CollisionShape3D.new()
	hitbox.shape=BoxShape3D.new()
	hitbox.shape.size=Vector3.ONE
	add_child(hitbox)
