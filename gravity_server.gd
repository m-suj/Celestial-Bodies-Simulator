extends Node


var celestial_bodies: Array[CelestialBody] = []
var enable_physics: bool = false
const G: float = 500.0


func register_celestial_body(body: CelestialBody) -> void:
	celestial_bodies.append(body)


func calculate_gravity_acceleration(body: CelestialBody) -> Vector3:
	var vec := Vector3.ZERO

	# if !enable_physics:
	# 	return vec
	
	for cb in celestial_bodies:
		if cb == body:
			continue
		var diff: Vector3 = cb.position - body.position
		var dir: Vector3 = diff.normalized()
		var r_2: float = diff.length_squared()
		vec += G * dir * (cb.mass / r_2)
	
	return vec

func _on_init_cooldown_timeout() -> void:
	enable_physics = true