
image_angle += angle_speed*angle_side

vspd += grav

x += dcos(dir)*spd + draggedX
y -= dsin(dir)*spd 
y += vspd + draggedY

life -= 1
if life < 0{
	image_alpha = lerp(image_alpha,0,0.1)
	if image_alpha < 0.1{
		instance_destroy()
	}
}

draggedX = lerp(draggedX,0,0.02)
draggedY = lerp(draggedY,0,0.02)