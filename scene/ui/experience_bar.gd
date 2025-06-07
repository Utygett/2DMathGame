extends CanvasLayer

@export var exp_manager: ExpirienceManager
@onready var progress_bar: ProgressBar = $MarginContainer/ProgressBar

func _ready() -> void:
	progress_bar.value = 0
	exp_manager.expirince_update.connect(on_exp_updated)
	
func on_exp_updated(curr_exp:float, target_exp:float):
	var curr_value = curr_exp / target_exp
	progress_bar.value = curr_value
