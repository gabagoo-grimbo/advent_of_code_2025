extends PanelContainer

@onready var button_container: Container = get_node("MarginContainer/VBoxContainer")
@onready var day_1_button: Button = button_container.get_node("Day1Button")

func _ready() -> void:
	day_1_button.pressed.connect(_on_day_1_button_pressed)

func _on_day_1_button_pressed() -> void:
	get_tree().change_scene_to_file("res://rooms/day_1/day_1.tscn")
