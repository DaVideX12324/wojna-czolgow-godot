extends CanvasLayer

# HUD — mirrors original UI from ez.java b(cc, float) method

@onready var tank_name_label: Label = $TankName
@onready var hp_bar: ProgressBar = $HPBar
@onready var power_bar: ProgressBar = $PowerBar
@onready var angle_label: Label = $AngleLabel
@onready var power_label: Label = $PowerLabel
@onready var weapon_icon: TextureRect = $WeaponIcon
@onready var ammo_label: Label = $AmmoLabel
@onready var mode_label: Label = $ModeLabel

var current_tank: Node = null

enum ControlMode { AIMING = 1, DRIVING = 2, CAMERA = 3 }
var control_mode: ControlMode = ControlMode.AIMING

func update_tank(tank: Node) -> void:
	current_tank = tank
	if not tank:
		return
	tank_name_label.text = tank.tank_name
	hp_bar.value = float(tank.hp) / tank.max_hp * 100.0
	_update_aiming()

func _update_aiming() -> void:
	if not current_tank:
		return
	# Angle: convert radians to degrees 0-90 (mirrored like original)
	var deg := int(rad_to_deg(current_tank.angle))
	if deg > 90:
		deg = 180 - deg
	angle_label.text = str(deg) + "°"
	power_label.text = str(current_tank.power)
	power_bar.value = float(current_tank.power - 10) / 989.0 * 100.0

func set_mode(mode: ControlMode) -> void:
	control_mode = mode
	match mode:
		ControlMode.AIMING:
			mode_label.text = "Celowanie"
		ControlMode.DRIVING:
			mode_label.text = "Jeżdżenie"
		ControlMode.CAMERA:
			mode_label.text = "Kamera"
