extends Node2D

var drag_start = Vector2.ZERO
var drag_end = Vector2.ZERO 
var dragging = false

func _draw() -> void:
	if dragging:
		draw_rect(Rect2(drag_start, drag_end - drag_start), Color(1, 1, 1), false)

func update_status(start: Vector2, end: Vector2, drag: bool) -> void:
	drag_start = start
	drag_end = end
	dragging = drag
	queue_redraw()
	
