class_name InteractZone extends Area3D
@export_file("*.tscn") var message:String
var info
var displaying: bool= false

func _ready() -> void:
	connect("body_entered", _on_body_entered)
	connect("body_exited", _on_body_exited)
	var hitbox= CollisionShape3D.new()
	hitbox.shape=BoxShape3D.new()
	add_child(hitbox)

func interact():
	info= load(message).instantiate()
	print(info)
	add_child(info)
	displaying=true

func remove():
	if (displaying):
		info.queue_free()

func _on_body_entered(body) -> void:
	if (body is CharacterBody3D):
		interact()
		print("interacted")


func _on_body_exited(body) -> void:
	if (body is CharacterBody3D):
		remove()
