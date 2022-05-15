tool
extends EditorPlugin


var acessibility
var keyboard
var mouse_button
var mouse_motion
var mouse_action = 0
var mouse_press_count = 0
var mouse_delay = 0.25
var node_edited


func _enter_tree():
	print("Godot Touch Acessibility Plugin Enabled!")
	acessibility = preload("res://addons/godot_touch_acessibility/ui/Acessibility.tscn").instance()
	add_control_to_dock(EditorPlugin.DOCK_SLOT_RIGHT_BL, acessibility)
	acessibility.connect("action_changed", self, "action_changed")
	keyboard = preload("res://addons/godot_touch_acessibility/ui/Keyboard.tscn").instance()
	add_control_to_bottom_panel(keyboard, "Keyboard")


func _exit_tree():
	print("Godot Touch Acessibility Plugin Disabled!")
	if acessibility is Control:
		acessibility.disconnect("action_changed", self, "action_changed")
		remove_control_from_docks(acessibility)
	if keyboard is Control:
		remove_control_from_bottom_panel(keyboard)


func _input(event):
	convert_touch_event(event)


func _process(_delta):
	pass


func edit(object):
	node_edited = object


func handles(object):
	return true


func action_changed(index):
	mouse_action = index


func convert_touch_event(event):
	if event is InputEventScreenTouch:
		if event.pressed:
			mouse_press(event.position)
		else:
			mouse_release(event.position)
	if event is InputEventScreenDrag:
		mouse_drag(event.position, event.relative)
		if mouse_action == 4:
			if event.relative.y >= 1:
				mouse_scroll_down(0.5)
			if event.relative.y <= -1:
				mouse_scroll_up(0.5)
			if event.relative.y > -1 and event.relative.y < 1:
				mouse_stop_scrolling()


func mouse_press(mouse_pos):
	mouse_button = InputEventMouseButton.new()
	match mouse_action:
		0:
			pass
		1:
			mouse_button.button_index = BUTTON_LEFT
			mouse_button.button_mask = BUTTON_MASK_LEFT
			mouse_button.pressed = true
			mouse_button.position = mouse_pos
			Input.parse_input_event(mouse_button)
		2:
			mouse_button.button_index = BUTTON_RIGHT
			mouse_button.button_mask = BUTTON_MASK_RIGHT
			mouse_button.pressed = true
			mouse_button.position = mouse_pos
			Input.parse_input_event(mouse_button)
		3:
			mouse_button.button_index = BUTTON_MIDDLE
			mouse_button.button_mask = BUTTON_MASK_MIDDLE
			mouse_button.pressed = true
			mouse_button.position = mouse_pos
			Input.parse_input_event(mouse_button)
		4:
			pass


func mouse_release(mouse_pos):
	mouse_button = InputEventMouseButton.new()
	match mouse_action:
		0:
			pass
		1:
			mouse_button.button_index = BUTTON_LEFT
			mouse_button.button_mask = BUTTON_MASK_LEFT
			mouse_button.pressed = false
			mouse_button.position = mouse_pos
			Input.parse_input_event(mouse_button)
		2:
			mouse_button.button_index = BUTTON_RIGHT
			mouse_button.button_mask = BUTTON_MASK_RIGHT
			mouse_button.pressed = false
			mouse_button.position = mouse_pos
			Input.parse_input_event(mouse_button)
		3:
			mouse_button.button_index = BUTTON_MIDDLE
			mouse_button.button_mask = BUTTON_MASK_MIDDLE
			mouse_button.pressed = false
			mouse_button.position = mouse_pos
			Input.parse_input_event(mouse_button)
		4:
			pass


func mouse_drag(mouse_pos, mouse_relative):
	mouse_motion = InputEventMouseMotion.new()
	match mouse_action:
		0:
			pass
		1:
			mouse_motion.button_mask = BUTTON_MASK_LEFT
			mouse_motion.position = mouse_pos
			mouse_motion.relative = mouse_relative
			Input.parse_input_event(mouse_motion)
		2:
			mouse_motion.button_mask = BUTTON_MASK_RIGHT
			mouse_motion.position = mouse_pos
			mouse_motion.relative = mouse_relative
			Input.parse_input_event(mouse_motion)
		3:
			mouse_motion.button_mask = BUTTON_MASK_MIDDLE
			mouse_motion.position = mouse_pos
			mouse_motion.relative = mouse_relative
			Input.parse_input_event(mouse_motion)
		4:
			pass


func mouse_stop_scrolling():
	pass


func mouse_scroll_up(mouse_factor):
	mouse_button = InputEventMouseButton.new()
	mouse_button.button_index = BUTTON_WHEEL_UP
	mouse_button.factor = mouse_factor
	Input.parse_input_event(mouse_button)


func mouse_scroll_down(mouse_factor):
	mouse_button = InputEventMouseButton.new()
	mouse_button.button_index = BUTTON_WHEEL_DOWN
	mouse_button.factor = mouse_factor
	Input.parse_input_event(mouse_button)














