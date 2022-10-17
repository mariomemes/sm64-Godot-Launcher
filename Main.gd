extends Control

func _ready():
	$RomSelector.popup()

func _on_Build_pressed():
	$Build.disabled = true
	OS.execute("git", ["clone", "https://github.com/MorsGames/sm64plus.git"], true)
	OS.execute("cp", [$RomSelector.get_current_path(), "sm64plus"], true)
	OS.execute("make", ["-C", "sm64plus"], true)
	$Build.disabled = false

func _on_Launch_pressed():
	$Launch.disabled = true
	OS.execute("./sm64plus/build/us_pc/sm64.us.f3dex2e", [], false)
	OS.kill(OS.get_process_id())

func _on_RomSelector_popup_hide():
	if $RomSelector.get_current_file() == "":
		$RomSelector.popup()
