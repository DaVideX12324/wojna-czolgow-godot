# main_menu.gd
# Skrypt menu głównego

extends Control

func _ready() -> void:
	$VBox/BtnBattle.pressed.connect(_on_battle_pressed)
	$VBox/BtnQuit.pressed.connect(_on_quit_pressed)
	$VBox/BtnRanks.pressed.connect(_on_ranks_pressed)

func _on_battle_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/Battle.tscn")

func _on_ranks_pressed() -> void:
	# TODO: scena rang
	pass

func _on_quit_pressed() -> void:
	get_tree().quit()
