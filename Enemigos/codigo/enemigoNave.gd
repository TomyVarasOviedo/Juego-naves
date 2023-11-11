extends Area2D

func _ready():
	pass

func _physics_process(_delta):
	pass




func _on_Area2D_body_entered(body):
#	Señal que establece cuando entra un proyectil en area de colision del enemigo
	if body.isGroup() == 'proyectil' or body.isGroup() == 'proyectilPoder1':
		queue_free()
