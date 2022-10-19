extends Node
# Modified version of settings.gd from 3D Voxel Demo
var selected = 3
var _save_path = "user://selected.json"
var _loaded = false

func _enter_tree():
	if Selected._loaded:
		printerr("Error: Selected is an AutoLoad singleton and it shouldn't be instanced elsewhere.")
		printerr("Please delete the instance at: " + String(get_path()))
	else:
		Selected._loaded = true

	var file = File.new()
	if file.file_exists(_save_path):
		file.open(_save_path, File.READ)
		while file.get_position() < file.get_len():
			# Get the saved dictionary from the next line in the save file
			var data = parse_json(file.get_line())
			selected = data["selected"]
		file.close()
	else:
		save_selected()


func save_selected():
	var file = File.new()
	file.open(_save_path, File.WRITE)
	var data = {
		"selected": selected,
	}
	file.store_line(to_json(data))
	file.close()
