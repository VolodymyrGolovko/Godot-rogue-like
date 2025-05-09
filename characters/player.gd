extends CharacterBody2D

class_name Player

@export var max_health = 200
@export var current_health = 200
@export var move_speed = 450
@export var dash_speed = 1000
@export var dash_duration = 0.4
@export var push_force: float = 2

@onready var cursor_target := $CursorTarget
@onready var camera := $Camera2D
@onready var dash_timer := $DashTimer
@onready var dash_meter_bar := %DashMeter

const MAX_CURSOR_DISTANCE = 600
const CAMERA_SHIFT_RATIO = 0.5

var is_dashing = false
var dash_time_left = 0.0
var dash_direction = Vector2.ZERO
var can_dash = true

func _ready():
	dash_timer.one_shot = true
	dash_timer.timeout.connect(_on_dash_timer_timeout)
	dash_meter_bar.max_value = dash_timer.wait_time
	dash_meter_bar.value = 0

func _physics_process(delta):
	if is_dashing:
		dash_time_left -= delta
		if dash_time_left <= 0:
			is_dashing = false
		else:
			velocity = dash_direction * dash_speed
			move_and_slide()
			return
	
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * move_speed
	move_and_slide()
	
	for i in range(get_slide_collision_count()):
		
		var collision = get_slide_collision(i)
		var obj = collision.get_collider()
		
		if obj is GameObject and obj.is_moveable:
			var push_direction = collision.get_normal() * -1
			var force = push_direction * move_speed  * push_force * delta
			obj.apply_force(force)

	if Input.is_action_just_pressed("dash") and direction != Vector2.ZERO and can_dash:
		dash(direction)

	if not can_dash:
		%DashMeter.visible = true
		dash_meter_bar.value = dash_timer.wait_time - dash_timer.time_left
	else:
		%DashMeter.visible = false
		dash_meter_bar.value = dash_meter_bar.max_value

func dash(direction: Vector2):
	is_dashing = true
	dash_time_left = dash_duration
	dash_direction = direction.normalized()
	can_dash = false
	dash_meter_bar.value = 0
	dash_timer.start()

func _on_dash_timer_timeout():
	can_dash = true

func take_damage(amount: int):
	current_health -= amount
	if current_health <= 0:
		die()



func _process(delta):
	var world_mouse_position = get_global_mouse_position()
	var desired_position = global_position * 0.33 + world_mouse_position * 0.66
	
	if global_position.distance_to(desired_position) > MAX_CURSOR_DISTANCE:
		desired_position = global_position + (desired_position - global_position).normalized() * MAX_CURSOR_DISTANCE
	
	cursor_target.global_position = desired_position
	var camera_offset = (cursor_target.global_position - global_position) * CAMERA_SHIFT_RATIO
	camera.position = camera_offset

func projectile_collision_reaction(obj: BaseProjectile): # тут впихнути перевірку на вразливість, перекат
	take_damage(obj.character_damage)
	obj.character_collision_reaction()
	pass

func die():
	queue_free()
