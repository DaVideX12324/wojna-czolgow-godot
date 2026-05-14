extends Node

# Battle manager — turn system and game states
# Mirrors original ez.z state machine (24 states)

enum GameState {
	AIMING       = 1,   # Player aiming (angle + power)
	PROJECTILE   = 2,   # Projectile in flight
	CAM_PAN_1    = 3,   # Camera panning (after shot)
	CAM_PAN_2    = 4,
	FALL_1       = 5,   # Terrain falling (phase 1)
	FALL_2       = 6,   # Terrain falling (phase 2)
	NEXT_TURN    = 7,   # Preparing next turn
	NEXT_TURN_2  = 8,
	CHECK_WIN    = 9,   # Check win condition
	SLIDE_1      = 10,  # Tank sliding on terrain
	SLIDE_2      = 11,
	SLIDE_3      = 12,
	SLIDE_4      = 13,
	SLIDE_5      = 14,
	SLIDE_6      = 15,
	SCORE        = 16,  # Show scores
	ROUND_END_1  = 17,
	ROUND_END_2  = 18,
	ROUND_END_3  = 19,
	FALL_3       = 20,
	FALL_4       = 21,
	FALL_5       = 22,
	FALL_6       = 23,
	LOAD_LEVEL   = 24,
}

var state: GameState = GameState.AIMING
var current_tank_idx: int = 0  # ez.q
var tanks: Array = []
var terrain: Node = null
var turn_count: int = 0
var round_over: bool = false

signal turn_started(tank)
signal turn_ended
signal game_over(winner)

func _ready() -> void:
	terrain = get_node_or_null("/root/Battle/Terrain")
	for child in get_tree().get_nodes_in_group("tanks"):
		tanks.append(child)
	if not tanks.is_empty():
		_start_turn()

func _process(delta: float) -> void:
	match state:
		GameState.FALL_1, GameState.FALL_2, GameState.FALL_3, \
		GameState.FALL_4, GameState.FALL_5, GameState.FALL_6:
			var still_falling :float= terrain.apply_gravity(int(50.0 * delta) + 1)
			if not still_falling:
				_on_terrain_settled()
		GameState.CHECK_WIN:
			_check_win_condition()
		GameState.NEXT_TURN, GameState.NEXT_TURN_2:
			_advance_turn()

func _start_turn() -> void:
	state = GameState.AIMING
	var tank = tanks[current_tank_idx]
	if tank.is_ai:
		# Find living enemy targets
		var targets := tanks.filter(func(t): return t.alive and t != tank)
		tank.ai_calculate_shot(targets)
		# Delay then shoot
		get_tree().create_timer(1.0).timeout.connect(_ai_shoot)
	else:
		emit_signal("turn_started", tank)

func _ai_shoot() -> void:
	_fire_shot()

func fire_player_shot() -> void:
	if state != GameState.AIMING:
		return
	if tanks[current_tank_idx].is_ai:
		return
	_fire_shot()

func _fire_shot() -> void:
	var tank = tanks[current_tank_idx]
	var proj := preload("res://scenes/Projectile.tscn").instantiate()
	get_parent().add_child(proj)
	proj.terrain = terrain
	proj.tanks = tanks.filter(func(t): return t != tank and t.alive)
	proj.launch(tank.get_barrel_tip(), tank.angle, tank.power)
	proj.exploded.connect(_on_projectile_exploded)
	state = GameState.PROJECTILE

func _on_projectile_exploded(col: int, row: int, radius: int) -> void:
	state = GameState.FALL_1

func _on_terrain_settled() -> void:
	state = GameState.CHECK_WIN

func _check_win_condition() -> void:
	var alive_tanks := tanks.filter(func(t): return t.alive)
	if alive_tanks.size() <= 1:
		state = GameState.SCORE
		emit_signal("game_over", alive_tanks[0] if not alive_tanks.is_empty() else null)
		return
	state = GameState.NEXT_TURN

func _advance_turn() -> void:
	current_tank_idx = (current_tank_idx + 1) % tanks.size()
	while not tanks[current_tank_idx].alive:
		current_tank_idx = (current_tank_idx + 1) % tanks.size()
	turn_count += 1
	emit_signal("turn_ended")
	_start_turn()
