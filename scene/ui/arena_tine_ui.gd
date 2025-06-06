extends CanvasLayer

@export var arena_time_manager: Node
@onready var label: Label = %Label


func _process(delta: float) -> void:
	if arena_time_manager == null:
		return
	
	var time_elapsed = arena_time_manager.get_time_elapsed ()
	label.text = format_timer(time_elapsed)
	

func format_timer(seconds : float):
	var minutes = floor(seconds / 60)
	var remaining_sec = seconds - (minutes * 60)
	return "%02d" % minutes + ":" + "%02d" % floor(remaining_sec)
	
	
