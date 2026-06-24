extends CharacterBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
# variável de referência à HUD
@onready var hud: CanvasLayer = $"../hud"
@onready var spawn_point: Marker2D = $"../SpawnPoint"

signal died # GameManager resetar fase, HUD mostrar tela de morte
signal health_changed(new_health) # HUD atualizar corações

var SPEED = 100.0
const JUMP_VELOCITY = -400.0

# velocidade durante o power-up
const SPEED_BOOST = 200.0
# segundos de duração
const BOOST_DURATION = 5.0
# variável que controla quando o power-up está ativado ou não
var boosted = false


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	
	# Inverte o sprite
	if direction > 0:
		animated_sprite_2d.flip_h = false
	elif direction < 0:
		animated_sprite_2d.flip_h = true
	# Altera a animação
	if is_on_floor():
		if direction == 0:
			animated_sprite_2d.play("idle")
		else:
			animated_sprite_2d.play("walk")
	else:
		animated_sprite_2d.play("jump")
		
	# Apply movement
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

func die():
	tomar_dano(1)
# função que recebe a quantidade de dano via parâmetro e aplica à vidas
func tomar_dano(dano:int) -> void:
	GameManager.vidas -= dano
	if GameManager.vidas <= 0:
		get_tree().change_scene_to_file("res://Scenes/menu/game_over.tscn")
	else:
		respawn()
	hud.atualizar_vidas()

func respawn() -> void:
	position = spawn_point.position

# função que aplica o aumento de velocidade
func apply_speed_boost() -> void:
	if boosted:
		return
	boosted = true
	SPEED = SPEED_BOOST
	await get_tree().create_timer(BOOST_DURATION).timeout
	SPEED = 100
	boosted = false


func _on_powerup_speed_speed_collected(body: Variant) -> void:
	if body.has_method("apply_speed_boost"):
		body.apply_speed_boost()
	pass # Replace with function body.
