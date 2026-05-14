# ai.gd
# Auto-generated from ey-2.java (Procyon decompile of Wojny Czołgów)
# Zawiera dokładne tablice trudności AI z oryginału

extends Node

# Tablice trudności z ey-2.java (ey.a / ey.b / ey.c / ey.d)
# Format raw[]: [spawns, ?, multi_shot, ?, ?, ?, accuracy_base, cluster_size, ?, ?,
#                shield_chance, ?, terrain_use, retreat_threshold, extra_bounce,
#                max_power, shot_types, rand_power, rand_angle, rand_offset,
#                rand_spread, rand_wind, iq_display]
const DIFFICULTY = {
	0: {
		"name": "Łatwy",
		"raw": [3, 0, 1, 2, 1, 1, 90, 3, 2, 0, 2, 0, 1, 2, 0, 100, 2, 0, 20, 0, 10, 10, 5],
		"accuracy_base": 90,
		"rand_angle":    20,
		"rand_power":    0,
		"rand_offset":   0,
		"rand_spread":   10,
		"rand_wind":     10,
		"max_power":     100,
		"iq_display":    5,
		"cluster_size":  3,
		"shield_chance": 2,
		"terrain_use":   1,
	},
	1: {
		"name": "Średni",
		"raw": [1, 0, 1, 1, 1, 4, 80, 0, 4, 0, 1, 0, 2, 3, 0, 100, 1, 10, 20, 15, 10, 10, 8],
		"accuracy_base": 80,
		"rand_angle":    20,
		"rand_power":    10,
		"rand_offset":   15,
		"rand_spread":   10,
		"rand_wind":     10,
		"max_power":     100,
		"iq_display":    8,
		"cluster_size":  0,
		"shield_chance": 1,
		"terrain_use":   2,
	},
	2: {
		"name": "Trudny",
		"raw": [2, 1, 2, 1, 1, 1, 100, 3, 2, 0, 3, 1, 3, 5, 0, 100, 1, 5, 10, 8, 5, 5, 8],
		"accuracy_base": 100,
		"rand_angle":    10,
		"rand_power":    5,
		"rand_offset":   8,
		"rand_spread":   5,
		"rand_wind":     5,
		"max_power":     100,
		"iq_display":    8,
		"cluster_size":  3,
		"shield_chance": 3,
		"terrain_use":   3,
	},
	3: {
		"name": "Expert",
		"raw": [2, 2, 2, 1, 1, 1, 90, 4, 5, 0, 3, 1, 4, 7, 150, 100, 3, 1, 4, 3, 1, 3, 11],
		"accuracy_base": 90,
		"rand_angle":    4,
		"rand_power":    1,
		"rand_offset":   3,
		"rand_spread":   1,
		"rand_wind":     3,
		"max_power":     100,
		"iq_display":    11,
		"cluster_size":  4,
		"shield_chance": 3,
		"terrain_use":   4,
	},
}

# Stałe z ey-2.java
const TRAJECTORY_STEPS := 25   # ey.C
const RETREAT_THRESHOLD := 5   # ey.D
const MAX_ITERATIONS    := 100  # ey.E

var difficulty_level: int = 1
var tank_ref: Node = null

func setup(tank: Node, diff: int) -> void:
	tank_ref = tank
	difficulty_level = clamp(diff, 0, 3)

func get_diff() -> Dictionary:
	return DIFFICULTY[difficulty_level]

# Oblicza odchylenie kąta i mocy bazując na poziomie trudności
func apply_inaccuracy(angle_rad: float, power: int) -> Dictionary:
	var d = get_diff()
	var rand_a = deg_to_rad(randf_range(-d["rand_angle"], d["rand_angle"]) * 0.1)
	var rand_p = randi_range(-d["rand_power"], d["rand_power"])
	return {
		"angle": clampf(angle_rad + rand_a, 0.0, PI),
		"power": clamp(power + rand_p, 10, 999)
	}

# Czy AI powinna użyć tarczy w tej turze?
func should_use_shield() -> bool:
	var d = get_diff()
	return randi_range(0, 9) < d["shield_chance"]

# Ile pocisków w salwie?
func get_cluster_count() -> int:
	var d = get_diff()
	if d["cluster_size"] == 0:
		return 1
	return randi_range(1, d["cluster_size"])

# Etykieta IQ dla HUD
func get_iq_label() -> String:
	var d = get_diff()
	return "IQ: " + str(d["iq_display"] * 10)
