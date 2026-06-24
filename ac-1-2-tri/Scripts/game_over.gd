extends Control

@onready var tentar_novamente_button: Button = $TentarNovamenteButton
@onready var hud: CanvasLayer = $"../hud"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	tentar_novamente_button.pressed.connect(_on_tentar_novamente_button_pressed)

func _on_tentar_novamente_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/levels/level_hub.tscn")
	GameManager.vidas = 3
