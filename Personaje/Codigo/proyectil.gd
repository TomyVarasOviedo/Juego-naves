extends Area2D
#onready var player : KinematicBody2D = get_tree().get_nodes_in_group("personaje")[0]
export (int) var velocidadProyectil = 100

func _ready():
	$AnimatedSprite.play()


func _physics_process(delta):
	position.x += velocidadProyectil * delta



func _on_proyectil_area_entered(_area):
	#Señal que termina cuando choco con un enemigo
	print("Me pego")



func _on_VisibilityNotifier2D_screen_exited():
	#Señal que hace que el proyectil se elimine cuando sale de la pantalla
	queue_free()
	print("Me fui")
