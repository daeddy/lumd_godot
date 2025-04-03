extends Node2D

var dragging = false
var selected = []
var drag_start = Vector2.ZERO
var select_rectangle = RectangleShape2D.new()

@onready var  select_draw = $SelectDraw

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			for object in selected:
				object.collider.deselect()
			selected = []
			dragging = true
			drag_start = event.position
		elif dragging:
			var drag_end = event.position
			var space = get_world_2d().direct_space_state
			var query = PhysicsShapeQueryParameters2D.new()
			
			dragging = false
			select_draw.update_status(drag_start, event.position, dragging)
	
			select_rectangle.extents = abs(drag_end - drag_start) / 2
			query.set_shape(select_rectangle)
			query.transform = Transform2D(0, (drag_end + drag_start) / 2)
			selected = space.intersect_shape(query)
			
			for object in selected:
				object.collider.select()
	
	if dragging:
		if event is InputEventMouseMotion:
			select_draw.update_status(drag_start, event.position, dragging)
			
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_RIGHT:
		if event.pressed:
			for object in selected:
				object.collider.move_to(event.position)
				
			
