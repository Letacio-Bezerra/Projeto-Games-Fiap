extends Area2D

@export var target_scene: String = "res://Scenes/level_0.tscn"
@export var prompt_label: Label  # opcional, texto "Aperte E"

var player_inside := false

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("player"):
		player_inside = true
		if prompt_label:
			prompt_label.visible = true

func _on_body_exited(body: Node) -> void:
	if body.is_in_group("player"):
		player_inside = false
		if prompt_label:
			prompt_label.visible = false

func _process(_delta: float) -> void:
	if player_inside and Input.is_action_just_pressed("interact"):
		_open_door()

func _open_door() -> void:
	# Se tiver animação de abrir, toca antes de trocar de cena
	# $AnimatedSprite2D.play("open")
	# await $AnimatedSprite2D.animation_finished
	get_tree().change_scene_to_file(target_scene)
