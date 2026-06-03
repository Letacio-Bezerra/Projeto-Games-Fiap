# script da room2.tscn
extends Node2D

@onready var spawn: Marker2D = $SpawnPoint
@onready var player: CharacterBody2D = $Player

func _ready() -> void:
	player.global_position = spawn.global_position
