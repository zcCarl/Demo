extends ScrollContainer
class_name InfiniteScrollContainer
const ITEM_HEIGHT = 40
@onready var content:Control = $content
var item_to_index = {}
var item_to_remove = []
var total_items = 0
var start_index = 0
var end_index = 0
var start_page = 0
var end_page = 0
var content_size = 0
var datas:Array[InfiniteScrollContainerItem.InfiniteScrollContainerItemData] = []
var page:Array = []
var page_height:Array[float] = []
const PAGE_DATA_SIZE = 10
var content_pos = 0
@export var template:PackedScene = null

func _ready():
	get_v_scroll_bar().connect("value_changed",_on_VScrollBar_value_changed)
	total_items = 100
	for i in total_items:
		var data = InfiniteScrollContainerItem.InfiniteScrollContainerItemData.new(i,40,{}) 
		datas.append(data)
		
	set_datas(datas)
	
func _on_VScrollBar_value_changed(value:float):
	content_pos = value
	update_visible_items(value)
	
func set_datas(datas:Array[InfiniteScrollContainerItem.InfiniteScrollContainerItemData]):
	var current = 0
	content_size = 0
	for data in datas:
		if page.size() <= current:
			page.append([])
			page_height.append(0)
		if page[current].size() == PAGE_DATA_SIZE:
			current += 1
			page.append([])
			page_height.append(0)
		page[current].append(data)
		page_height[current] += data._item_height
		content_size += data._item_height
	content.custom_minimum_size = Vector2(get_rect().size.x,content_size)
	start_index = 0
	start_page = 0
	end_page = 0
	update_visible_items(content_pos)
	
func create_item():
	var item = template.instantiate() as InfiniteScrollContainerItem
	content.add_child(item)
	return item

func update_visible_items(value):
	var t = 0
	for p_index in page_height.size():
		if t + page_height[p_index] < value :
			t += page_height[p_index]
		else:
			#print(p_index)
			start_page = p_index
			for i in page[start_page].size():
				if t + page[start_page][i]._item_height < value:
					t += page[start_page][i]._item_height
				else:
					start_index = i
					break
			break
	end_index = start_index
	end_page = start_page
	
	
	var visible_count = 0
	while t < value + get_rect().size.y:
		#print(t + page[end_page][end_index]._item_height," --- " ,value + get_rect().size.y)
		#print(end_index ,"~~~~", page[end_page].size())
		if end_index < page[end_page].size():
			t += page[end_page][end_index]._item_height
			
			if end_index+1 >= page[end_page].size():
				if end_page + 1 < page.size():
					end_page += 1
					end_index = 0
			else:
				end_index += 1
		else :
			if end_page + 1 < page.size():
				end_page += 1
				end_index = 0
			else:
				break
				
	print(start_page," ",start_index," " , end_page," ",end_index)
	var show_items = []
	var pos = {}
	var h = value
	if start_page == end_page:
		for i in range(start_index,end_index+1):
			var data = page[start_page][i]
			show_items.append(data._item_index)
			pos[start_page*PAGE_DATA_SIZE+i] = h
			h += data._item_height 
			#print(start_page,"++++",i)
	else:
		for p in range(start_page,end_page + 1):
			var data:InfiniteScrollContainerItem.InfiniteScrollContainerItemData = null
			if p == start_page:
				for i in range(start_index,page[p].size()):
					data = page[p][i]
					show_items.append(data._item_index)
					pos[p*PAGE_DATA_SIZE+i] = h
					h += data._item_height 
					#print(p,"++++",i)
			elif p == end_page:
				for i in range(0,end_index+1):
					data = page[p][i]
					show_items.append(data._item_index)
					pos[p*PAGE_DATA_SIZE+i] = h
					h += data._item_height
					#print(p,"++++",i) 
			else:
				for i in range(0,page[p].size()):
					data = page[p][i]
					show_items.append(data._item_index)
					pos[p*PAGE_DATA_SIZE+i] = h
					h += data._item_height 
					#print(p,"++++",i)
	print(show_items)
	print(pos)
	
	for i in pos:
		if !item_to_index.has(i):
			for index in item_to_index:
				if index < start_page*PAGE_DATA_SIZE+ start_index or index >= end_page*PAGE_DATA_SIZE+end_index:
					item_to_index[index].visible = false
					item_to_remove.append(item_to_index[index]) 
					item_to_index.erase(index)
			if item_to_remove.size()>0:
				item_to_index[i] = item_to_remove.pop_back()
				item_to_index[i].visible = true
			else:
				item_to_index[i] = create_item()
		
		var data = page[i/PAGE_DATA_SIZE][i%PAGE_DATA_SIZE]
		print(i,",,,",pos[i],",,,",data)
		item_to_index[i].set_data(data)
		item_to_index[i].size = Vector2(get_rect().size.x,data._item_height)
		item_to_index[i].position = Vector2(0,pos[i])
