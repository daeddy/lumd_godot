extends CharacterBody2D

var selected = false
var target = Vector2.ZERO
var speed = 80
var target_max_dist = 1

const MOVE_THRESHHOLD = 0.8
var last_postition = Vector2.ZERO

@onready var stop_timer = $StopTimer

func _ready() -> void:
	target = position
	
func _physics_process(_delta: float) -> void:
	velocity = Vector2.ZERO
	if position.distance_to(target) > target_max_dist:
		velocity = position.direction_to(target) * speed
		if get_slide_collision_count() and stop_timer.is_stopped():
			stop_timer.start()
			last_postition = position
	move_and_slide()

	
func move_to(tar: Vector2) -> void:
	target = tar

func select():
	selected = true
	$Selected.visible = true

func deselect():
	selected = false
	$Selected.visible = false


func _on_stop_timer_timeout() -> void:
	if get_slide_collision_count():
		if last_postition.distance_to(target) < position.distance_to(target) + MOVE_THRESHHOLD:
			target = position
