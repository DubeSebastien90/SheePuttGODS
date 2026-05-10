global.level_data = [
      [
          "~~~~~~~~~~~~~~~~~~~~~~~~",
          "~~~~~~~~~~~~~~~~~~~~~~~~",
          "~~~~~~~~~~~~~~~~~~~~~~~~",
          "~~~~~~~~~~~~~~~~~~~~~~~~",
          "~~~~~~~~~~~~~~~~~~~~~~~~",
          "~~~~~~~~~~~~~~~~~~~~~~~~",
          "~~~~~~~.......~~~~~~~~~~",
          "~~~~~~...m.m...~~~~~~~~~",
          "~~~~~.....m.....~~~~~~~~",
          "~~~~~....m.m....~~~~~~~~",
          "~~~~~...........~~~~~~~~",
          "~~~~~~~~~~~~~~~~~~~~~~~~",
          "~~~~~...........~~~~~~~~",
          "~~~~~...........~~~~~~~~",
          "~~~~~...........~~~~~~~~",
          "~~~~~...........~~~~~~~~",
          "~~~~~~~eeeeeeeee~~~~~~~~",
          "~~~~~~~~eeeeeee~~~~~~~~~",
          "~~~~~~~~~~~~~~~~~~~~~~~~",
          "~~~~~~~~~~~~~~~~~~~~~~~~",
          "~~~~~~~~~~~~~~~~~~~~~~~~",
          "~~~~~~~~~~~~~~~~~~~~~~~~",
          "~~~~~~~~~~~~~~~~~~~~~~~~",
          "~~~~~~~~~~~~~~~~~~~~~~~~",
      ],
      [
          "~~~~~~~~~~~~~~~~~~~~~~~~",
          "~~~~~~~~~~~~~~~~~~~~~~~~",
          "~~~~~~~~~~~~~~~~~~~~~~~~",
          "~~~~~~~~~~~~~~~~~~~~~~~~",
          "~~~~~..........~~~~~~~~~",
          "~~~~~.mm.......~~~~~~~~~",
          "~~~~~.mm.......~~~~~~~~~",
          "~~~~~..........~~~~~~~~~",
          "~~~~~..........~~~~~~~~~",
          "~~~~~~~~~~.....~~~~~~~~~",
          "~~~~~~~~~~.....~~~~~~~~~",
          "~~~~~~~~~~.....~~~~~~~~~",
          "~~~~~~~~~~.....~~~~~~~~~",
          "~~~~~~~~~~.....~~~~~~~~~",
          "~~~~~~~~~~~~~~.....~~~~~",
          "~~~~~~~~~~~~~~..ee.~~~~~",
          "~~~~~~~~~~~~~~..ee.~~~~~",
          "~~~~~~~~~~~~~~.....~~~~~",
          "~~~~~~~~~~~~~~~~~~~~~~~~",
          "~~~~~~~~~~~~~~~~~~~~~~~~",
          "~~~~~~~~~~~~~~~~~~~~~~~~",
          "~~~~~~~~~~~~~~~~~~~~~~~~",
          "~~~~~~~~~~~~~~~~~~~~~~~~",
          "~~~~~~~~~~~~~~~~~~~~~~~~",
      ],
      [
          "~~~~~~~~~~~~~~~~~~~~~~~~",
          "~~~~~~~~~~~~~~~~~~~~~~~~",
          "~~~~~~~~~~~~~~~~~~~~~~~~",
          "~~~~~~~~~~~~~~~~~~~~~~~~",
          "~~~~~~~~~~~~~~~~~~~~~~~~",
          "~~~~~~~~~~~~~~~~~~~~~~~~",
          "~~~~~~.........~~~~~~~~~",
          "~~~~~~.........~~~~~~~~~",
          "~~~~~~...~~.~~..~~~~~~~~",
          "~~~~~~...~eeeee~~~~~~~~~",
          "~~~~~~...~eeeee~~~~~~~~~",
          "~~~~~~...~~.~~..~~~~~~~~",
          "~~~~~~.........~~~~~~~~~",
          "~~~~~~.........~~~~~~~~~",
          "~~~~~~.........~~~~~~~~~",
          "~~~~~~.....m...~~~~~~~~~",
          "~~~~~~~...m.m...~~~~~~~~",
          "~~~~~~~~.......~~~~~~~~~",
          "~~~~~~~~~~~~~~~~~~~~~~~~",
          "~~~~~~~~~~~~~~~~~~~~~~~~",
          "~~~~~~~~~~~~~~~~~~~~~~~~",
          "~~~~~~~~~~~~~~~~~~~~~~~~",
          "~~~~~~~~~~~~~~~~~~~~~~~~",
          "~~~~~~~~~~~~~~~~~~~~~~~~",
      ],
    ];
function get_levels() {
    return global.level_data;
}


global.conditions = [
	{
		muttons_for_win: 1,
		muttons_total: 5,
		first_star: 
		{
			collected: false,
			description: "Bring all sheeps to the end"
		},
		second_star: 
		{
			collected: false,
			description: "Finish the level in only 6 stomps"
		},
		third_star: 
		{
			collected: false,
			description: "Stomp every sheep"
		}
	},
	{muttons_for_win: 1},
	{muttons_for_win: 1},
]

function get_level_conditions(level_index){
	return global.conditions[level_index]
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
        
        var _tiles = ds_grid_create(lw, lh);
        var _decos_s = ds_grid_create(lw, lh);
        var _decos_d = ds_grid_create(lw, lh);
        
        var null_value = {val:0, x:-1, y:-1};
        
        for (var j = lh - 1; j >= 0; j--) {
            for (var i = lw - 1; i >= 0; i--) {
                var tile = ds_grid_get(_grid, i, j)
                if tile == 0 {
                    ds_grid_set(_tiles, i, j, null_value);
                    ds_grid_set(_decos_s, i, j, null_value);
                    ds_grid_set(_decos_d, i, j, null_value);
                    continue;
                }
                
                var r_pos = obj_grid.game_pos_to_room_pos(i, j);
                
                //Decorations position and sprite
                var deco_val = 0;
                if random_range(0, 1) > 0.95 {
                    deco_val = choose(1, 2, 3);
                    deco_val += (tile - 1) * 3
                }
                var _g = tile == 1 ? _decos_d : _decos_s;
                var _i = tile == 1 ? _decos_s : _decos_d;
                ds_grid_set(_g, i, j, {val:deco_val, x:r_pos.x-2, y: r_pos.y+9});
                ds_grid_set(_i, i, j, null_value);
                    
                //Tiles position and sprite
                var tile_val = _map_sprite_idx(tile);
                if (j == 0) tile_val += 2;
                else if (tile != ds_grid_get(_grid, i, j-1)) tile_val += 2;
                    
                if (i == 0) tile_val += 1;
                else if (tile != ds_grid_get(_grid, i-1, j)) tile_val += 1;
                    
                ds_grid_set(_tiles, i, j, {val:tile_val, x:r_pos.x, y:r_pos.y});
            }
        }
        
        levels[idx] = {
            grid: _grid,
            tiles: _tiles,
            decos_s: _decos_s,
            decos_d: _decos_d,
            width: lw,
            height: lh 
        };
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
