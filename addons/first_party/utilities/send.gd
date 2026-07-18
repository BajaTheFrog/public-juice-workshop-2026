extends RefCounted
class_name Send

const FUNCTION_NAME = "_message"
# signature: func _message(msg: String, payload: Dictonary, from: Object) 

static func the(msg: String, payload: Dictionary, to: Object, from: Object) -> bool:
	if not to.has_method(FUNCTION_NAME):
		return false
	
	to.call(FUNCTION_NAME, msg, payload, from)
	return true
	

static func message(msg: String, payload: Dictionary = {}) -> MessageBlock:
	return MessageBlock.new(msg, payload)	


class MessageBlock:
	var message: String
	var payload: Dictionary
	
	func _init(p_message: String, p_payload: Dictionary):
		message = p_message
		payload = p_payload
		

	func to(receiver: Object, sender: Object = null) -> bool:
		return Send.the(message, payload, receiver, sender)
