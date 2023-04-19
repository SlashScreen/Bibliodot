@tool
extends EditorPlugin


func _enter_tree() -> void:
	add_autoload_singleton("Bibliodot", "res://addons/bibliodot/book_render.gd")


func _exit_tree() -> void:
	remove_autoload_singleton("Bibliodot")
