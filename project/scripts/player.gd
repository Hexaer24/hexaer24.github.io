extends CharacterBody3D
const SPEED = 5.0
var is_idle:bool=true
enum States{NONE,IDLE,MOVING}
@onready var timer_idle=$Timer
var state:States= States.NONE:
	set=set_state

func set_state(new_state):
	if new_state==state:
		return
	var previous_state:=state
	state=new_state
	if state==States.IDLE:
		timer_idle.start(5)
	if state==States.MOVING:
		timer_idle.stop()
		Broadcast.emit_signal("player_moving")

func _physics_process(_delta: float) -> void:
	var input_dir := Input.get_vector("left", "right", "up", "down")
	state=States.IDLE if input_dir.is_zero_approx() else States.MOVING
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction and state in [States.IDLE,States.MOVING]:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	move_and_slide()


func move_cam_to(there:Vector3, rot:Vector3):
	$Camera3D.position=there
	$Camera3D.rotation=rot


func _on_timer_timeout() -> void:
	Broadcast.emit_signal("player_idle")
