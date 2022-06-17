extends PanelContainer

var fps := 0.0
var draw_calls := 0.0
var process := 0.0
var physics := 0.0

var info := "FPS: %d
Draw calls: %s
Process: %.3fms
Physics: %.3fms"

@onready var output: Label = $OutputLabel

func _process(_delta: float) -> void:
	fps = Performance.get_monitor(Performance.TIME_FPS)
	draw_calls = Performance.get_monitor(Performance.RENDER_TOTAL_DRAW_CALLS_IN_FRAME)
	process = Performance.get_monitor(Performance.TIME_PROCESS) * 1000
	physics = Performance.get_monitor(Performance.TIME_PHYSICS_PROCESS) * 1000
	
	output.text = info % [fps, draw_calls, process, physics]
