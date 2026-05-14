extends Node2D

# Projectile physics — ballistic trajectory
# Mirrors original trajectory calculation from ez.java

const GRAVITY := 9.8
const SCALE := 0.05  # pixels per unit

var velocity: Vector2 = Vector2.ZERO
var active: bool = false
var terrain: Node = null
var tanks: Array = []
var explosion_radius: int = 30
var damage: int = 50

signal exploded(col: int, row: int, radius: int)
signal hit_tank(tank: Node, damage: int)

func launch(start: Vector2, angle_rad: float, power: int) -> void:
	position = start
	var speed := power * SCALE
	velocity = Vector2(
		cos(angle_rad) * speed,
		-sin(angle_rad) * speed
	)
	active = true

func _process(delta: float) -> void:
	if not active:
		return
	# Apply gravity
	velocity.y += GRAVITY * delta * 10.0
	position += velocity * delta
	# Terrain collision
	var col := int(position.x)
	var row := int(position.y)
	if terrain and terrain.get_cell(col, row) >= 1:
		_explode(col, row)
		return
	# Out of bounds
	if position.x < 0 or position.x > 800 or position.y > 600:
		active = false
		queue_free()
		return
	# Tank collision
	for tank in tanks:
		if tank.alive:
			var d := position.distance_to(Vector2(tank.col, tank.row))
			if d < 15:
				_explode(col, row)
				return

func _explode(col: int, row: int) -> void:
	active = false
	# Damage terrain
	if terrain:
		terrain.explode(col, row, explosion_radius)
	# Damage tanks in radius
	for tank in tanks:
		if tank.alive:
			var d := Vector2(tank.col, tank.row).distance_to(Vector2(col, row))
			if d <= explosion_radius + 10:
				var dmg := int(damage * (1.0 - d / (explosion_radius + 10)))
				emit_signal("hit_tank", tank, dmg)
				tank.take_damage(dmg)
	emit_signal("exploded", col, row, explosion_radius)
	queue_free()
