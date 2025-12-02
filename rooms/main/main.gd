extends PanelContainer

@onready var day_1_button: Button = %Day1Button
@onready var day_2_button: Button = %Day2Button

func _ready() -> void:
	day_1_button.pressed.connect(_on_day_1_button_pressed)
	day_2_button.pressed.connect(_on_day_2_button_pressed)

func _on_day_2_button_pressed() -> void:
	get_tree().change_scene_to_file("res://rooms/day_2/day_2.tscn")

func _on_day_1_button_pressed() -> void:
	get_tree().change_scene_to_file("res://rooms/day_1/day_1.tscn")
