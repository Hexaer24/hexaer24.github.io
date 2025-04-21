class_name InteractZone extends Area3D
@export_node_path("Marker3D") var marker_path
@export_node_path() var look_object_path
var marker
var look_object
var info
var not_camera:Node3D
var size=Vector3(0.01,0.01,0.01)

func _ready() -> void:
	marker=get_node(marker_path)
	if look_object_path!=null:
		look_object=get_node(look_object_path)
	
	not_camera=get_node("../player/Marker3D")
	connect("body_entered", _on_body_entered)
	connect("body_exited", _on_body_exited)
	var hitbox= CollisionShape3D.new()
	hitbox.shape=BoxShape3D.new()
	hitbox.shape.size=size
	add_child(hitbox)
	


func _on_body_entered(body) -> void:
	if (body is CharacterBody3D):
		not_camera.move_camera_to(Vector3(0,1,0),marker,false,look_object)


func _on_body_exited(body) -> void:
	if (body is CharacterBody3D):
		not_camera.move_camera_to(Vector3(0,1,0),not_camera,true,)
