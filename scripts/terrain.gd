extends Node2D

# Terrain grid: 800 columns x 600 rows
# Values: 0=air, 1=ground, 2=tank_left, 3=tank_right, 4=hard_ground
const COLS := 800
const ROWS := 600

# Packed byte array per column (only allocated columns)
var grid: Array = [] # grid[col] = PackedByteArray or null
# Precomputed top surface per column (highest ground row)
var surface: Array = [] # surface[col] = int row index

@export var ground_color: Color = Color("5a3a1a")
@export var hard_color: Color = Color("3a2a0a")

func _ready() -> void:
	grid.resize(COLS)
	surface.resize(COLS)
	for i in COLS:
		grid[i] = null
		surface[i] = ROWS

# Generate terrain using sine waves (similar to original)
func generate(seed_val: int = 0) -> void:
	var rng := RandomNumberGenerator.new()
	rng.seed = seed_val
	for col in COLS:
		var height := int(ROWS * 0.4)
		height += int(sin(col * 0.02) * 60)
		height += int(sin(col * 0.05 + 1.0) * 30)
		height += rng.randi_range(-10, 10)
		height = clamp(height, 50, ROWS - 50)
		_alloc_col(col)
		for row in range(height, ROWS):
			grid[col][row] = 1
		surface[col] = height
	queue_redraw()

# Get cell value safely
func get_cell(col: int, row: int) -> int:
	if col < 0 or col >= COLS or row < 0 or row >= ROWS:
		return 0
	if grid[col] == null:
		return 0 if surface[col] > row else 1
	return grid[col][row]

# Set cell value
func set_cell(col: int, row: int, val: int) -> void:
	if col < 0 or col >= COLS or row < 0 or row >= ROWS:
		return
	# Don't overwrite tanks or hard ground
	if get_cell(col, row) in [2, 3, 4]:
		return
	_alloc_col(col)
	grid[col][row] = val

# Draw explosion circle (Bresenham)
func explode(cx: int, cy: int, radius: int) -> void:
	var x := radius
	var y := 0
	var err := 0
	while x >= y:
		_fill_explosion_line(cx - x, cx + x, cy + y)
		_fill_explosion_line(cx - x, cx + x, cy - y)
		_fill_explosion_line(cx - y, cx + y, cy + x)
		_fill_explosion_line(cx - y, cx + y, cy - x)
		y += 1
		if err <= 0:
			err += 2 * y + 1
		else:
			x -= 1
			err += 2 * (y - x) + 1
	queue_redraw()

func _fill_explosion_line(x1: int, x2: int, y: int) -> void:
	for x in range(x1, x2 + 1):
		set_cell(x, y, 0)

# Gravity: make ground fall down (called after explosion)
# Mirrors original Java method a(float n) logic
func apply_gravity(max_speed: int = 1) -> bool:
	var moved := false
	for col in COLS:
		if grid[col] == null:
			continue
		var changed := _drop_column(col, max_speed)
		if changed:
			moved = true
			_update_surface(col)
	if moved:
		queue_redraw()
	return moved

func _drop_column(col: int, max_speed: int) -> bool:
	var col_data: PackedByteArray = grid[col]
	var gap := 0
	var moved := false
	for row in range(ROWS - 1, -1, -1):
		if col_data[row] == 0:
			gap = min(gap + 1, max_speed)
		elif col_data[row] == 1 and gap > 0:
			col_data[row + gap] = 1
			col_data[row] = 0
			moved = true
	return moved

func _alloc_col(col: int) -> void:
	if grid[col] == null:
		grid[col] = PackedByteArray()
		grid[col].resize(ROWS)
		grid[col].fill(0)

func _update_surface(col: int) -> void:
	if grid[col] == null:
		surface[col] = ROWS
		return
	for row in ROWS:
		if grid[col][row] != 0:
			surface[col] = row
			return
	surface[col] = ROWS

# Rendering
func _draw() -> void:
	for col in COLS:
		if grid[col] == null:
			continue
		for row in ROWS:
			var v := grid[col][row]
			if v == 1:
				draw_rect(Rect2(col, row, 1, 1), ground_color)
			elif v == 4:
				draw_rect(Rect2(col, row, 1, 1), hard_color)
