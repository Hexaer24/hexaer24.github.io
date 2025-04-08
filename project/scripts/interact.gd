class_name InteractZone extends Area3D
@export_file("*.tscn") var message:String
@export_node_path()

var info
var not_camera
var thread:Thread

func _ready() -> void:
	not_camera=get_node("../player/Marker3D")
	thread = Thread.new()
	
	connect("body_entered", _on_body_entered)
	connect("body_exited", _on_body_exited)
	var hitbox= CollisionShape3D.new()
	hitbox.shape=BoxShape3D.new()
	add_child(hitbox)

func interact():
	not_camera.move_camera_to(Vector3(0,1,0),Vector3(-1.1,1.3,-1.1), Vector3(0,45,0))


func _on_body_entered(body) -> void:
	if (body is CharacterBody3D):
		interact()


func _on_body_exited(body) -> void:
	if (body is CharacterBody3D):
		not_camera.move_camera_to(Vector3(0,1,0))
