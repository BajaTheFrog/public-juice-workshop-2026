extends Node
class_name Steps
# Steps
# 
# This tracks all the steps that can be enabled or disabled to demonstrate
# changes in game feel and juice. 

signal step_changed(id: StringName, is_enabled: bool)

const MOMENT_PLAYER_LIFECYCLE = "🍋 Lifecycle"
const MOMENT_BAT_LIFECYCLE = "👹 Lifecycle"
const MOMENT_BULLET_LIFECYCLE = "🌱 Lifecycle"
const MOMENT_PHYSICS = "Physics"
const MOMENT_CONTACT = "Contact"
const MOMENT_OTHER = "Other"

# Steps split into two families: KINETICS (movement and input processing) and FEEDBACK (audio-visual expression of the action).
# Together they are the JUICE. A step belongs to exactly one type.
const TYPE_KINETICS = "Kinetics"
const TYPE_FEEDBACK = "Feedback"

# Player
const ACCELERATION = "acceleration"
const JUMP_GRAVITY = "jump_gravity"
const AIR_DAMPENING = "air_dampening"
const JUMP_SQUASH = "jump_squash"
const LAND_SQUASH = "land_squash"
const SHOOT_SPREAD = "shoot_spread"
const SHOOT_SHAKE = "shoot_shake"
const SHOOT_KNOCKBACK = "shoot_knockback"
const DEATH_HITSTUN = "death_hitstun"
const DEATH_SHAKE = "death_shake"
const DANGER_SLOWMO = "danger_slowmo"

# Bat
const BAT_HITSTOP = "bat_hitstop"
const BAT_HIT_FLASH = "bat_hit_flash"

# Player bullet
const BIGGER_BULLETS = "bigger_bullets"
const MUZZLE_FLASH = "muzzle_flash"

# Level
const SCREEN_FLASH = "screen_flash"
const CAMERA_TRACKING = "camera_tracking"

const SOUND_ON = "sound_on"

const SAVE_PATH = "user://juice_steps.cfg"
const SAVE_SECTION = "steps"

# We register all steps up front but we only show _supported_ ones in the menu.
# Each block below is one workshop exercise. When you start an exercise, flip that
# whole block from false -> true and its effects appear in the Juice menu (J).
var _supported: Dictionary = {
	# --- Exercise 1.1 - Movement / Kinetics ---
	ACCELERATION: true,      # [STEP-1.1.A] Acceleration
	JUMP_GRAVITY: true,      # [STEP-1.1.B] Jump / Fall Gravity
	AIR_DAMPENING: true,     # [STEP-1.1.C] Air Control / Dampening

	# --- Exercise 1.2 - Movement / Feedback ---
	JUMP_SQUASH: true,       # [STEP-1.2.A] Jump Squash + Stretch
	LAND_SQUASH: true,       # [STEP-1.2.B] Landing Squash + Stretch

	# --- Exercise 2.1 - Interactions / Kinetics ---
	DEATH_HITSTUN: true,     # [STEP-2.1.A] Player Hitstun
	BAT_HITSTOP: true,       # [STEP-2.1.B] Bat Hitstun
	SHOOT_KNOCKBACK: true,   # [STEP-2.1.C] Gun Knockback
	SHOOT_SPREAD: true,      # [STEP-2.1.D] Shoot Spread

	# --- Exercise 2.2 - Interactions / Feedback ---
	BIGGER_BULLETS: true,    # [STEP-2.2.A] Bigger Bullets
	MUZZLE_FLASH: true,      # [STEP-2.2.B] Muzzle Flash
	BAT_HIT_FLASH: true,     # [STEP-2.2.C] Bat Hitflash

	# --- Exercise 3.1 - Camera & Time / Kinetics ---
	CAMERA_TRACKING: true,   # [STEP-3.1.A] Dynamic Tracking
	DANGER_SLOWMO: true,     # [STEP-3.1.B] Danger Zone Slowmo

	# --- Exercise 3.2 - Camera & Time / Feedback ---
	SHOOT_SHAKE: false,      # [STEP-3.2.A] Gun Screenshake
	DEATH_SHAKE: false,      # [STEP-3.2.B] Death Screenshake
	SCREEN_FLASH: false,     # [STEP-3.2.C] Death Flash

	# --- Exercise 4.1 - Sound / Feedback ---
	SOUND_ON: false,         # [STEP-4.1.A] Sound
}

