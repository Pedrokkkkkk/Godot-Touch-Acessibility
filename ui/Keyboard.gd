tool
extends Control


var characters
var numbers
var letters1
var letters2
var letters3
var bar
var lower = [
	["(", ")", "[", "]", "{", "}", ":", ";", "$", "!", "#"],
	["TAB", "1", "2", "3", "4", "5", "6", "7", "8", "9", "0"],
	["q", "w", "e", "r", "t", "y", "u", "i", "o", "p"],
	["a", "s", "d", "f", "g", "h", "j", "k", "l"],
	["SHIFT", "z", "x", "c", "v", "b", "n", "m", "BACK"],
	[".", "<", "SPACE", ">", ",", "ENTER"]
]
var upper = [
	["\"", "*", "/", "\\", "+", "-", "=", "%", "~", "&", "_"],
	["TAB", "1", "2", "3", "4", "5", "6", "7", "8", "9", "0"],
	["Q", "W", "E", "R", "T", "Y", "U", "I", "O", "P"],
	["A", "S", "D", "F", "G", "H", "J", "K", "L"],
	["SHIFT", "Z", "X", "C", "V", "B", "N", "M", "BACK"],
	[".", "<", "SPACE", ">", ",", "ENTER"]
	
]
var shift_hold
var key_modifier = false


func _enter_tree():
	set_keys()


func set_keys():
	characters = $VBoxContainer/Characters
	numbers = $VBoxContainer/Numbers
	letters1 = $VBoxContainer/Letters1
	letters2 = $VBoxContainer/Letters2
	letters3 = $VBoxContainer/Letters3
	bar = $VBoxContainer/Bar
	for key in characters.get_children():
		if key is Button:
			key.action_mode = BaseButton.ACTION_MODE_BUTTON_PRESS
			key.focus_mode = Control.FOCUS_NONE
			if !key.is_connected("button_down", self, "key_pressed") and !key.is_connected("button_up", self, "key_released"):
				key.connect("button_down", self, "key_pressed", [key])
				key.connect("button_up", self, "key_released")
			if shift_hold:
				var key_string = upper[0][key.get_index()]
				key.text = key_string
			else:
				var key_string = lower[0][key.get_index()]
				key.text = key_string
	for key in numbers.get_children():
		if key is Button:
			key.action_mode = BaseButton.ACTION_MODE_BUTTON_PRESS
			key.focus_mode = Control.FOCUS_NONE
			if !key.is_connected("button_down", self, "key_pressed") and !key.is_connected("button_up", self, "key_released"):
				key.connect("button_down", self, "key_pressed", [key])
				key.connect("button_up", self, "key_released")
			if shift_hold:
				var key_string = upper[1][key.get_index()]
				key.text = key_string
			else:
				var key_string = lower[1][key.get_index()]
				key.text = key_string
	for key in letters1.get_children():
		if key is Button:
			key.action_mode = BaseButton.ACTION_MODE_BUTTON_PRESS
			key.focus_mode = Control.FOCUS_NONE
			if !key.is_connected("button_down", self, "key_pressed") and !key.is_connected("button_up", self, "key_released"):
				key.connect("button_down", self, "key_pressed", [key])
				key.connect("button_up", self, "key_released")
			if shift_hold:
				var key_string = upper[2][key.get_index()]
				key.text = key_string
			else:
				var key_string = lower[2][key.get_index()]
				key.text = key_string
	for key in letters2.get_children():
		if key is Button:
			key.action_mode = BaseButton.ACTION_MODE_BUTTON_PRESS
			key.focus_mode = Control.FOCUS_NONE
			if !key.is_connected("button_down", self, "key_pressed") and !key.is_connected("button_up", self, "key_released"):
				key.connect("button_down", self, "key_pressed", [key])
				key.connect("button_up", self, "key_released")
			if shift_hold:
				var key_string = upper[3][key.get_index()]
				key.text = key_string
			else:
				var key_string = lower[3][key.get_index()]
				key.text = key_string
	for key in letters3.get_children():
		if key is Button:
			key.action_mode = BaseButton.ACTION_MODE_BUTTON_PRESS
			key.focus_mode = Control.FOCUS_NONE
			if !key.is_connected("button_down", self, "key_pressed") and !key.is_connected("button_up", self, "key_released"):
				key.connect("button_down", self, "key_pressed", [key])
				key.connect("button_up", self, "key_released")
			if shift_hold:
				var key_string = upper[4][key.get_index()]
				key.text = key_string
			else:
				var key_string = lower[4][key.get_index()]
				key.text = key_string
	for key in bar.get_children():
		if key is Button:
			key.action_mode = BaseButton.ACTION_MODE_BUTTON_PRESS
			key.focus_mode = Control.FOCUS_NONE
			if !key.is_connected("button_down", self, "key_pressed") and !key.is_connected("button_up", self, "key_released"):
				key.connect("button_down", self, "key_pressed", [key])
				key.connect("button_up", self, "key_released")
			if shift_hold:
				var key_string = upper[5][key.get_index()]
				key.text = key_string
			else:
				var key_string = lower[5][key.get_index()]
				key.text = key_string


func key_pressed(key):
	insert_key(key)


func key_released():
	pass


func insert_key(key):
	var key_event = InputEventKey.new()
	var key_string = key.text
	var focus = get_focus_owner()
	match key_string:
		"TAB":
			key_modifier = true
			key_event.scancode = KEY_TAB
		"SHIFT":
			key_modifier = true
			key_event.scancode = KEY_SHIFT
			if shift_hold:
				shift_hold = false
			else:
				shift_hold = true
			set_keys()
		"BACK":
			key_modifier = true
			key_event.scancode = KEY_BACKSPACE
		"SPACE":
			key_modifier = false
			key_string = " "
		"ENTER":
			key_modifier = true
			key_event.scancode = KEY_ENTER
	if focus is TextEdit:
		if !key_modifier:
			if key_string == " ":
				focus.insert_text_at_cursor(key_string)
			else:
				if shift_hold:
					focus.insert_text_at_cursor(key_string.to_upper())
				else:
					focus.insert_text_at_cursor(key_string.to_lower())
		else:
			key_event.pressed = true
			key_modifier = false
			Input.parse_input_event(key_event)
