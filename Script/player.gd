extends CharacterBody2D


@export var move_speed: float = 200
@export var animator: AnimatedSprite2D
@export var bullet_scene: PackedScene
@export var fire_sound: AudioStreamPlayer
@export var game_over_sound: AudioStreamPlayer
@export var run_sound: AudioStreamPlayer
@export var game_over_timer: Timer

var is_game_over: bool = false

func _process(delta: float) -> void:
	if is_game_over or velocity == Vector2.ZERO:
		run_sound.stop()
	elif not run_sound.playing:
		run_sound.play()	

func _physics_process(delta: float) -> void:
	if not is_game_over:
		velocity = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down") * move_speed
		
		if velocity == Vector2.ZERO:
			animator.play("idle")
		else:
			animator.play("run")
		
		move_and_slide()
		

func game_over():
	if not is_game_over:
		is_game_over = true
		animator.play("game_over")
		
		get_tree().current_scene.show_game_over()
		game_over_sound.play()
		
		game_over_timer.start()


func _on_fire() -> void:
	if velocity != Vector2.ZERO or is_game_over:
		return
	var bullet_node = bullet_scene.instantiate()
	bullet_node.position = position + Vector2(15, 6)
	fire_sound.play()
	get_tree().current_scene.add_child(bullet_node)


func _on_game_over_timer_timeout() -> void:
	get_tree().reload_current_scene()
