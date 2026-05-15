extends Camera3D

@export var speed: float = 50.0
@export var fast_multiplier: float = 4.0
@export var fast_multiplier_multiplier: float = 2.0
@export var mouse_sensitivity: float = 0.002

var yaw: float = 0.0
var pitch: float = 0.0
var mouse_captured: bool = false


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _unhandled_input(event):
	# ESC toggle myszy
	if event is InputEventKey and event.pressed and event.keycode == KEY_ESCAPE:
		mouse_captured = !mouse_captured
		Input.set_mouse_mode(
			Input.MOUSE_MODE_CAPTURED if mouse_captured else Input.MOUSE_MODE_VISIBLE
		)

	# obrót kamerą
	elif event is InputEventMouseMotion and mouse_captured:
		yaw -= event.relative.x * mouse_sensitivity
		pitch -= event.relative.y * mouse_sensitivity

		pitch = clamp(pitch, deg_to_rad(-89), deg_to_rad(89))

		rotation = Vector3(pitch, yaw, 0)


func _process(delta):
	var dir := Vector3.ZERO
	var _basis: Basis = global_transform.basis

	# WASD (lokalnie do kamery)
	if Input.is_key_pressed(KEY_W):
		dir -= _basis.z
	if Input.is_key_pressed(KEY_S):
		dir += _basis.z
	if Input.is_key_pressed(KEY_A):
		dir -= _basis.x
	if Input.is_key_pressed(KEY_D):
		dir += _basis.x

	# góra / dół
	if Input.is_key_pressed(KEY_E):
		dir += _basis.y
	if Input.is_key_pressed(KEY_Q):
		dir -= _basis.y

	dir = dir.normalized()

	var current_speed := speed
	if Input.is_key_pressed(KEY_SHIFT):
		current_speed *= fast_multiplier
	if Input.is_key_pressed(KEY_SPACE):
		current_speed *= fast_multiplier_multiplier
	
	global_position += dir * current_speed * delta