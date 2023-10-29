class_name WeightedTable

class Entry:
	var item: Variant
	var weight: int
	func _init(i: Variant, w: int):
		self.item = i
		self.weight = w
	
var items: Array[Entry] = []
var weight_sum: int = 0


func add_item(item: Variant, weight: int):
	items.append(Entry.new(item, weight))
	weight_sum += weight


func remove_item(item_to_remove: Variant):
	items = items.filter(func(item): return item_to_remove != item.item)
	weight_sum = 0
	for item in items:
		weight_sum += item.weight


func pick_item(exclude: Array = []):
	var adjusted_items: Array[Entry] = items
	var adjusted_weight_sum = weight_sum
	
	if exclude.size() > 0:
		adjusted_items = []
		adjusted_weight_sum = 0
		for item in items:
			if item.item in exclude:
				continue
			adjusted_items.append(item)
			adjusted_weight_sum += item.weight
		
	var chosen_weight = randi_range(1, adjusted_weight_sum)
	var iteration_sum = 0
	for item in adjusted_items:
		iteration_sum += item.weight
		if chosen_weight <= iteration_sum:
			return item.item
