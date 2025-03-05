extends Marker3D

func _ready() -> void:
	pass

func move_to(there:Vector3, rot:Vector3):
	position=there
	rotation_degrees=rot
	