var _definitions: Array[StepDefinition] = []
var _enabled: Dictionary = {}


class StepDefinition:
	var order: int
	var id: StringName
	var tag: String
	var label: String
	var type: String
	var moment: String
	var source: String

	func _init(p_order: int, p_id: StringName, p_tag: String, p_label: String, p_type: String, p_moment: String, p_source: String) -> void:
		order = p_order
		id = p_id
		tag = p_tag
		label = p_label
		type = p_type
		moment = p_moment
		source = p_source


# Should we consider the given step active for the given component
static func check(component: Component, step: String) -> bool:
	return component.enabled and Game.steps.on(step)


func _ready() -> void:
	# Registration order drives sequence order. Tags are P.T.E breadcrumbs
	# (Part.Type.Element) that match the [STEP] comments in code. The Part.Type
	# pair is one workshop exercise; the Element letter is one effect inside it.
	# So searching [STEP-1.1 finds a whole exercise, [STEP-1.1.B] finds one effect.
	# --- Part 1: Movement ---
	# --- KINETICS (Exercise 1.1)
	_register(ACCELERATION, "1.1.A", "🍋 Acceleration", TYPE_KINETICS, MOMENT_PHYSICS, "player_juice_box.gd")
	_register(JUMP_GRAVITY, "1.1.B", "🍋 Jump / Fall Gravity", TYPE_KINETICS, MOMENT_PHYSICS, "player_juice_box.gd")
	_register(AIR_DAMPENING, "1.1.C", "🍋 Air Control / Dampening", TYPE_KINETICS, MOMENT_PHYSICS, "player_juice_box.gd")
	# --- FEEDBACK (Exercise 1.2)
	_register(JUMP_SQUASH, "1.2.A", "🍋 Jump Squash + Stretch", TYPE_FEEDBACK, MOMENT_PLAYER_LIFECYCLE, "player_juice_box.gd")
	_register(LAND_SQUASH, "1.2.B", "🍋 Landing Squash + Stretch", TYPE_FEEDBACK, MOMENT_PLAYER_LIFECYCLE, "player_juice_box.gd")
	# --- Part 2: Interactions ---
	# --- KINETICS (Exercise 2.1)
	_register(DEATH_HITSTUN, "2.1.A", "🍋 Hitstun", TYPE_KINETICS, MOMENT_PLAYER_LIFECYCLE, "player_juice_box.gd")
	_register(BAT_HITSTOP, "2.1.B", "👹 Hitstun", TYPE_KINETICS, MOMENT_BAT_LIFECYCLE, "bat_juice_box.gd")
	_register(SHOOT_KNOCKBACK, "2.1.C", "🍋 Gun Knockback", TYPE_KINETICS, MOMENT_BULLET_LIFECYCLE, "player_juice_box.gd")
	_register(SHOOT_SPREAD, "2.1.D", "🍋 Shoot Spread", TYPE_KINETICS, MOMENT_OTHER, "player_juice_box.gd")
	# --- FEEDBACK (Exercise 2.2)
	_register(BIGGER_BULLETS, "2.2.A", "🍋 Bigger Bullets", TYPE_FEEDBACK, MOMENT_OTHER, "player_bullet_juice_box.gd")
	_register(MUZZLE_FLASH, "2.2.B", "🍋 Muzzle Flash", TYPE_FEEDBACK, MOMENT_BULLET_LIFECYCLE, "player_bullet_juice_box.gd")
	_register(BAT_HIT_FLASH, "2.2.C", "👹 Hitflash", TYPE_FEEDBACK, MOMENT_BAT_LIFECYCLE, "bat_juice_box.gd")
	# --- Part 3: Camera and Time ---
	# --- KINETICS (Exercise 3.1)
	_register(CAMERA_TRACKING, "3.1.A", "📺 Dynamic Tracking", TYPE_KINETICS, MOMENT_OTHER, "level_juice_box.gd")
	_register(DANGER_SLOWMO, "3.1.B", "⏰ Danger Zone Slowmo", TYPE_KINETICS, MOMENT_OTHER, "player_juice_box.gd")
	# --- FEEDBACK (Exercise 3.2)
	_register(SHOOT_SHAKE, "3.2.A", "📺 Gun Screenshake", TYPE_FEEDBACK, MOMENT_OTHER, "player_juice_box.gd")
	_register(DEATH_SHAKE, "3.2.B", "📺 Death Screenshake", TYPE_FEEDBACK, MOMENT_PLAYER_LIFECYCLE, "player_juice_box.gd")
	_register(SCREEN_FLASH, "3.2.C", "📺 Death Flash", TYPE_FEEDBACK, MOMENT_PLAYER_LIFECYCLE, "level_juice_box.gd")
	# --- Part 4: Sound ---
	# --- FEEDBACK (Exercise 4.1)
	# One global switch: flip this on to bring every juice box's SFX to life at once.
	_register(SOUND_ON, "4.1.A", "🔊 Sound", TYPE_FEEDBACK, MOMENT_OTHER, "*_juice_box.gd")


	_load_enabled_states()


