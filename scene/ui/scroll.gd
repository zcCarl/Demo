extends ScrollContainer
var drag_speed = Vector2()
var drag_accum = Vector2()
var last_drag_accum = Vector2()
var drag_from = Vector2()
var drag_touching = true
var drag_touching_deaccel = false
var beyond_deadzone = false
var time_since_motion = 0
func _cancel_drag():
	set_physics_process_internal(false);
	drag_touching_deaccel = false;
	drag_touching = false;
	drag_speed = Vector2();
	drag_accum = Vector2();
	last_drag_accum = Vector2();
	drag_from = Vector2();

	if beyond_deadzone :
		emit_signal("scroll_ended");
		propagate_notification(NOTIFICATION_SCROLL_END);
		beyond_deadzone = false;
	
	pass
func _gui_input(event):
	var prev_v_scroll = get_v_scroll_bar().get_value()
	var prev_h_scroll = get_h_scroll_bar().get_value()
	var h_scroll_enabled = horizontal_scroll_mode != SCROLL_MODE_DISABLED;
	var v_scroll_enabled = vertical_scroll_mode != SCROLL_MODE_DISABLED;
	if event is InputEventMouseButton:
		if event.is_pressed():
			var scroll_value_modified = false;
			var v_scroll_hidden = !get_v_scroll_bar().is_visible() && vertical_scroll_mode != SCROLL_MODE_SHOW_NEVER;
			if event.button_index == MOUSE_BUTTON_WHEEL_UP:
				# By default, the vertical orientation takes precedence. This is an exception.
				if (h_scroll_enabled && event.shift_pressed) || v_scroll_hidden :
					get_h_scroll_bar().set_value(prev_h_scroll - get_h_scroll_bar().get_page() / 8 * event.factor)
					scroll_value_modified = true
				elif (v_scroll_enabled) :
					get_v_scroll_bar().set_value(prev_v_scroll - get_v_scroll_bar().get_page() / 8 * event.factor)
					scroll_value_modified = true
				
			
			if event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
				if (h_scroll_enabled && event.shift_pressed) || v_scroll_hidden: 
					get_h_scroll_bar().set_value(prev_h_scroll + get_h_scroll_bar().get_page() / 8 * event.factor)
					scroll_value_modified = true
				elif (v_scroll_enabled) :
					get_v_scroll_bar().set_value(prev_v_scroll + get_v_scroll_bar().get_page() / 8 * event.factor)
					scroll_value_modified = true
				

			if (scroll_value_modified and (get_v_scroll_bar().get_value() != prev_v_scroll || get_h_scroll_bar().get_value() != prev_h_scroll)) :
				accept_event() # Accept event if scroll changed.
				return
		
		var is_touchscreen_available = DisplayServer.is_touchscreen_available()
		if !is_touchscreen_available :
			return
		
		if event.button_index != MOUSE_BUTTON_LEFT: 
			return
		if event.is_pressed():
			if drag_touching:
				_cancel_drag()

			drag_speed = Vector2();
			drag_accum = Vector2();
			last_drag_accum = Vector2();
			drag_from = Vector2(prev_h_scroll, prev_v_scroll);
			drag_touching = true;
			drag_touching_deaccel = false;
			beyond_deadzone = false;
			time_since_motion = 0;
			set_physics_process_internal(true);
			time_since_motion = 0;

		else:
			if drag_touching:
				if drag_speed == Vector2():
					_cancel_drag();
				else:
					drag_touching_deaccel = true;
				
		return;
	if event is InputEventMouseMotion:
		if drag_touching && !drag_touching_deaccel:
			var motion = event.relative
			drag_accum -= motion;

			if beyond_deadzone || (h_scroll_enabled && abs(drag_accum.x) > scroll_deadzone) || (v_scroll_enabled && abs(drag_accum.y) > scroll_deadzone):
				if !beyond_deadzone:
					propagate_notification(NOTIFICATION_SCROLL_BEGIN);
					emit_signal("scroll_started");

					beyond_deadzone = true;
					# Resetting drag_accum here ensures smooth scrolling after reaching deadzone.
					drag_accum = -motion;
				
				var diff = drag_from + drag_accum;
				if h_scroll_enabled: 
					get_h_scroll_bar().set_value(diff.x);
				else:
					drag_accum.x = 0;
				
				if v_scroll_enabled:
					get_v_scroll_bar().set_value(diff.y);
				else:
					drag_accum.y = 0;
				
				time_since_motion = 0

		if get_v_scroll_bar().get_value() != prev_v_scroll || get_h_scroll_bar().get_value() != prev_h_scroll: 
			accept_event(); # Accept event if scroll changed.
		
		return
	if event is InputEventPanGesture:
		if h_scroll_enabled: 
			get_h_scroll_bar().set_value(prev_h_scroll + get_h_scroll_bar().get_page() * event.delta.x / 8);
		
		if v_scroll_enabled: 
			get_v_scroll_bar().set_value(prev_v_scroll + get_v_scroll_bar().get_page() * event.delta.y / 8);
		

		if get_v_scroll_bar().get_value() != prev_v_scroll || get_h_scroll_bar().get_value() != prev_h_scroll: 
			accept_event(); # Accept event if scroll changed.
		
		return;
	
