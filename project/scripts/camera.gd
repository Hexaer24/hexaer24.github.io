extends Marker3D
var camera:Camera3D
var time=0
var current_objective:Marker3D
var running= false

func _ready() -> void:
	camera=get_node("Camera3D")

func move_camera_to(curve_point:Vector3,there=self):
	current_objective=there
	if (!running):
		running = true
		while (time<1):
			camera.global_position=adaptive_bezier(time,current_objective.global_position,curve_point)
			#camera.global_rotation=adaptive_bezier(time,there.global_rotation_degrees,curve_point)
			time+=get_process_delta_time()
			await get_tree().process_frame
		time=0
		running =false
	else:
		time=1-time
		
func adaptive_bezier(t,there:Vector3,curve_point:Vector3):
	var q0=camera.global_position.lerp(curve_point,t)
	var q1=curve_point.lerp(there,t)
	var r=q0.lerp(q1,t)
	return r

#Gonna have to manage the thingy here, already kinda made it Awaria3D
# Plan:
# - Make add target, with current objective variable. It'll be more like a request like add_pull_source.
# - While still an objective, run the loop. This is to not rely on physics_process