func _register(id: StringName, tag: String, label: String, type: String, moment: String, source: String) -> void:
	var order: int = _definitions.size()
	_definitions.append(StepDefinition.new(order, id, tag, label, type, moment, source))
	# Steps default ON so that writing a juice function makes it work immediately.
	_enabled[id] = true


func on(id: StringName) -> bool:
	return _enabled.get(id, true)


func set_enabled(id: StringName, is_enabled: bool) -> void:
	if _apply(id, is_enabled):
		_save_enabled_states()


func set_all(is_enabled: bool) -> void:
	var has_changed = false
	for definition in _definitions:
		has_changed = _apply(definition.id, is_enabled) or has_changed

	if has_changed:
		_save_enabled_states()


func set_all_for_moment(moment: String, is_enabled: bool) -> void:
	var has_changed = false
	for definition in get_definitions_for_moment(moment):
		has_changed = _apply(definition.id, is_enabled) or has_changed

	if has_changed:
		_save_enabled_states()


func set_all_for_type(type: String, is_enabled: bool) -> void:
	var has_changed = false
	for definition in get_definitions_for_type(type):
		has_changed = _apply(definition.id, is_enabled) or has_changed

	if has_changed:
		_save_enabled_states()


func enable_all() -> void:
	set_all(true)


func disable_all() -> void:
	set_all(false)


# Is this step visible in the menu yet? Unlisted ids default to hidden.
func is_supported(id: StringName) -> bool:
	return _supported.get(id, false)


func get_definitions() -> Array[StepDefinition]:
	return _definitions.filter(func(definition): return is_supported(definition.id))


func get_definitions_in_sequence() -> Array[StepDefinition]:
	var definitions: Array[StepDefinition] = get_definitions()
	definitions.sort_custom(func(a, b): return a.order < b.order)
	return definitions


func get_definitions_for_moment(moment: String) -> Array[StepDefinition]:
	return _definitions.filter(func(definition): return is_supported(definition.id) and definition.moment == moment)


func get_definitions_for_type(type: String) -> Array[StepDefinition]:
	return _definitions.filter(func(definition): return is_supported(definition.id) and definition.type == type)


func get_moments() -> Array[String]:
	return [
		MOMENT_PLAYER_LIFECYCLE,
		MOMENT_BAT_LIFECYCLE,
		MOMENT_BULLET_LIFECYCLE,
		MOMENT_PHYSICS,
		MOMENT_CONTACT,
		MOMENT_OTHER
		]


func get_types() -> Array[String]:
	return [TYPE_KINETICS, TYPE_FEEDBACK]


func _apply(id: StringName, is_enabled: bool) -> bool:
	if not _enabled.has(id):
		push_warning("Unknown juice step: " + id)
		return false

	if _enabled[id] == is_enabled:
		return false

	_enabled[id] = is_enabled
	step_changed.emit(id, is_enabled)
	return true


func _load_enabled_states() -> void:
	var config = ConfigFile.new()
	if config.load(SAVE_PATH) != OK:
		return

	for definition in _definitions:
		_enabled[definition.id] = config.get_value(SAVE_SECTION, definition.id, true)


func _save_enabled_states() -> void:
	var config = ConfigFile.new()
	for definition in _definitions:
		config.set_value(SAVE_SECTION, definition.id, _enabled[definition.id])

	config.save(SAVE_PATH)
