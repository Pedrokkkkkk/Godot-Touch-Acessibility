tool
extends Control


signal action_changed(action)
signal scene_saved()


var keyboard_is_shown = true


func _ready():
	set_options()


func _process(_delta):
	var focus = get_focus_owner()
	if focus is TextEdit:
		focus.virtual_keyboard_enabled = keyboard_is_shown
		if !keyboard_is_shown:
			OS.hide_virtual_keyboard()


func set_options():
	var options = $ScrollContainer/VBoxContainer/OptionButton
	options.clear()
	options.add_item("Pass", 0)
	options.add_item("Left Button", 1)
	options.add_item("Right Button", 2)
	options.add_item("Middle Button", 3)
	options.add_item("Scroll", 4)
	var show_keyboard_chekbox = $ScrollContainer/VBoxContainer/CheckButton
	show_keyboard_chekbox.pressed = keyboard_is_shown


func action_selected(index):
	emit_signal("action_changed", index)


func run():
	var key = InputEventKey.new()
	key.scancode = KEY_F5
	key.pressed = true
	Input.parse_input_event(key)


func run_scene():
	var key = InputEventKey.new()
	key.scancode = KEY_F6
	key.pressed = true
	Input.parse_input_event(key)


func save_scene():
	var key = InputEventKey.new()
	key.control = true
	key.scancode = KEY_S
	key.pressed = true
	Input.parse_input_event(key)


func add_node():
	var key = InputEventKey.new()
	key.control = true
	key.scancode = KEY_A
	key.pressed = true
	Input.parse_input_event(key)


func duplicate_node():
	var key = InputEventKey.new()
	key.control = true
	key.scancode = KEY_D
	key.pressed = true
	Input.parse_input_event(key)


func delete_node():
	var key = InputEventKey.new()
	key.scancode = KEY_DELETE
	key.pressed = true
	Input.parse_input_event(key)


func move_node_up():
	var key = InputEventKey.new()
	key.control = true
	key.scancode = KEY_UP
	key.pressed = true
	Input.parse_input_event(key)


func move_node_down():
	var key = InputEventKey.new()
	key.control = true
	key.scancode = KEY_DOWN
	key.pressed = true
	Input.parse_input_event(key)


func undo():
	var key = InputEventKey.new()
	key.control = true
	key.scancode = KEY_Z
	key.pressed = true
	Input.parse_input_event(key)


func redo():
	var key = InputEventKey.new()
	key.control = true
	key.shift = true
	key.scancode = KEY_Z
	key.pressed = true
	Input.parse_input_event(key)


func copy():
	var key = InputEventKey.new()
	key.control = true
	key.scancode = KEY_C
	key.pressed = true
	Input.parse_input_event(key)


func cut():
	var key = InputEventKey.new()
	key.control = true
	key.scancode = KEY_X
	key.pressed = true
	Input.parse_input_event(key)


func paste():
	var key = InputEventKey.new()
	key.control = true
	key.scancode = KEY_V
	key.pressed = true
	Input.parse_input_event(key)


func keyboard_shown(shown):
	keyboard_is_shown = shown
