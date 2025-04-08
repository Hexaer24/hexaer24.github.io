class_name InteractZone extends Area3D
@export_node_path("Marker3D") var marker_path
var marker

var info
var not_camera:Node3D
var thread:Thread

func _ready() -> void:
	marker=get_node(marker_path)
	not_camera=get_node("../player/Marker3D")
	thread = Thread.new()
	connect("body_entered", _on_body_entered)
	connect("body_exited", _on_body_exited)
	var hitbox= CollisionShape3D.new()
	hitbox.shape=BoxShape3D.new()
	add_child(hitbox)
	


func _on_body_entered(body) -> void:
	if (body is CharacterBody3D):
		print("Entered")
		not_camera.move_camera_to(Vector3(0,1,0),marker)


func _on_body_exited(body) -> void:
	if (body is CharacterBody3D):
		print("Exited")
		not_camera.move_camera_to(Vector3(0,1,0))
