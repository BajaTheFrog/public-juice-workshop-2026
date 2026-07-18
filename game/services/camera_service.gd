extends GameService
class_name CameraService
# CameraService
# The single authority for the active camera's shake offset. Anywhere in the
# game can request a shake; this service sums the live requests every frame and
# guarantees the camera always resolves back to its resting offset. 

const MAX_SHAKE: float = 10_000.0

var is_shake_enabled: bool = true
var active_camera: Camera2D
var default_offset: Vector2 = Vector2.ZERO

# Every live request that wants to shake the camera.
# The offset is recomputed from this list every frame; empty means resting offset.
var _requests: Array[ShakeRequest] = []

# Real-time clock (unscaled by Engine.time_scale) so shakes animate and expire
# correctly during hitstop / slow-mo
var _last_tick_usec: int = 0


## SHAKE REQUEST

class ShakeRequest:
	var amplitude: float
	# Real seconds the shake lasts. <= 0 means sustained (never expires on its own).
	var duration: float
	var elapsed: float = 0.0
	# Set for sustained requests so they can be found and cleared by key.
	# Empty for timed requests (which expire by their own elapsed time).
	var key: StringName

	func _init(p_amplitude: float, p_duration: float, p_key: StringName = "") -> void:
		amplitude = p_amplitude
		duration = p_duration
		key = p_key

	# Amplitude right now: sustained holds steady, timed decays linearly to zero.
	func current_amplitude() -> float:
		if duration <= 0.0:
			return amplitude
		return amplitude * (1.0 - elapsed / duration)


	func is_expired() -> bool:
		return duration > 0.0 and elapsed >= duration


## LIFECYCLE

func _ready() -> void:
	set_process(false)


func _process(_delta: float) -> void:
	_advance_requests()

	if active_camera == null:
		return

	if _requests.is_empty():
		# Guaranteed clean return: no timer or tween to finish, just the resting offset.
		active_camera.offset = default_offset
		set_process(false)
		return

	var effective := _effective_amplitude()
	var noise := Vector2(Random.randf_range(-1.0, 1.0), Random.randf_range(-1.0, 1.0))
	active_camera.offset = default_offset + noise * effective


## PUBLIC API

func set_active_camera(camera_2d: Camera2D) -> void:
	active_camera = camera_2d
	default_offset = camera_2d.offset


## TIMED REQUESTS

# Shake at `amplitude` px, decaying to zero over `duration` real seconds.
func add_shake(amplitude: float, duration: float = 0.4) -> void:
	if not _can_shake():
		return
	_requests.append(ShakeRequest.new(amplitude, duration))
	_refresh_processing()


## SUSTAINED REQUESTS

# Hold `amplitude` under `key` until cleared. Calling again with the same key
# updates the existing request in place instead of stacking a new one.
func set_sustained_shake(key: StringName, p_owner: Node, amplitude: float) -> void:
	if not _can_shake():
		return

	var request := _find_sustained(key)
	if request:
		request.amplitude = amplitude
	else:
		_requests.append(ShakeRequest.new(amplitude, 0.0, key))

	_refresh_processing()

	if p_owner:
		p_owner.tree_exiting.connect(func() -> void:
			# Auto-clear the key so we don't stay stuck shaking after the owner is gone.
			clear_sustained_shake(key)
		)


func clear_sustained_shake(key: StringName) -> void:
	var request := _find_sustained(key)
	if not request:
		return
	# Leave processing on so _process settles the offset back to default next frame.
	_requests.erase(request)


## RESET

# Drop every live request and snap the camera back to rest immediately.
func hard_reset() -> void:
	_requests.clear()
	if active_camera:
		active_camera.offset = default_offset
	set_process(false)


## INTERNAL

func _can_shake() -> bool:
	return is_shake_enabled


# Refreshes process state and kicks it off if we are not currently processing
func _refresh_processing() -> void:
	if not is_processing():
		# Reset the clock so the first frame after re-arming has a ~zero delta.
		_last_tick_usec = Time.get_ticks_usec()
		set_process(true)


func _advance_requests() -> void:
	var now := Time.get_ticks_usec()
	# Real (unscaled) delta, clamped so a pause or frame hitch can't jump the decay.
	var real_delta := minf((now - _last_tick_usec) / 1_000_000.0, 0.1)
	_last_tick_usec = now

	# Reverse iterate so removals don't skip elements.
	for i in range(_requests.size() - 1, -1, -1):
		var request := _requests[i]
		request.elapsed += real_delta
		if request.is_expired():
			_requests.remove_at(i)


func _effective_amplitude() -> float:
	var total := 0.0
	for request in _requests:
		total += request.current_amplitude()
	return minf(total, MAX_SHAKE)


func _find_sustained(key: StringName) -> ShakeRequest:
	for request in _requests:
		if request.key == key:
			return request

	return null
