extends Node
## Persisted to user://settings.cfg.

const PATH := "user://settings.cfg"

var resolution_scale: float = 1.0
var psx_mode: bool = true
var master_volume_db: float = 0.0


func save_settings() -> void:
	var cfg := ConfigFile.new()
	cfg.set_value("graphics", "resolution_scale", resolution_scale)
	cfg.set_value("graphics", "psx_mode", psx_mode)
	cfg.set_value("audio", "master_volume_db", master_volume_db)
	cfg.save(PATH)


func load_settings() -> void:
	var cfg := ConfigFile.new()
	if cfg.load(PATH) != OK:
		return
	resolution_scale = cfg.get_value("graphics", "resolution_scale", resolution_scale)
	psx_mode = cfg.get_value("graphics", "psx_mode", psx_mode)
	master_volume_db = cfg.get_value("audio", "master_volume_db", master_volume_db)


func _ready() -> void:
	load_settings()
