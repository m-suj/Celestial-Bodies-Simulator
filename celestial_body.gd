class_name CelestialBody extends Area3D


@export var radius: float = 1.0
@export var mass: float = 1.0
@export var initial_velocity: Vector3 = Vector3.ZERO

var acceleration: Vector3 = Vector3.ZERO
@onready var velocity: Vector3
@onready var mesh_instance: MeshInstance3D = $MeshInstance3D
@onready var collision: CollisionShape3D = $CollisionShape3D


func _ready():
	mesh_instance.mesh = mesh_instance.mesh.duplicate()
	update_sphere()
	GravityServer.register_celestial_body(self )
	velocity = initial_velocity
	print("celestial body ready")


func update_sphere():
	mesh_instance.mesh.radius = radius
	mesh_instance.mesh.height = radius * 2.0
	collision.shape.radius = radius


func _physics_process(delta):
	if !GravityServer.enable_physics:
		return
	# Update acceleration
	self.acceleration = GravityServer.calculate_gravity_acceleration(self )
	# Update velocity
	self.velocity += self.acceleration * delta
	# Update position
	self.position += velocity * delta
