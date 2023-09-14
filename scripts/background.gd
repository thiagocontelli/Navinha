extends ParallaxBackground

var SCROLLING_SPEED = 300

func _process(delta):
	scroll_offset.y -= -SCROLLING_SPEED * delta
