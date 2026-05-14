extends Node2D

# Tank state — mirrors original 'ex' class fields
@export var tank_name: String = "Gracz"
@export var max_hp: int = 100
@export var is_ai: bool = false
@export var ai_level: int = 1  # 0-4, higher = more accurate

var hp: int = 100          # current HP (s)
var angle: float = PI / 4  # barrel angle in radians 0..PI (o)
var power: int = 500        # shot power 10..999 (q)
var col: int = 0            # X position in terrain grid (m)
var row: int = 0            # Y position in terrain grid (n)
var fuel: int = 100         # movement fuel (j[20])
var shield: int = 0         # shield HP (x)
var alive: bool = true
var weapon_index: int = 0   # current weapon (I)
var weapons: Array = []     # weapon list (i[])
var ammo: Array = []        # ammo counts (j[])

# Visual
@onready var body_sprite: Sprite2D = $Body
@onready var barrel_sprite: Sprite2D = $Barrel
@onready var hp_bar: ProgressBar = $HPBar

func _ready() -> void:
	weapons = [0]  # default: basic shell
	ammo = [-1]    # -1 = infinite
	update_visuals()

func update_visuals() -> void:
	position = Vector2(col, row)
	if barrel_sprite:
		barrel_sprite.rotation = angle - PI / 2
	if hp_bar:
		hp_bar.value = float(hp) / max_hp * 100.0

func take_damage(dmg: int) -> void:
	if shield > 0:
		var blocked :float= min(shield, dmg)
		shield -= blocked
		dmg -= blocked
	hp -= dmg
	if hp <= 0:
		hp = 0
		alive = false
	update_visuals()

func get_barrel_tip() -> Vector2:
	var length := 20.0
	return Vector2(
		col + cos(angle) * length,
		row - sin(angle) * length
	)

# AI: pick angle and power
func ai_calculate_shot(targets: Array) -> void:
	if targets.is_empty():
		return
	var target: Node2D = targets[0]
	var dx := float(target.col - col)
	var dy := float(row - target.row)
	# Simple ballistic approximation
	var dist := sqrt(dx * dx + dy * dy)
	angle = atan2(dy, dx)
	if angle < 0: angle += PI
	angle = clamp(angle, 0.0, PI)
	power = clamp(int(dist * 1.2), 10, 999)
	# Add inaccuracy based on AI level (mirrors original k field logic)
	var inaccuracy := (4 - ai_level) * 0.15
	angle += randf_range(-inaccuracy, inaccuracy)
	power += randi_range(-50 * (4 - ai_level), 50 * (4 - ai_level))
	power = clamp(power, 10, 999)
	update_visuals()
