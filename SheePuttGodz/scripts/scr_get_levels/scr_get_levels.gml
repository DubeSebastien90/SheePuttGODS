function get_levels() {
    var level_data = [
      [
          "~~~~~~~~~~~~~~~~",
          "~~~~~~~~~~~~~~~~",
          "~~~~.......~~~~~",
          "~~~...m.m...~~~~",
          "~~.....m.....~~~",
          "~~....m.m....~~~",
          "~~...........~~~",
          "~~~~~~~~~~~~~~~~",
          "~~...........~~~",
          "~~...........~~~",
          "~~...........~~~",
          "~~...........~~~",
          "~~~eeeeeeeee~~~~",
          "~~~~eeeeeee~~~~~",
          "~~~~~~~~~~~~~~~~",
          "~~~~~~~~~~~~~~~~",
      ],
      [
          "~~~~~~~~~~~~~~~~",
          "~..........~~~~~",
          "~.mm.......~~~~~",
          "~.mm.......~~~~~",
          "~..........~~~~~",
          "~..........~~~~~",
          "~~~~~~.....~~~~~",
          "~~~~~~.....~~~~~",
          "~~~~~~.....~~~~~",
          "~~~~~~.....~~~~~",
          "~~~~~~.....~~~~~",
          "~~~~~~~~~~.....~",
          "~~~~~~~~~~..ee.~",
          "~~~~~~~~~~..ee.~",
          "~~~~~~~~~~.....~",
          "~~~~~~~~~~~~~~~~",
      ],
      [
          "~~~~~~~~~~~~~~~~",
          "~~~~~~~~~~~~~~~~",
          "~~.........~~~~~",
          "~~.........~~~~~",
          "~~...~~.~~..~~~~",
          "~~...~eeeee~~~~~",
          "~~...~eeeee~~~~~",
          "~~...~~.~~..~~~~",
          "~~.........~~~~~",
          "~~.........~~~~~",
          "~~.........~~~~~",
          "~~.....m...~~~~~",
          "~~~...m.m...~~~~",
          "~~~~.......~~~~~",
          "~~~~~~~~~~~~~~~~",
          "~~~~~~~~~~~~~~~~",
      ],
    ];
    
    return level_data;
}

function get_level_conditions(level_index){
	var conditions = [
	{muttons_for_win: 1},
	{muttons_for_win: 2},
	{muttons_for_win: 1},
]

return conditions[level_index]
}

function _build_level(_level_data){
    var levels = [];
    
    for (var idx = 0; idx < 1; idx++) {
        var rows = _level_data[idx];
        var lh   = array_length(rows);
        var lw   = string_length(rows[0]);
        
        var _grid = ds_grid_create(lw, lh);
        
        for (var j = 0; j < lh; j++) {
            var row = rows[j];
            for (var i = 0; i < lw; i++) {
                var c = string_char_at(row, i + 1);
                var val = _map_character(c);
				if c = "m"{
					val = 1
					var mutton_pos = obj_grid.game_pos_to_room_pos(i,j)
					instance_create_layer(mutton_pos.x,mutton_pos.y,"Instances",obj_mutton)
				}
				if c = "e"{
					val = 1
					var end_gate_pos = obj_grid.game_pos_to_room_pos(i,j)
					with(instance_create_layer(end_gate_pos.x,end_gate_pos.y,"dessous",obj_end_gate)){
						tile_i = i
						tile_j = j
					}
				}
                ds_grid_set(_grid, i, j, val);
            }
        }
        
        var _tiles_idx = ds_grid_create(lw, lh);
        ds_grid_copy(_tiles_idx, _grid);
        
        var _decos_idx = ds_grid_create(lw, lh);
        
        for (var j = lh - 1; j >= 0; j--) {
            for (var i = lw - 1; i >= 0; i--) {
                var value = ds_grid_get(_tiles_idx, i, j)
                if value == 0 continue;
                    
                var deco = random_range(0, 1);
                if deco > 0.95 {
                    deco = choose(1, 2, 3);
                    deco += (value - 1) * 3
                } else deco = 0;
                ds_grid_set(_decos_idx, i, j, deco);
                    
                ds_grid_set(_tiles_idx, i, j, _map_sprite_idx(ds_grid_get(_tiles_idx, i, j)));
                    
                if (j == 0) {
                    ds_grid_set(_tiles_idx, i, j, ds_grid_get(_tiles_idx, i, j) + 2);
                } else if (value != ds_grid_get(_grid, i, j - 1)) {
                    ds_grid_set(_tiles_idx, i, j, ds_grid_get(_tiles_idx, i, j) + 2);
                }
                
                if (i == 0) {
                    ds_grid_set(_tiles_idx, i, j, ds_grid_get(_tiles_idx, i, j) + 1);
                } else if (value != ds_grid_get(_grid, i - 1, j)) {
                    ds_grid_set(_tiles_idx, i, j, ds_grid_get(_tiles_idx, i, j) + 1);
                }
            }
        }
        
        levels[idx] = { grid: _grid, tiles_idx: _tiles_idx, decos_idx: _decos_idx, width: lw, height: lh };
    }
    
    return levels[0]
}

function _map_character(c) {
    switch (c) {
        case "=": return 0;
        case ".": return 1;
        case "~": return 2;
        default:  return 0;
    }
}

function _map_sprite_idx(n) {
    return max((n - 1) * 4 + 1, 0)
}
