global.level_data = [
        [
          "~~~~~~~~~~~~~~~~",
          "~~~~~~~~~~~~~ww~",
          "~~~~.......~~~~~",
          "~~~...m.m...~~~~",
          "~~.....m.....~~~",
          "~~....m.m....~~~",
          "~~...........~~~",
          "~~~~~~~~~~~~~~~~",
          "~~...........~~~",
          "~~...........~~~",
          "~~.....e....~~~",
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
          "~~...bbb...~~~~~",
          "~~.........~~~~~",
          "~~.....m...~~~~~",
          "~~~...m.m...~~~~",
          "~~~~.......~~~~~",
          "~~~~~~~~~~~~~~~~",
          "~~~~~~~~~~~~~~~~",
        ], 
        [
         "~~~~~~~~~~~~~~~~",
         "~~~~~~~~~~~~~~~~",
         "~~~~........~~~~",
         "~~~~..eeee..~~~~",
         "~~~~........~~~~",
         "~~~~........~~~~",
         "~~~~...~~...~~~~",
         "~~~~..bbbb..~~~~",
         "~~~~..bbbb..~~~~",
         "~~....bbbb....~~",
         "~~.m..bbbb..m.~~",
         "~~............~~",
         "~~~~........~~~~",
         "~~~~........~~~~",
         "~~~~~~~~~~~~~~~~",
         "~~~~~~~~~~~~~~~~",
        ],
        [
        "bbbbbbbbbbbbbbbb",
        "b..b..eeee...b.b",
        "b..b........bbbb",
        "bbbb........bb.b",
        "b....bb..bb....b",
        "b....bb..bb....b",
        "b.....m..m.....b",
        "b..............b",
        "b.....m..m.....b",
        "b..............b",
        "b....bb...b....b",
        "b....bb..b.b...b",
        "b.bb......b.bb.b",
        "b.bb..v.....bb.b",
        "b.....eeee.....b",
        "bbbbbbbbbbbbbbbb",
        ]
    ];
function get_levels() {
    return global.level_data;
}


global.conditions = [
	{
		level_title: "custom level name",
		muttons_for_win: 3,
		muttons_total: 5,
		first_star: 
		{
			collected: false,
			description: "Bring all sheeps to the end"
		},
		second_star: 
		{
			collected: false,
			description: "Finish the level in only 6 stomps",
			nbStomps: 6
		},
		third_star: 
		{
			collected: false,
			description: "Finish in under 10 seconds",
			nbSeconds: 10
		}
	},
	{
		level_title: "custom level name",
		muttons_for_win: 2,
		muttons_total: 4,
		first_star: 
		{
			collected: false,
			description: "Bring all sheeps to the end"
		},
		second_star: 
		{
			collected: false,
			description: "Finish the level in only 6 stomps",
			nbStomps: 6
		},
		third_star: 
		{
			collected: false,
			description: "Finish in under 10 seconds",
			nbSeconds: 10
		}
	},
	{level_title: "custom level name", muttons_for_win: 1},
	{level_title: "custom level name", muttons_for_win: 1},
	{level_title: "custom level name", muttons_for_win: 1},
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
        var _mp_grid = mp_grid_create(0, 0, lw, lh, 1, 1);
        
        var _grid      = ds_grid_create(lw, lh);
        var _gate_grid = ds_grid_create(lw, lh);
        ds_grid_clear(_gate_grid, false);
        
        var _entities = [];

        for (var j = 0; j < lh; j++) {
            var row = rows[j];
            for (var i = 0; i < lw; i++) {
                var c = string_char_at(row, i + 1);
                var val = _map_character(c);
                
                if (c == "m") {
                    val = 1;
                    array_push(_entities, { type: obj_mutton, i: i, j: j });
                }
                else if (c == "e") {
                    val = 1;
                    ds_grid_set(_gate_grid, i, j, true);
                    array_push(_entities, { type: obj_end_gate, i: i, j: j, is_water: false });
                }
                else if (c == "w") {
                    val = 2;
                    ds_grid_set(_gate_grid, i, j, true);
                    array_push(_entities, { type: obj_end_gate, i: i, j: j, is_water: true });
                }
                else if (c == "b") {
                    val = 1;
                    mp_grid_add_cell(_mp_grid, i, j);
                    array_push(_entities, { type: obj_bumper, i: i, j: j });
                }
                else if (c == "v") {
                    val = 1;
                    array_push(_entities, { type: obj_wolf, i: i, j: j });
                }
                
                ds_grid_set(_grid, i, j, val);
            }
        }

        with (obj_end_gate) {
            var gi = tile_i;
            var gj = tile_j;
            var _n = (gj > 0)      && ds_grid_get(_gate_grid, gi,   gj-1);
            var _e = (gi < lw-1)   && ds_grid_get(_gate_grid, gi+1, gj);
            var _s = (gj < lh-1)   && ds_grid_get(_gate_grid, gi,   gj+1);
            var _w = (gi > 0)      && ds_grid_get(_gate_grid, gi-1, gj);
            image_index = _gate_sprite_idx(_n, _e, _s, _w);
        }
        ds_grid_destroy(_gate_grid);
        
        var _tiles = ds_grid_create(lw, lh);
        var _decos_s = ds_grid_create(lw, lh);
        var _decos_d = ds_grid_create(lw, lh);
        
        var null_value = {val:0, x:-1, y:-1};
        
        for (var j = lh - 1; j >= 0; j--) {
            for (var i = lw - 1; i >= 0; i--) {
                var tile = ds_grid_get(_grid, i, j)
                if tile == 0 {
                    mp_grid_add_cell(_mp_grid, i, j);
                    ds_grid_set(_tiles, i, j, null_value);
                    ds_grid_set(_decos_s, i, j, null_value);
                    ds_grid_set(_decos_d, i, j, null_value);
                    continue;
                }
                if tile == 2 mp_grid_add_cell(_mp_grid, i, j);
                
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
            height: lh,
            mp_grid: _mp_grid,
            entities: _entities
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

function _gate_sprite_idx(n, e, s, w) {
    // N=1 (upper-right), E=2 (lower-right), S=4 (lower-left), W=8 (upper-left)
    var mask = (n ? 1 : 0) | (e ? 2 : 0) | (s ? 4 : 0) | (w ? 8 : 0);
    switch (mask) {
        case 0:  return 0;   // isolated
        case 15: return 1;   // all sides
        // Corners (2 adjacent connections)
        case 6:  return 2;   // E+S   → top corner
        case 3:  return 3;   // N+E   → left corner
        case 9:  return 4;   // N+W   → bottom corner
        case 12: return 5;   // S+W   → right corner
        // Edges (3 connections, 1 open side)
        case 7:  return 6;   // N+E+S → top-left edge    (W open)
        case 14: return 7;   // E+S+W → top-right edge   (N open)
        case 11: return 8;   // N+E+W → bottom-left edge (S open)
        case 13: return 9;   // N+S+W → bottom-right edge (E open)
        // Corridors (2 opposite connections)
        case 5:  return 10;  // N+S   → corridor lower-left ↔ upper-right
        case 10: return 11;  // E+W   → corridor upper-left ↔ lower-right
        // Endpoints (1 connection only)
        case 4:  return 12;  // S only → lower-left
        case 8:  return 13;  // W only → upper-left
        case 1:  return 14;  // N only → upper-right
        case 2:  return 15;  // E only → lower-right
        default: return 1;   // fallback
    }
}
