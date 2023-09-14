extends ParallaxBackground

var SCROLLING_SPEED = 300

func _process(delta):
	scroll_offset.y -= -SCROLLING_SPEED * delta
	if scroll_offset.y >= 1275:
		scroll_offset.y = 0
