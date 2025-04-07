extends Marker3D
var camera:Camera3D

func _ready() -> void:
	camera=get_node("Camera3D")

func move_camera_to(curve_point:Vector3,there:Vector3=position, rot:Vector3=rotation_degrees ):
	camera.global_position=there
	camera.global_rotation_degrees=rot

func adaptive_bezier(t,there:Vector3,curve_point:Vector3):
	var q0=self.position.lerp(curve_point,t)
	var q1=curve_point.lerp(there,t)
	var r=q0.lerp(q1,t)
	return r
