extends CanvasLayer

@export var experience_manager: ExperienceManager
@onready var progress_bar = $MarginContainer/ProgressBar as ProgressBar

func _ready():
	progress_bar.value = 0
	

func _on_experience_manager_exp_updated(curr_exp, target_exp):
	progress_bar.value = curr_exp as float / target_exp

