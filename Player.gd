extends KinematicBody2D

var score : int = 0

var speed : int = 200
var jumpForce : int = 500
var gravity : int = 800

var vel : Vector2 = Vector2()

onready var sprite : AnimatedSprite = get_node("Sprite")
onready var ui : Node = get_node("/root/MainScene/CanvasLayer/UI")
onready var audioPlayer : Node = get_node("/root/MainScene/Camera2D/AudioPlayer")

func _physics_process(delta):
	
	#base velocity in x direction = 0
	vel.x = 0
	
	#movement input
	if Input.is_action_pressed("move_left") :
		vel.x -= speed
		sprite.play("run")
	elif Input.is_action_pressed("move_right") :
		vel.x += speed
		sprite.play("run")
	else :
		sprite.play("idle")
	
	if not is_on_floor():
		sprite.play("jump")
	
	#applying th evelocity to player
	vel = move_and_slide(vel,Vector2.UP)
	
	#applying gravity 
	vel.y += gravity*delta
	
	#Player jump input
	if Input.is_action_just_pressed("jump") and is_on_floor():
		vel.y -= jumpForce
	
	#sprite direction / turn around
	if vel.x < 0 :
		sprite.flip_h = true
	if vel.x > 0 :
		sprite.flip_h = false

func die() :
	
	get_tree().reload_current_scene()
	
func collect_coin(value):
	
	score += value
	ui.set_score_text(score)
	audioPlayer.play_coin_SFX()
