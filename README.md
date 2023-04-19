# Bibliodot

*(pronounced bilbio-doe)*  

Bibliodot is a simple package for creating in-game books by turning a text file into a series of strings fit for Rich Text Label, complete with embedded GDScript.  

## How to use

### Quickstart

1. Install the addon by dragging it into your `addons` folder and enabling it in your project settings.
2. Read a file of your book template, and pass in the string to `Bibliodot.render_book()`. `Bibliodot` is an autoload singleton.  
3. You have an array of strings now. Every string is a new page!

## Writing books

### Basics

Writing books is easy! All you need to do is write your book as if it was going to appear in a Rich Text Label, with BBcode or otherwise.  
To mark a new page, simply add `---` to the bottom of your page.  
Pass in your unparsed string to `Bibliodot.render_book()`, and you'll get each page out as a new string!  
Note that tags will not persist past page boundaries.

### Inline GDScript

Bibliodot also has the very powerful feature of allowing inline GDScript, allowing you to, say, insert the player's name into a letter. Any gdscript string (marked like {{my script}}) will be replaced with the resulting value.  
You can use inline GDScript 2 ways:
1. The Simple Way

```
{{1 + 2}}
```  
This script will be replaced with the result of the expression, `3`. Under the hood, it is turned into a function with the body `return 1 + 2`, so keep that in mind.  

2. The Advanced Way

If you want to write a whole script without having to write it all inline, simply add a % sign at the beginning of the script:  
```
{{%if foo: 
	return 'blah'
else:
	return "beep"
}}
```
This will be replaced with the result of this script. Under the hood, it is turned into a function with the text as the body verbatim. make youre your indentation is proper.  

#### Other info

- You can pass in arguments via the second argument of `Bibliodot.render_book()` as an array of values. You can access them by `args[i]` in your script - they are passed in the same order.
- Creating a function that has no result will simply replace the script with an empty string. Perhaps you could use this to your advantage by calling events in your game when the book renders?
