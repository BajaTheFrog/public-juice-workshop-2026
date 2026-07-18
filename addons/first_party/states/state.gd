# Virtual base class for all states.
extends Node
class_name State

# Reference to the state machine, to call its `transition_to()` method directly.
# That's one unorthodox detail of our state implementation, as it adds a dependency between the
# state and the state machine objects, but we found it to be most efficient for our needs.
# The state machine node will set it.
var state_machine: StateMachine = null
var is_in_state: bool = false
var id: String = ""

# Virtual function. Called by the state machine upon changing the active state. The `msg` parameter
# is a dictionary with arbitrary data the state can use to initialize itself.
func enter(previous_state_id: String, properties := {}) -> void:
	is_in_state = true
	

# Virtual function. Corresponds to the `_process()` callback.
func process_update(delta: float) -> void:
	pass


# Virtual function. Corresponds to the `_physics_process()` callback.
func physics_update(delta: float) -> void:
	pass
	

# Virtual function. Receives events from the `_unhandled_input()` callback.
func input_update(event: InputEvent) -> void:
	pass


# Virtual function. Receives events from the `_unhandled_input()` callback.
func unhandled_input_update(event: InputEvent) -> void:
	pass


# Virtual function. Called by the state machine before changing the active state. Use this function
# to clean up the state.
func exit(next_state_id: String) -> void:
	is_in_state = false
	
	
func go_to(new_state_id: String, properties: Dictionary = {}) -> void:
	state_machine.transition_to(new_state_id, properties)
