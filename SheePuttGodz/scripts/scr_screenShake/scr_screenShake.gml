
function screenShake(_magnitude, _length){

with (obj_camera)
{
	if (_magnitude > shake_remain)
	{
		shake_magnitude = _magnitude;
		shake_remain = _magnitude;
		shake_lenght = _length;
	}
}

}