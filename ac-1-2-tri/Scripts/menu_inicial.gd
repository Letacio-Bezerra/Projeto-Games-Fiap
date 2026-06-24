extends Control

@onready var jogar_button: Button = $JogarButton

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	jogar_button.pressed.connect(_on_jogar_button_pressed)

func _on_jogar_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/levels/level_hub.tscn")
