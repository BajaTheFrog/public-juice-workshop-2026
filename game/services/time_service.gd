extends GameService
class_name TimeService
# TimeService
# The single authority for Engine.time_scale. Anywhere in the game can request
# to run at a given speed; this service reconciles competing requests and
# guarantees time always resolves back to normal.

const HIGHEST_PRIORITY = 10
const HIGH_PRIORITY = 5
const REGULAR_PRIORITY = 2
const LOW_PRIORITY = 1
const LOWEST_PRIORITY = 0
const NO_PRIORITY = -1

const NORMAL_TIME_SCALE = 1.0

# Every live request that wants to alter time. 
# Engine.time_scale is recomputed from this list whenever it changes; empty means normal speed.
var _requests: Array[TimeRequest] = []

## TIME REQUEST

class TimeRequest:
	var scale: float
	var priority: int
	# Set for sustained requests so they can be found and cleared by key.
	# Empty for timed requests (which are removed by their own timer).
	var key: StringName

	func _init(p_scale: float, p_priority: int, p_key: StringName = "") -> void:
		scale = p_scale
		priority = p_priority
		key = p_key
		

## TIMED REQUESTS

# Run at `scale` for `duration` real seconds
func set_temporary_scale(scale: float, duration: float, priority: int = REGULAR_PRIORITY) -> Signal:
	var request = TimeRequest.new(scale, priority)
	_requests.append(request)
	_apply_effective_time_scale()

	var timer = get_tree().create_timer(duration, false, false, true)
	timer.timeout.connect(_release_request.bind(request))
	return timer.timeout


## SUSTAINED REQUESTS

# Hold `scale` under `key` until cleared. Calling again with the same key
# updates the existing request in place instead of stacking a new one.
func set_sustained_time(key: StringName, p_owner: Node, scale: float, priority: int = LOW_PRIORITY) -> void:
	var request = _find_sustained(key)
	if request:
		request.scale = scale
		request.priority = priority
	else:
		_requests.append(TimeRequest.new(scale, priority, key))

	_apply_effective_time_scale()
	
	if p_owner:
		p_owner.tree_exiting.connect(func() -> void:
			# Automatically clear the key for this owner so we don't being stuck with its time
			clear_sustained_time(key)
		)
		


func clear_sustained_time(key: StringName) -> void:
	var request = _find_sustained(key)
	if not request:
		return

	_requests.erase(request)
	_apply_effective_time_scale()


## RESET

# Drop every live request and force normal speed immediately. 
func hard_reset() -> void:
	_requests.clear()
	Engine.time_scale = NORMAL_TIME_SCALE


## INTERNAL

func _release_request(request: TimeRequest) -> void:
	_requests.erase(request)
	_apply_effective_time_scale()


func _find_sustained(key: StringName) -> TimeRequest:
	for request in _requests:
		if request.key == key:
			return request

	return null


# This is the only place we should touch `Engine.time_scale`
func _apply_effective_time_scale() -> void:
	var winner: TimeRequest = null
	for request in _requests:
		if winner == null or request.priority >= winner.priority:
			winner = request

	Engine.time_scale = winner.scale if winner else NORMAL_TIME_SCALE
