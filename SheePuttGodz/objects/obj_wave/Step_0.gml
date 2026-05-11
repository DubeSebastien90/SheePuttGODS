scale += 0.05

image_xscale = scale
image_yscale = scale

image_alpha  = 1 - (scale / size_max)


if size_max <= scale{
	instance_destroy()
	image_alpha = lerp(image_alpha,0,0.2)
	if image_alpha < 0.01{
		instance_destroy()
	}
}