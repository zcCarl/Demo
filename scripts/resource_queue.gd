extends Node

class load_async_res:
	signal completed
	signal progress
var thread:Thread
var mutex:Mutex
var semaphore:Semaphore
var exit_thread = false

var time_max = 100 # Milliseconds.

var queue = []
var progress = {}
var loading = {}

func _enter_tree():
	start()

func _lock(_caller):
	#print("_lock: "+ _caller + Time.get_datetime_string_from_system())
	mutex.lock()


func _unlock(_caller):
	
	#print("_unlock: " + _caller + Time.get_datetime_string_from_system())
	mutex.unlock()


func _post(_caller):
	
	#print("_post: " + _caller + Time.get_datetime_string_from_system())
	semaphore.post()


func _wait(_caller):
	
	#print("_wait: " + _caller + Time.get_datetime_string_from_system())
	semaphore.wait()


func queue_resource(path, p_in_front = false):
	_lock("queue_resource")
	var statu =	ResourceLoader.load_threaded_get_status(path)
	if statu == ResourceLoader.THREAD_LOAD_IN_PROGRESS:
		_post("queue_resource")
		_unlock("queue_resource")
		return loading[path]
	else:
		var ok = ResourceLoader.load_threaded_request(path)
		assert(ok == 0, "ResourceLoader.load_threaded_request error:"+str(ok))
		if ok == 0 :
			loading[path] = load_async_res.new()
			progress[path] = []
			if p_in_front:
				queue.insert(0, path)
			else:
				queue.push_back(path)
			_post("queue_resource")
			_unlock("queue_resource")
			return loading[path]
	_post("queue_resource")
	_unlock("queue_resource")
	return null
	
func cancel_resource(path):
	_lock("cancel_resource")
	var statu =	ResourceLoader.load_threaded_get_status(path)
	if statu == ResourceLoader.THREAD_LOAD_IN_PROGRESS:
		queue.erase(path)
	_unlock("cancel_resource")


func get_progress(path):
	_lock("get_progress")
	var ret = -1
	var statu =	ResourceLoader.load_threaded_get_status(path)
	if statu == ResourceLoader.THREAD_LOAD_IN_PROGRESS:
		if progress[path]:
			ret = progress[path][0]
	elif statu == ResourceLoader.THREAD_LOAD_LOADED:
		ret = 1.0
	_unlock("get_progress")
	return ret


func is_ready(path):
	var ret
	_lock("is_ready")
	var statu =	ResourceLoader.load_threaded_get_status(path)
	if statu == ResourceLoader.THREAD_LOAD_LOADED:
		ret = true
	else:
		ret = false
		pass
	_unlock("is_ready")
	return ret


func _wait_for_resource(path):
	_unlock("wait_for_resource")
	while true:
		RenderingServer.force_sync()
		OS.delay_usec(16000) # Wait approximately 1 frame.
		_lock("wait_for_resource")
		if queue.size() == 0 || queue[0] != path:
			var statu =	ResourceLoader.load_threaded_get_status(path,progress)
			if statu == ResourceLoader.THREAD_LOAD_LOADED:
				return ResourceLoader.load_threaded_get(path)
		_unlock("wait_for_resource")


func get_resource(path):
	_lock("get_resource")
	var statu =	ResourceLoader.load_threaded_get_status(path)
	if statu == ResourceLoader.THREAD_LOAD_LOADED:
		var res = ResourceLoader.load_threaded_get(path)
		_unlock("return")
		return res
	elif statu == ResourceLoader.THREAD_LOAD_IN_PROGRESS:
		var pos = queue.find(path)
		queue.remove(pos)
		queue.insert(0, path)
		var res = _wait_for_resource(path)
		_unlock("return")
		return res
	else:
		_unlock("return")
		return ResourceLoader.load(path)
		pass

func thread_process():
	_wait("thread_process")
	_lock("process")
	while queue.size() > 0:
		var path = queue[0]
		_unlock("process_statu")
		var statu = ResourceLoader.load_threaded_get_status(path,progress[path])
		_lock("process_check_queue")
		if statu == ResourceLoader.THREAD_LOAD_LOADED:
			var res = ResourceLoader.load_threaded_get(path)
			loading[path].completed.emit(res)
			loading.erase(path)
			queue.erase(path)
		elif statu == ResourceLoader.THREAD_LOAD_IN_PROGRESS:
			loading[path].progress.emit(progress[path][0])
		elif statu == ResourceLoader.THREAD_LOAD_FAILED:
			loading.erase(path)
			queue.erase(path)
			pass
	_unlock("process")


func thread_func():
	while true:
		mutex.lock()
		var should_exit = exit_thread # Protect with Mutex.
		mutex.unlock()

		if should_exit:
			break
		thread_process()


func start():
	mutex = Mutex.new()
	semaphore = Semaphore.new()
	thread = Thread.new()
	thread.start(thread_func)

# Triggered by calling "get_tree().quit()".
func _exit_tree():
	mutex.lock()
	exit_thread = true # Protect with Mutex.
	mutex.unlock()

	# Unblock by posting.
	semaphore.post()

	# Wait until it exits.
	thread.wait_to_finish()
