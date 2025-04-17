extends Resource

class_name EnemyState

func enter(enemy):
	pass

func update(enemy, delta):
	pass

func exit(enemy):
	pass

func is_interruptible() -> bool:
	return true

func is_finished() -> bool:
	return true  # default: idle states are always finished
