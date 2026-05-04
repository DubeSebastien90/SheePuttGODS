cam = view_camera[0]; 
follow = self; 
xTo = room_width/2; 
yTo = room_height/2;
x = xTo
y = yTo
shake_lenght = 0; 
shake_magnitude = 6; 
shake_remain = 6;
camH = camera_get_view_height(cam)
camW =camera_get_view_width(cam)

windowH = window_get_height()
windowW = window_get_width()

zoom_dir = 0.7
zoom_ammount = 0.7
zoom_lerp = 0.2

offsetX = 0
offsetY = 0

initialDragX = 0
initialDragY = 0