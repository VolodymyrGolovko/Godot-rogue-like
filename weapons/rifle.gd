extends Area2D

@onready var sprite = %Rifle
@onready var shooting_speed = %ShootingSpeed
@onready var reload_timer = %ReloadTimer
@onready var reload_bar = get_node("/root/Game/Player/ReloadBar")

const BULLET = preload("res://weapons/projectile_test.tscn")

var can_shoot = true
var reloading = false

var ammo = 30
var max_ammo = 30

func _physics_process(delta):
	var world_mouse_position = get_global_mouse_position()
	look_at(world_mouse_position)

	if world_mouse_position.x < global_position.x:
		sprite.flip_v = true
	else:
		sprite.flip_v = false

	if Input.is_action_pressed("attack") and can_shoot:
		shoot()
	if Input.is_action_just_pressed("reload") and not reloading:
		reload()
	
	if reloading:
		reload_bar.visible = true
		reload_bar.max_value = reload_timer.wait_time
		reload_bar.value = reload_timer.wait_time - reload_timer.time_left
	else:
		reload_bar.visible = false
		reload_bar.value = reload_bar.max_value

func shoot():
	if ammo > 0:
		can_shoot = false
		shooting_speed.start()
		var new_bullet = BULLET.instantiate()
		new_bullet.global_position = %ShootingPoint.global_position
		new_bullet.global_rotation = %ShootingPoint.global_rotation
		%ShootingPoint.add_child(new_bullet)
		ammo -= 1
		if ammo == 0:
			reload()

func reload():
	reloading = true
	can_shoot = false
	shooting_speed.stop()
	reload_timer.start()

func _on_shooting_speed_timeout() -> void:
	can_shoot = true

func _on_reload_timer_timeout() -> void:
	reload_timer.stop()
	ammo = max_ammo
	reloading = false
	can_shoot = true
