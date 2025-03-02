extends Marker3D


@export var screen_mesh: NodePath = "../room/Cube_002"# Assign the 3D screen MeshInstance3D
@export var viewport: NodePath ="../room/Cube_002/SubViewport" # Assign the Viewport node
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func move_to(there:Vector3, rot:Vector3):
	position=there
	rotation_degrees=rot
	
func _unhandled_input(event):
	if event is InputEventMouseButton and event.pressed:
		var space_state = get_world_3d().direct_space_state
		var mouse_pos = get_viewport().get_mouse_position()
		var from = $Camera3D.project_ray_origin(mouse_pos)
		var to = from + $Camera3D.project_ray_normal(mouse_pos) * 100  # Cast the ray forward

		var query = PhysicsRayQueryParameters3D.create(from, to)
		var result = space_state.intersect_ray(query)

		if result and result.collider == get_node(screen_mesh):
			var vp = get_node(viewport)
			
			# Convert 3D hit to 2D UV coordinates
			var uv = result.uv * vp.size  # Scale UV to viewport resolution

			# Create a new click event at the correct position
			var click_event = event.duplicate()
			click_event.position = uv

			# Send the input event to the Viewport
			vp.push_input(click_event)
