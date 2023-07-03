extends Node

var thread
var mutex
var semaphore
var exit_thread = false

var time_max = 100 # Milliseconds.

var queue = []
var progress = {}

func _lock(_caller):
	mutex.lock()


func _unlock(_caller):
	mutex.unlock()


func _post(_caller):
	semaphore.post()


func _wait(_caller):
	semaphore.wait()


func queue_resource(path, p_in_front = false):
	_lock("queue_resource")
	var statu =	ResourceLoader.load_threaded_get_status(path,progress)
	if statu == ResourceLoader.THREAD_LOAD_IN_PROGRESS:
		_unlock("queue_resource")
		return
	elif statu == ResourceLoader.THREAD_LOAD_LOADED:
		var res = ResourceLoader.load_threaded_get(path)
	elif statu == ResourceLoader.THREAD_LOAD_INVALID_RESOURCE:
		var ok = ResourceLoader.load_threaded_request(path)
		if ok == 0 :
			progress[path] = []
			if p_in_front:
				queue.insert(0, path)
			else:
				queue.push_back(path)
			_post("queue_resource")
			_unlock("queue_resource")
		else:
			assert(false, "ResourceLoader.load_threaded_request error:"+ok)


func cancel_resource(path):
	_lock("cancel_resource")
	var statu =	ResourceLoader.load_threaded_get_status(path,progress)
	if statu == ResourceLoader.THREAD_LOAD_IN_PROGRESS:
		queue.erase(path)
	_unlock("cancel_resource")


func get_progress(path):
	_lock("get_progress")
	var ret = -1
	var statu =	ResourceLoader.load_threaded_get_status(path,progress)
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
	var statu =	ResourceLoader.load_threaded_get_status(path,progress)
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
	var statu =	ResourceLoader.load_threaded_get_status(path,progress)
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
		var res = queue[0]
		_unlock("process_poll")
		var ret = res.poll()
		_lock("process_check_queue")

		if ret == ERR_FILE_EOF || ret != OK:
			var path = res.get_meta("path")
			if path in pending: # Else, it was already retrieved.
				pending[res.get_meta("path")] = res.get_resource()
			# Something might have been put at the front of the queue while
			# we polled, so use erase instead of remove.
			queue.erase(res)
	_unlock("process")


func thread_func(_u):
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
	thread.start(self, "thread_func", 0)

# Triggered by calling "get_tree().quit()".
func _exit_tree():
	mutex.lock()
	exit_thread = true # Protect with Mutex.
	mutex.unlock()

	# Unblock by posting.
	semaphore.post()

	# Wait until it exits.
	thread.wait_to_finish()
