if keyboard_check(vk_anykey) || mouse_check_button(mb_any){
	room_goto(Room1)
}

if debug_mode {
    if keyboard_check(vk_enter){
        room_goto(LevelEditor)
    }
}