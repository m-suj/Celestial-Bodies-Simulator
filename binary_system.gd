class_name BinarySystem extends Node3D


## Distance between planets (applied on Z axis).
@export var r: float = 100.0
## Length of the semi-major axis.
@export var a: float = 100.0
## Orbital velocity at this point.
@export var v: Vector3 = Vector3(100.0, 0, 0)

@export_enum("r", "a", "v") var what_to_calculate: String = "v"


@onready var c1: CelestialBody = $CelestialBody
@onready var c2: CelestialBody = $CelestialBody2


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	match what_to_calculate:
		"v":
			v = Vector3.ZERO
			v.x = sqrt(GravityServer.G * c2.mass * (2 / r - 1 / a))
			c1.velocity = v
	print("binary system ready")
