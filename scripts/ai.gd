extends Node

# AI controller — mirrors original tank k field behavior
# k=0: human, k=1-4: AI difficulty levels

# AI difficulty hit probability table (from original em.a(100) < eu.o(weapon) logic)
const HIT_CHANCE := {
	1: 30,  # Easy
	2: 50,  # Medium
	3: 70,  # Hard
	4: 90,  # Expert
}

static func calculate_shot(tank: Node, targets: Array, level: int) -> Dictionary:
	if targets.is_empty():
		return {"angle": PI / 4, "power": 500}
	
	# Pick closest living target
	var target = targets.reduce(func(a, b):
		var da := Vector2(tank.col, tank.row).distance_to(Vector2(a.col, a.row))
		var db := Vector2(tank.col, tank.row).distance_to(Vector2(b.col, b.row))
		return a if da < db else b
	)
	
	var dx := float(target.col - tank.col)
	var dy := float(tank.row - target.row)
	var dist := Vector2(dx, dy).length()
	
	# Ideal angle (simplified ballistic)
	var ideal_angle := atan2(dy + dist * 0.3, dx)
	ideal_angle = clamp(ideal_angle, 0.0, PI)
	
	# Add inaccuracy based on difficulty
	var miss := (4 - level) * 0.2
	var final_angle := ideal_angle + randf_range(-miss, miss)
	
	# Power based on distance
	var ideal_power := clamp(int(dist * 1.5), 10, 999)
	var power_miss := (4 - level) * 80
	var final_power := clamp(ideal_power + randi_range(-power_miss, power_miss), 10, 999)
	
	return {"angle": final_angle, "power": final_power}
