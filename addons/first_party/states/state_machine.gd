# Generic state machine. Initializes states and delegates engine callbacks
# (_physics_process, _unhandled_input) to the active state.
extends Node
class_name StateMachine

# Emitted when transitioning to a new state.
signal transitioned_to(state_name: String, from_state_name: String, data: Dictionary)

# Path to the initial active state. We export it to be able to pick the initial state in the inspector.
@export var initial_state : Node
@export var enter_initial_state_on_ready: bool

# The current active state. At the start of the game, we get the `initial_state`.
@onready var state: State = initial_state as Node

var state_map: Dictionary

func _ready() -> void:
	await owner.ready
	# The state machine assigns itself to the State objects' state_machine property.
	for child in get_children():
		var state_child = child as State
		if not state_child:
			return
		state_child.state_machine = self
		state_map[state_child.id] = state_child
		
	if enter_initial_state_on_ready:
		enter_initial_state()


func enter_initial_state():
	transition_to(state.id)
	
	
func _input(event: InputEvent) -> void:
	state.input_update(event)


# The state machine subscribes to node callbacks and delegates them to the state objects.
func _unhandled_input(event: InputEvent) -> void:
	state.unhandled_input_update(event)


func _process(delta: float) -> void:
	state.process_update(delta) 
	# TODO: Maybe also alway pass in state properties
	# or subclass state to take a special data object
	# so transitions can be made on things like 
	# velocity, scale, "abstract input" or whatever


func _physics_process(delta: float) -> void:
	state.physics_update(delta)


# This function calls the current state's exit() function, then changes the active state,
# and calls its enter function.
# It optionally takes a `properties` dictionary to pass to the next state's enter() function.
func transition_to(target_state_id: String, properties: Dictionary = {}) -> void:
	# Safety check, you could use an assert() here to report an error if the state name is incorrect.
	# We don't use an assert here to help with code reuse. If you reuse a state in different state machines
	# but you don't want them all, they won't be able to transition to states that aren't in the scene tree.
	if not state_map[target_state_id]:
		return

	var previous_state_id = ""
	if state:
		previous_state_id = state.id
		
	state.exit(target_state_id)
	state = state_map[target_state_id]
	
	state.state_machine = self
	state.enter(previous_state_id, properties)
	transitioned_to.emit(state.id, previous_state_id, properties)
	print(previous_state_id + " --> " + state.id)

	
