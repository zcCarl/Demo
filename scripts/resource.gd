extends Node

class load_async_res:
	signal completed
	signal progress

var loading = {}
var force_cache = false
var progress = {}
var _cache = {}

func load_async(path:String):
	if force_cache :
		if _cache[path]:
			pass
	else:
		if !loading.has(path):
			ResourceLoader.load_threaded_request(path)
			var r = load_async_res.new()
			loading[path] = r
			progress[path] = []
			return r
		return loading[path]
		
func _process(delta):
	var del = []
	for k in loading :
		var statu = ResourceLoader.load_threaded_get_status(k,progress[k])
		if statu == ResourceLoader.THREAD_LOAD_LOADED:
			var res = ResourceLoader.load_threaded_get(k)
			loading[k].progress.emit(1)
			loading[k].completed.emit(res)
			del.append(k)
			if force_cache :
				_cache[k] = res
		elif statu == ResourceLoader.THREAD_LOAD_IN_PROGRESS:
			loading[k].progress.emit(progress[k][0])
		else:
			printerr("load error: " + k)
			loading.completed.emit(null)
	for d in del:
		loading.erase(d)
		progress.erase(d)
