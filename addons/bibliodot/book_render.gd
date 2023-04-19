extends Node


var regex = RegEx.new()


func _ready() -> void:
	regex.compile("\\{\\{(?'flag'%?)(?'code'(.|\\R)*?)\\}\\}")
	# test string: "hello {{%return 1+2}}!---This is a {{\"different\" if false else \"cool\"}} page."


## Renders a raw string into a [Book] resource.
func render_book(raw:String, args:Array = []) -> Array[String]:
	# STEP 1: Expression Executing
	
	var split_raw = []
	var current_end:int = 0
	var res_script = GDScript.new()
	
	for res in regex.search_all(raw):
		split_raw.append(raw.substr(current_end, res.get_start() - current_end)) # append between matches
		
		current_end = res.get_end() # set current end
		var raw_gd = res.get_string("code").strip_escapes() # get string match
		# apply script to script
		res_script.source_code = "func eval(args:Array):\n\t%s%s" % ["return" if res.get_string("flag") == "" else "", raw_gd.strip_edges(true, false)]
		res_script.reload()
		var obj = RefCounted.new()
		obj.set_script(res_script)
		# eval
		var exp_res = obj.eval(args)
		# remove script
		obj.set_script(null)
		
		if not exp_res == null:
			split_raw.append(exp_res)
		
	## append last match to end
	split_raw.append(raw.substr(current_end))
	
	# STEP 2: Split Pages
	
	var templated = "".join(split_raw) # join split raw
	var pages = templated.split("---") # split by page separator
	return pages 
