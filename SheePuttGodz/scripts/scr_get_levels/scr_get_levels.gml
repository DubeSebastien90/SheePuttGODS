function get_levels() {
    var level_data = [
      [
          "~~~~~~~~~~~~~~~~",
          "~~~~~~~~~~~~~~~~",
          "~~~~.......~~~~~",
          "~~~.........~~~~",
          "~~...........~~~",
          "~~...........~~~",
          "~~...........~~~",
          "~~...........~~~",
          "~~...........~~~",
          "~~...........~~~",
          "~~...........~~~",
          "~~...........~~~",
          "~~~.........~~~~",
          "~~~~.......~~~~~",
          "~~~~~~~~~~~~~~~~",
          "~~~~~~~~~~~~~~~~",
      ],
      [
          "~~~~~~~~~~~~~~~~",
          "~..........~~~~~",
          "~..........~~~~~",
          "~..........~~~~~",
          "~..........~~~~~",
          "~..........~~~~~",
          "~~~~~~.....~~~~~",
          "~~~~~~.....~~~~~",
          "~~~~~~.....~~~~~",
          "~~~~~~.....~~~~~",
          "~~~~~~.....~~~~~",
          "~~~~~~~~~~.....~",
          "~~~~~~~~~~.....~",
          "~~~~~~~~~~.....~",
          "~~~~~~~~~~.....~",
          "~~~~~~~~~~~~~~~~",
      ],
      [
          "~~~~~~~~~~~~~~~~",
          "~~~~~~~~~~~~~~~~",
          "~~.........~~~~~",
          "~~.........~~~~~",
          "~~...~~.~~..~~~~",
          "~~...~.....~~~~~",
          "~~...~.....~~~~~",
          "~~...~~.~~..~~~~",
          "~~.........~~~~~",
          "~~.........~~~~~",
          "~~.........~~~~~",
          "~~.........~~~~~",
          "~~~.........~~~~",
          "~~~~.......~~~~~",
          "~~~~~~~~~~~~~~~~",
          "~~~~~~~~~~~~~~~~",
      ],
    ];
    
    return _build_levels(level_data);
}

function _build_levels(_level_data){
    var levels = [];
    
    for (var idx = 0; idx < array_length(_level_data); idx++) {
        var rows = _level_data[idx];
        var lh   = array_length(rows);
        var lw   = string_length(rows[0]);
        
        var _grid = ds_grid_create(lw, lh);
        
        for (var j = 0; j < lh; j++) {
            var row = rows[j];
            for (var i = 0; i < lw; i++) {
                var c = string_char_at(row, i + 1);
                var val = _map_character(c);
                ds_grid_set(_grid, i, j, val);
            }
        }
        
        for (var j = lh - 1; j >= 0; j--) {
            for (var i = lw - 1; i >= 0; i--) {
                var value = ds_grid_get(_grid, i, j)
                if value == 0 continue;
                    
                if (j == 0) {
                    ds_grid_set(_grid, i, j, ds_grid_get(_grid, i, j) + 2)
                } else if (value != ds_grid_get(_grid, i, j - 1)) {
                    ds_grid_set(_grid, i, j, ds_grid_get(_grid, i, j) + 2)
                }
                
                if (i == 0) {
                    ds_grid_set(_grid, i, j, ds_grid_get(_grid, i, j) + 1)
                } else if (value != ds_grid_get(_grid, i - 1, j)) {
                    ds_grid_set(_grid, i, j, ds_grid_get(_grid, i, j) + 1)
                }
            }
        }
        
        levels[idx] = { grid: _grid, width: lw, height: lh }
    }
    
    return levels
}

function _map_character(c) {
    switch (c) {
        case "=": return 0;
        case ".": return 1;
        case "~": return 5;
        default:  return 0;
    }
}
