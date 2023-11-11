extends Area2D

const velocidad = 100
func _process(delta):
	position += transform.x * velocidad * delta


func _on_tiempoVida_timeout():
	queue_free()
	print("Me fui -")


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
	print("Me fui *")
