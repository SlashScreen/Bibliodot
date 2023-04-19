class_name Book
extends Resource
## A resource containing a book's pages.


var pages:PackedStringArray


func _init(new_pages:Array[String]) -> void:
	pages = PackedStringArray(new_pages)
