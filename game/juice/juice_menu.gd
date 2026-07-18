extends CanvasLayer
class_name JuiceMenu
# JuiceMenu
# A menu for turning on and off different levels of juice.
# The same step appears in every tab, so a toggle has to update its twins.

const TAB_SEQUENCE = 0
const TAB_TYPE = 1
const TAB_MOMENT = 2

## Light lemon, to match the thing you spend the workshop rolling around as.
const HIGHLIGHT_COLOR := Color(1.0, 0.94, 0.55)
const BG_ALPHA_ON := 0.30
## Added on top of whatever the row's background already is.
const BG_ALPHA_HOVER := 0.12
const CONTENT_ALPHA_ON := 1.0
const CONTENT_ALPHA_OFF := 0.45
## Off rows come back up on hover so they stay readable while you aim at them.
const CONTENT_ALPHA_OFF_HOVER := 0.75
const FADE_TIME := 0.12

## Rows tile with no list separation, so the mouse is always over exactly one of
## them. This inset is what keeps neighbouring highlights apart -- doing that job
## with list separation instead leaves dead stripes that drop the hover.
const ROW_GAP := 4
const HEADER_GAP_TOP := 14
const HEADER_GAP_BOTTOM := 2
## Matches the row stylebox's content margin, so headers line up with step text.
const LIST_INDENT := 8

@export var panel: Control
@export var tabs: TabContainer
@export var title_label: Label
@export var progress_bar: ProgressBar
@export var sequence_list: VBoxContainer
@export var moment_list: VBoxContainer
@export var type_list: VBoxContainer
@export var all_on_button: Button
@export var all_off_button: Button

## Step id -> every row showing that step, one per tab.
var _rows: Dictionary = {}
## Only one row can be under the mouse, so the menu tracks it rather than the rows.
var _hovered_row: StepRow = null
## Whether the game was already paused when we opened, so closing does not
## un-pause something we did not pause.
var _was_paused_before_opening = false


class StepRow:
	## The tiling hover target, not the thing the highlight is drawn on.
	var row: MarginContainer
	var content: HBoxContainer
	var checkbox: CheckBox
	var style: StyleBoxFlat
	var tween: Tween

	func _init(p_row: MarginContainer, p_content: HBoxContainer, p_checkbox: CheckBox, p_style: StyleBoxFlat) -> void:
		row = p_row
		content = p_content
		checkbox = p_checkbox
		style = p_style


func _ready() -> void:
	panel.visible = false
	tabs.set_tab_title(TAB_SEQUENCE, "Sequence")
	tabs.set_tab_title(TAB_TYPE, "By Type")
	tabs.set_tab_title(TAB_MOMENT, "By Moment")
	tabs.current_tab = TAB_SEQUENCE
	all_on_button.pressed.connect(func(): Game.steps.set_all(true))
	all_off_button.pressed.connect(func(): Game.steps.set_all(false))
	Game.steps.step_changed.connect(_on_step_changed)
	_build.call_deferred()


func _input(event: InputEvent) -> void:
	if not event.is_action_pressed("toggle_juice_menu"):
		return

	_toggle()
	get_viewport().set_input_as_handled()


func _toggle() -> void:
	if panel.visible:
		close()
	else:
		open()


func open() -> void:
	if panel.visible:
		return

	panel.visible = true
	_was_paused_before_opening = Game.services.pause.is_paused()
	if not _was_paused_before_opening:
		Game.services.pause.pause_on()


func close() -> void:
	if not panel.visible:
		return

	panel.visible = false
	if not _was_paused_before_opening:
		Game.services.pause.pause_off()


func _build() -> void:
	_build_sequence()
	_build_moments()
	_build_types()
	_refresh_title()


func _build_sequence() -> void:
	for definition in Game.steps.get_definitions_in_sequence():
		_add_step_row(sequence_list, definition, true)


func _build_moments() -> void:
	for moment in Game.steps.get_moments():
		var definitions = Game.steps.get_definitions_for_moment(moment)
		if definitions.is_empty():
			continue

		_add_group_header(moment_list, moment,
			func(): Game.steps.set_all_for_moment(moment, true),
			func(): Game.steps.set_all_for_moment(moment, false))
		for definition in definitions:
			_add_step_row(moment_list, definition, false)


func _build_types() -> void:
	for type in Game.steps.get_types():
		var definitions = Game.steps.get_definitions_for_type(type)
		if definitions.is_empty():
			continue

		_add_group_header(type_list, type,
			func(): Game.steps.set_all_for_type(type, true),
			func(): Game.steps.set_all_for_type(type, false))
		for definition in definitions:
			_add_step_row(type_list, definition, false)


func _add_group_header(list: VBoxContainer, title: String, on_pressed: Callable, off_pressed: Callable) -> void:
	var header = HBoxContainer.new()

	var label = Label.new()
	label.text = title.to_upper()
	label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	header.add_child(label)

	var on_button = Button.new()
	on_button.text = "on"
	on_button.pressed.connect(on_pressed)
	header.add_child(on_button)

	var off_button = Button.new()
	off_button.text = "off"
	off_button.pressed.connect(off_pressed)
	header.add_child(off_button)

	# The list has no separation of its own now, so headers bring their own.
	var wrapper := MarginContainer.new()
	wrapper.add_theme_constant_override("margin_top", HEADER_GAP_TOP)
	wrapper.add_theme_constant_override("margin_bottom", HEADER_GAP_BOTTOM)
	wrapper.add_theme_constant_override("margin_left", LIST_INDENT)
	wrapper.add_theme_constant_override("margin_right", LIST_INDENT)
	wrapper.add_child(header)

	list.add_child(wrapper)


