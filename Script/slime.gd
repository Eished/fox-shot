extends Area2D


@export var slime_speed : float = -100
@export var animator: AnimatedSprite2D
@export var death_sound: AudioStreamPlayer

var is_dead : bool = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if not is_dead:
		position += Vector2(slime_speed, 0) * delta


func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D and not is_dead:
		body.game_over()


func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("bullet") and not is_dead:
		area.queue_free()
		is_dead = true
		animator.play("death")
		death_sound.play()
		
		get_tree().current_scene.score += 1
		
		await get_tree().create_timer(0.6).timeout
		queue_free()


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
