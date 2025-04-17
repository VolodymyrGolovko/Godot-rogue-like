extends Node

class_name EnemyBrain

enum BehaviorMode { PASSIVE, ACTIVE }

@export var behavior_mode := BehaviorMode.PASSIVE

func update(enemy, delta):
	var new_state = decide_state(enemy)
	if new_state != enemy.current_state:
		enemy.change_state(new_state)

func decide_state(enemy):
	match behavior_mode:
		BehaviorMode.ACTIVE:
			return decide_active(enemy)
		BehaviorMode.PASSIVE:
			return decide_passive(enemy)

func decide_passive(enemy) -> EnemyState:
	if not enemy.is_active:
		return IdleState.new()
	return IdleState.new()

func decide_active(enemy) -> EnemyState:
	if enemy.can_see_player():
		if enemy.has_ammo():
			if enemy.player_in_attack_range():
				pass
				#return AttackState.new()
			else:
				pass
				#return MoveCloserState.new()
		else:
			pass
			#return ReloadState.new()
	else:
		pass
		#return SearchState.new()
	return IdleState.new()
