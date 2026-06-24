extends Node

#Uses: move_prompt
signal player_idle
#Uses: move_prompt
signal player_moving
#Uses: move_prompt
signal player_cutscene_entered
#Uses: move_prompt
signal player_cutscene_exited
@onready var desktop:Desktop=$"../world/Node3D/SubViewport/os"
