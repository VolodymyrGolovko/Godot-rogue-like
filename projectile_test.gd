extends Area2D

class_name projectile_test

var travelled_distance = 0
var obstacle_damage = 1

func _physics_process(delta):
	const SPEED = 2000
	const RENGE = 4000
	
	var direction = Vector2.RIGHT.rotated(rotation)
	position += direction * SPEED * delta
	
	travelled_distance += SPEED * delta
	
	
	if travelled_distance > RENGE:
		queue_free()

func _on_body_entered(body: Node2D):
	print("enter")
	if body is GameObject:
		if not body.passable_for_grounded:
			body.collide_grounded(self)
	pass

func destroy():
	queue_free()
	pass
