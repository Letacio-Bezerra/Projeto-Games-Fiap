extends Area2D

# Novo sinal criado, pois por padrão não existe o sinal "coletado"
signal collected

# Cria as variáveis que referenciam o nó de Partículas, Sprite2D e CollisionShape
@onready var particles: GPUParticles2D = $Particles
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

# Toda vez que um corpo entra na Area2D, a função _on_body_entered recebe
# automaticamente as informações do nó que entrou nessa área, registradas
# pelo parâmetro body
func _on_body_entered(body: Node2D) -> void:
# Se o nome do nó que entrou na área for Player, execute as ações
	if body.name == "Player":
		# Emita o sinal collected (criado no início do código)
		collected.emit()
		# Deixa a moeda invisível
		animated_sprite_2d.visible = false
		# Desabilita o colisor (set_deferred é um modo mais seguro do que acessar
		# diretamente a propriedade disabled)
		collision_shape_2d.set_deferred("disabled", true)
		# Ativa as partículas
		particles.emitting = true
		# Espera as partículas acabarem antes de seguir
		# O await pausa a execução da função até que o sinal finished seja emitido
		# — sem travar o jogo, pausando somente a função de forma assíncrona.
		await particles.finished
		# Remova a moeda da cena
		queue_free()
