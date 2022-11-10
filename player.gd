class_name Player
extends KinematicBody2D

onready var animationHandler = $Animator

var velocity = Vector2()

#State_Machine
var current_state: = 0
var enter_state: = true
enum {
	IDLE, WALK, ATTACK_HANDLE, BASE_ATTACK, MEDIUM_ATTACK, HEAVY_ATTACK, JUMP, FALL 
}

func _set_state(_new_state):
	if _new_state != current_state:
		enter_state = true
	current_state = _new_state
	
#Checking States
func _check_idle():
	var new_state = current_state
	if Input.is_action_pressed("move_left") or Input.is_action_just_pressed("move_right"):
		new_state = WALK
	if Input.is_action_pressed("base_attack") or Input.is_action_just_pressed("medium_attack") or Input.is_action_just_pressed("heavy_attack"):
		new_state = ATTACK_HANDLE	
	if Input.is_action_just_pressed("jump"):
		new_state = JUMP
	if not is_on_floor():
		new_state = FALL
	return new_state

func _check_walk():
	var new_state = current_state
	if (not Input.is_action_pressed("move_left")) and (not Input.is_action_pressed("move_right")):
		new_state = IDLE
	if Input.is_action_pressed("base_attack") or Input.is_action_just_pressed("medium_attack") or Input.is_action_just_pressed("heavy_attack"):
		new_state = ATTACK_HANDLE	
	if Input.is_action_just_pressed("jump"):
		new_state = JUMP
	if not is_on_floor():
		new_state = FALL
	return new_state

func _check_jump():
	var new_state = current_state
	if velocity.y >= 0:
		new_state = FALL
	if Input.is_action_pressed("base_attack") or Input.is_action_just_pressed("medium_attack") or Input.is_action_just_pressed("heavy_attack"):
		new_state = ATTACK_HANDLE
		
	return new_state	

func _check_fall():
	var new_state = current_state
	if is_on_floor():
		new_state = IDLE
	if Input.is_action_pressed("base_attack") or Input.is_action_just_pressed("medium_attack") or Input.is_action_just_pressed("heavy_attack"):
		new_state = ATTACK_HANDLE
	return new_state
	

#Handlers

func _move_and_slide():
	velocity = move_and_slide(velocity, Vector2.UP)
	pass

func _gravity_handler(_delta):
	velocity.y += 800 * _delta

func _movement_handler():
	
	if Input.is_action_pressed("move_left"):
		velocity.x = -120
		animationHandler.flip_h = true
	if Input.is_action_pressed("move_right"):
		velocity.x = 120 
		animationHandler.flip_h = false
	_move_and_slide()
	pass 

#process

func _physics_process(_delta):
	match current_state:
		WALK:
			_walk_State(_delta)
		IDLE:
			_idle_State(_delta)
		JUMP:
			_jump_State(_delta)
		ATTACK_HANDLE:
			_attack_handler_state(_delta)
		FALL:
			_fall_state(_delta)

#States 

func _attack_handler_state(_delta):
	if Input.is_action_pressed("base_attack"):
		_baseAttack_State(_delta)
	if Input.is_action_just_pressed("medium_attack"): 
		_mediumAttack_State(_delta)
	if Input.is_action_just_pressed("heavy_attack"):
		_heavyAttack_State(_delta)
	pass

func _baseAttack_State(_delta):
	animationHandler.play("baseAttack")
	velocity.x = 0
	_gravity_handler(_delta)
	_move_and_slide()
	pass

func _mediumAttack_State(_delta):
	animationHandler.play("mediumAttack")
	velocity.x = 0
	_gravity_handler(_delta)
	_move_and_slide()
	pass
	
func _heavyAttack_State(_delta):
	animationHandler.play("heavyAttack")
	velocity.x = 0
	_gravity_handler(_delta)
	_move_and_slide()
	pass
	
func _walk_State(_delta):
	animationHandler.play("walk")
	_gravity_handler(_delta)
	_movement_handler()
	_move_and_slide()
	_set_state(_check_walk())
	pass
	
func _jump_State(_delta):
	if enter_state == true:
		animationHandler.play("jump")
		velocity.y = -200
		enter_state = false 
	_gravity_handler(_delta)
	_movement_handler()
	_move_and_slide()
	_set_state(_check_jump())
	pass

func _idle_State(_delta):
	animationHandler.play("idle")
	_gravity_handler(_delta)
	velocity.x = 0
	_move_and_slide()
	_set_state(_check_idle())
	pass

func _fall_state(_delta):
	animationHandler.play("fall")	
	_gravity_handler(_delta)
	_movement_handler()
	_move_and_slide()
	_set_state(_check_fall())
	pass

#State_Machine

