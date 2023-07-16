extends RefCounted
class_name battle_queue
var queue:Array[c_data] = []

class c_data extends RefCounted:
	var team_index = -1
	var character_index = -1
	var speed = 0
	var delay = 0
	func _to_string():
		return "队伍位置"+str(team_index)+"角色位置"+str(character_index)+"延迟"+str(delay) +"速度"+str(speed)
	
func enqueue(c_data:c_data):
	var finalPos = 0
	var high = queue.size()
	while finalPos < high :
		var middle = (finalPos + high)/2
		if c_data.delay < queue[middle].delay:
			high = middle
		else:
			finalPos = middle + 1
	print("加入队列位置",finalPos,"队伍",c_data.team_index,"队伍位置",c_data.character_index,"速度",c_data.speed,"延迟",c_data.delay)
	queue.insert(finalPos,c_data)
	
func next_action()->c_data:
	var fast = queue[0].delay
	for c_data in queue:
		c_data.delay -= fast
	return queue.pop_front()
	
func dequeue():
	return queue.pop_front()




