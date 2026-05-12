if keyboard_check(vk_anykey){
	room_goto(Room1)
}

if debug_mode {
    if keyboard_check(vk_enter){
        room_goto(LevelEditor)
    }
}