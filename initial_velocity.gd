@tool
class_name InitialVelocity extends Node3D


@onready var mesh_instance: MeshInstance3D = $MeshInstance3D
const RELATIVE_SCALE: float = 0.05


func update_radius(value: float) -> void:
	mesh_instance.mesh.radius = RELATIVE_SCALE * value
	mesh_instance.mesh.height = RELATIVE_SCALE * 2 * value