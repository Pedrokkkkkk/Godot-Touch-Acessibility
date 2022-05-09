tool
extends EditorPlugin


var mouse_button = InputEventMouseButton.new()
var mouse_motion = InputEventMouseMotion.new()
var mouse_mode
var mouse_action = 0

var touches = []
var draggings = []


export(bool) var left


func _enter_tree():
	mouse_mode = preload("res://addons/android_acessibility/ui/MouseMode.tscn").instance()
	add_control_to_dock(EditorPlugin.DOCK_SLOT_RIGHT_BL, mouse_mode)
	mouse_mode.connect("action_changed", self, "action_changed")


func _exit_tree():
	mouse_mode.disconnect("action_changed", self, "action_changed")
	remove_control_from_docks(mouse_mode)


func forward_canvas_gui_input(event):
	get_touches(event)


func forward_spatial_gui_input(camera, event):
	get_touches(event)


func handles(object):
	return true


func get_touches(event):
	if event is InputEventScreenTouch:
		if event.pressed:
			touches.remove(event.index)
			touches.insert(event.index, {
				index = event.index,
				pos = event.position
			})
			action_down(event.position)
		else:
			touches.remove(event.index)
			draggings.remove(event.index)
			action_up()
	if event is InputEventScreenDrag:
		draggings.remove(event.index)
		draggings.insert(event.index, {
			index = event.index,
			drag = event.relative
		})
		action_drag(event.position, event.relative)
	return true
	#print(touches)
	#print(draggings)


func action_changed(action):
	mouse_action = action
	print(mouse_action)


func action_down(mouse_pos):
	match mouse_action:
		0:
			mouse_button.button_index = BUTTON_LEFT
			mouse_button.button_mask = BUTTON_MASK_LEFT
			
		1:
			pass
		2:
			mouse_button.button_index = BUTTON_RIGHT
			mouse_button.button_mask = BUTTON_MASK_RIGHT
	mouse_button.position = mouse_pos
	mouse_button.pressed = true
	Input.parse_input_event(mouse_button)
	print("pressed, Index: ", mouse_action, " At Pos: ", mouse_pos)


func action_up():
	mouse_button.pressed = false
	Input.parse_input_event(mouse_button)


func action_drag(mouse_position, mouse_relative):
	match mouse_action:
		0:
			mouse_motion.button_mask = BUTTON_MASK_LEFT
			
		1:
			pass
		2:
			mouse_motion.button_mask = BUTTON_MASK_RIGHT
	mouse_motion.position = mouse_position
	mouse_motion.relative = mouse_relative
	Input.parse_input_event(mouse_motion)
	print("pressed, Index: ", mouse_action, " At Pos: ", mouse_relative)





