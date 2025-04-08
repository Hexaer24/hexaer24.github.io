extends Marker3D
var camera:Camera3D
var time=0
var current_task=Thread.new()
var terminate=false

func _ready() -> void:
	camera=get_node("Camera3D")

func move_camera_to(curve_point:Vector3,there=self):
	while (!terminate and time<1):
		camera.global_position=adaptive_bezier(time,there.global_position,curve_point)
		#camera.global_rotation=adaptive_bezier(time,there.global_rotation_degrees,curve_point)
		time+=get_process_delta_time()
		await get_tree().process_frame
	time=0

func adaptive_bezier(t,there:Vector3,curve_point:Vector3):
	var q0=camera.global_position.lerp(curve_point,t)
	var q1=curve_point.lerp(there,t)
	var r=q0.lerp(q1,t)
	return r
