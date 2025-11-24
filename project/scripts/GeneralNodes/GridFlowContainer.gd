class_name GridFlowContainer extends GridContainer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_parent().connect("resized",_on_resized)
	clip_contents=true

func _on_resized():
	var min_column_width=80
	if min_column_width <= 0:
		return
	var new_cols = max(1, floor(get_parent().size.x / min_column_width))
	columns = new_cols
# Called every frame. 'delta' is the elapsed time since the previous frame.
