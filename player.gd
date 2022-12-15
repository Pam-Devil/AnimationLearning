class_name Player
extends KinematicBody2D

onready var animationHandler = $Animator

onready var input_queue = Queue.new() 

var velocity = Vector2()

#State_Machine
var current_state: = 0
var enter_state: = true
enum {
	IDLE, WALK, ATTACK_HANDLE, BASE_ATTACK, MEDIUM_ATTACK, HEAVY_ATTACK, JUMP, FALL 
}

func _process_input_events():
	if input_queue.size() > 0:
		
		var input_event = input_queue.pop_front()

		if input_event.scancode == KEY_UP:
			pass
		elif input_event.scancode == KEY_DOWN:
			pass
		else:
			pass
		
	if input_queue.size() > 0:
		_process_input_events()

func _input(event):
	
	# print("Current Line:", srt(inspect.current_frame().f_lineno))

	if event is InputEventKey:
		input_queue.push_back(event)

		_process_input_events()
	print("Key pressed!")
