extends Area2D

@export var bullet_speed : float = 300

	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	position += Vector2(bullet_speed, 0) * delta


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
