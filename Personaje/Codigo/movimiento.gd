extends KinematicBody2D
#PARA DESPUES DE TERMINAR EL JUGADOR: MODIFICAR PARA QUE CAMBIE DE MODO SEGUN EL NIVEL LO EXIJA¡¡
#------------Variables iniciales-----------------#
onready var largoPantalla = get_viewport().size #Almacena el largo la pantalla
#------------Variables iniciales-----------------#
#------------Variables para Personaje-----------------#
var movimiento = Vector2()
export (int) var velocidad = 200
#------------Variables para Personaje-----------------#
#------------Variables para disparar-----------------#
export (PackedScene) var proyectil #Almacena en una variable a la escena que contiene al proyectil
#------------BULLET HELL-----------------#
const proyectilPoder = preload("res://Personaje/Poderes/ProyectilPoder1.tscn")
onready var tiempoDisparo = $tiempoPoderBulletHell
onready var rotador = $rotador
export (int) var velocidadRotacion = 100
export (int) var puntoSalidaBala = 4
export (int) var radio = 100
var tiempoEsperaBala = 0.2
#------------BULLET HELL-----------------#
#------------Variables para BulletHell-----------------#
func _ready():
	pass
func nave2DPlano():
	#Funcion que determina el movimiento
	if Input.is_action_pressed("arriba"):
		movimiento.y -= 1
	if Input.is_action_pressed("abajo"):
		movimiento.y += 1
	if Input.is_action_pressed("izquierda"):
		movimiento.x -= 1
	if Input.is_action_pressed("derecha"):
		movimiento.x += 1
	movimiento = movimiento.normalized() * velocidad 

func disparar():
	#Funcion para disparar una bala
	if Input.is_action_just_pressed("disparo"):
		var Proyectil1 = proyectil.instance()
		var Proyectil2 = proyectil.instance()
		Proyectil1.global_position = $canonUp.global_position #Hace que la posicion de salida de la bala que igual a donde esta el cañon
		Proyectil2.global_position = $canonDown.global_position
		get_tree().call_group("pruebas", "add_child", Proyectil1) #Asigna en que escena se va a instanciar la bala
		get_tree().call_group("pruebas", "add_child", Proyectil2)

func dispararBulletHell(step):
#	Funcion que hace que realiza el poder
	if Input.is_action_pressed("dispararPoder"):
		for i in range(puntoSalidaBala):
#			dispara por cada puntoSalidaBala
			var PuntoSpawn = Node2D.new()
			var posicion = Vector2(radio, 0).rotated(step * i)
			PuntoSpawn.position = posicion
			PuntoSpawn.rotation = posicion.angle()
			rotador.add_child(PuntoSpawn)
		
		tiempoDisparo.wait_time = tiempoEsperaBala
		tiempoDisparo.start()
	
func _physics_process(_delta):
	movimiento = Vector2(0,0)
	nave2DPlano()
	disparar()
	dispararBulletHell( 2 * PI / puntoSalidaBala)
	movimiento = move_and_slide(movimiento)
	#Para limitar el area del jugador en la pantalla
	position.x = clamp(position.x, 0, largoPantalla.x)
	position.y = clamp(position.y, 0, largoPantalla.y)


func _on_tiempoPoderBulletHell_timeout() -> void:
	for s in rotador.get_children():
		var bala = proyectilPoder.instance()
		get_tree().root.add_child(bala)
		bala.position = s.global_position
		bala.rotation = s.global_rotation
	tiempoDisparo.stop()
