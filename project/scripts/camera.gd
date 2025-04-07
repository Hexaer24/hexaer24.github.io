extends Marker3D

func _ready() -> void:
	pass

func move_to(there:Vector3, rot:Vector3, curve_point:Node3D):
	var curve=Curve3D.new()
	curve.add_point(position)
	position=there
	rotation_degrees=rot