func _add_step_row(list: VBoxContainer, definition: Steps.StepDefinition, show_order: bool) -> void:
	# A stylebox per row: one shared instance would give every row the same background.
	var style := StyleBoxFlat.new()
	style.bg_color = Color(HIGHLIGHT_COLOR, 0.0)
	style.content_margin_left = 8
	style.content_margin_right = 8
	style.content_margin_top = 2
	style.content_margin_bottom = 2
	style.corner_radius_top_left = 4
	style.corner_radius_top_right = 4
	style.corner_radius_bottom_left = 4
	style.corner_radius_bottom_right = 4

	# The hover target tiles against its neighbours with no gap between rows, so
	# the mouse is never over dead space. PASS so it sees hover without eating
	# clicks aimed at the checkbox.
	var row := MarginContainer.new()
	row.mouse_filter = Control.MOUSE_FILTER_PASS
	row.add_theme_constant_override("margin_top", ROW_GAP)
	row.add_theme_constant_override("margin_bottom", ROW_GAP)

	# The highlight sits inset inside the hover target, which is what keeps
	# neighbouring lit rows from merging into one block.
	var highlight := PanelContainer.new()
	highlight.add_theme_stylebox_override("panel", style)
	highlight.mouse_filter = Control.MOUSE_FILTER_PASS
	row.add_child(highlight)

	# Dimming lives on the content, so it does not drag the background down with it.
	var content := HBoxContainer.new()
	highlight.add_child(content)

	var checkbox := CheckBox.new()
	checkbox.text = _row_text(definition, show_order)
	checkbox.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	checkbox.set_pressed_no_signal(Game.steps.on(definition.id))
	checkbox.toggled.connect(_on_checkbox_toggled.bind(definition.id))
	content.add_child(checkbox)

	var source_label := Label.new()
	source_label.text = definition.source
	source_label.modulate = Color(1.0, 1.0, 1.0, 0.4)
	content.add_child(source_label)

	list.add_child(row)

	var step_row := StepRow.new(row, content, checkbox, style)
	row.mouse_entered.connect(_on_row_mouse_entered.bind(step_row, definition.id))
	row.mouse_exited.connect(_on_row_mouse_exited.bind(step_row, definition.id))
	_track_row(definition.id, step_row)
	_refresh_row(step_row, definition.id, false)


func _row_text(definition: Steps.StepDefinition, show_order: bool) -> String:
	# The P.T.E tag is a code-comment breadcrumb only; it never shows in the menu.
	if not show_order:
		return definition.label

	# order counts from 0; the audience counts from 1.
	return "%02d · %s" % [definition.order + 1, definition.label]


func _track_row(id: StringName, step_row: StepRow) -> void:
	if not _rows.has(id):
		_rows[id] = []

	_rows[id].append(step_row)


func _refresh_row(step_row: StepRow, id: StringName, animate: bool) -> void:
	var is_enabled: bool = Game.steps.on(id)
	var is_hovered: bool = step_row == _hovered_row

	var background := HIGHLIGHT_COLOR
	background.a = BG_ALPHA_ON if is_enabled else 0.0
	if is_hovered:
		background.a += BG_ALPHA_HOVER

	var content_alpha := CONTENT_ALPHA_ON
	if not is_enabled:
		content_alpha = CONTENT_ALPHA_OFF_HOVER if is_hovered else CONTENT_ALPHA_OFF

	if step_row.tween and step_row.tween.is_valid():
		step_row.tween.kill()

	if not animate:
		step_row.style.bg_color = background
		step_row.content.modulate.a = content_alpha
		return

	# The menu runs while the game is paused and time may still be scaled, so the
	# fade has to be measured in real seconds.
	step_row.tween = step_row.row.create_tween()
	step_row.tween.set_ignore_time_scale()
	step_row.tween.set_parallel(true)
	step_row.tween.tween_property(step_row.style, "bg_color", background, FADE_TIME)
	step_row.tween.tween_property(step_row.content, "modulate:a", content_alpha, FADE_TIME)


func _refresh_title() -> void:
	var definitions = Game.steps.get_definitions()
	var enabled_count: int = 0
	for definition in definitions:
		if Game.steps.on(definition.id):
			enabled_count += 1

	title_label.text = "JUICE: %d/%d" % [enabled_count, definitions.size()]

	progress_bar.max_value = definitions.size()
	progress_bar.value = enabled_count


func _on_row_mouse_entered(step_row: StepRow, id: StringName) -> void:
	_hovered_row = step_row
	_refresh_row(step_row, id, false)


func _on_row_mouse_exited(step_row: StepRow, id: StringName) -> void:
	if _hovered_row != step_row:
		return

	_hovered_row = null
	_refresh_row(step_row, id, false)


func _on_checkbox_toggled(is_pressed: bool, id: StringName) -> void:
	Game.steps.set_enabled(id, is_pressed)


func _on_step_changed(id: StringName, is_enabled: bool) -> void:
	for step_row in _rows.get(id, []):
		step_row.checkbox.set_pressed_no_signal(is_enabled)
		_refresh_row(step_row, id, true)

	_refresh_title()
