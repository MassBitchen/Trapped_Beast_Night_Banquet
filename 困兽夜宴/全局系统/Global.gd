extends Node

class Flags:
	signal changed
	
	var _flags := []
	
	func has(flag: String):
		return flag in _flags
	
	func add(flag: String):
		if flag in _flags:
			return
		_flags.append(flag)
		changed.emit()

var flags := Flags.new()
