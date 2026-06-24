extends Marker3D
var camera:Camera3D
var player:CharacterBody3D
var time=0
var current_objective:Marker3D
var current_look_objective:Node3D
var current_rot
var running= false

func _ready() -> void:
	player=get_node("..")
	camera=get_node("Camera3D")
	current_rot = camera.global_transform.basis

# Nodes are pointers, will update live in function
# Works for now but speen should be fixed one day
func move_camera_to(curve_point:Vector3,there=self,look_there=player):
	update_objectives(there,look_there)
	if (!running):
		running = true
		while (time<1):
			camera.global_position = adaptive_bezier(ease_in_out(time), current_objective.global_position, curve_point)
			adapative_rotation(ease_in_out(time))
			time+=get_process_delta_time()
			await get_tree().process_frame
		time=0
		running =false
	else:
		time=1-pow(1,2*time)


## args cam_pos, look_rotation
func update_objectives(objective=current_objective,look_objective=current_look_objective):
	current_objective=objective
	current_look_objective=look_objective

func adapative_rotation(t):
	var T=camera.global_transform.looking_at(current_look_objective.global_transform.origin, Vector3(0,1,0))
	camera.global_transform.basis.y=lerp(camera.global_transform.basis.y, T.basis.y, t)
	camera.global_transform.basis.x=lerp(camera.global_transform.basis.x, T.basis.x, t)
	camera.global_transform.basis.z=lerp(camera.global_transform.basis.z, T.basis.z, t)

func adaptive_bezier(t,there:Vector3,curve_point:Vector3):
	var q0=camera.global_position.lerp(curve_point,t)
	var q1=curve_point.lerp(there,t)
	var r=q0.lerp(q1,t)
	return r

func ease_in_out(t: float) -> float:
	return pow(t,4)* (3.0 - 2.0 * t)
