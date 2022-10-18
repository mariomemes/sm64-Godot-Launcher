extends Control

var project = "sm64-port"
var repo = "https://github.com/sm64-port/sm64-port.git"

func _on_Build_pressed():
	$Build.disabled = true
	OS.execute("git", ["clone", repo], true)
	OS.execute("mv", [$RomSelector.get_current_path(), project + "/baserom.us.z64"], true)
	OS.execute("make", ["-C", project], true)
	$Build.disabled = false

func _on_Launch_pressed():
	$Launch.disabled = true
	OS.execute("./" + project + "/build/us_pc/sm64.us.f3dex2e", [], false)
	OS.execute("./" + project + "/build/us_pc/sm64.us", [], false)
	OS.kill(OS.get_process_id())

func _on_RomSelector_popup_hide():
	if $RomSelector.get_current_file() == "":
		$RomSelector.popup()
	else:
		$SelectROM.disabled = true
		$SelectROM.visible = false
		$Build.visible = true
		$Build.disabled = false

func _on_SelectROM_pressed():
	$RomSelector.popup()

func _on_OptionButton_item_selected(index):
	if $Project.selected == 0:
		$Label.text = "sm64-port Godot Launcher"
		project = "sm64-port"
		repo = "https://github.com/sm64-port/sm64-port.git"
	if $Project.selected == 1:
		$Label.text = "sm64plus Godot Launcher"
		project = "sm64plus"
		repo = "https://github.com/MorsGames/sm64plus.git"
	if $Project.selected == 2:
		$Label.text = "sm64ex Godot Launcher"
		project = "sm64ex"
		repo = "https://github.com/sm64pc/sm64ex.git"
	if $Project.selected == 3:
		$Label.text = "sm64ex-alo Godot Launcher"
		project = "sm64ex-alo"
		repo = "https://github.com/AloXado320/sm64ex-alo.git"

func _on_Exit_pressed():
	OS.kill(OS.get_process_id())
