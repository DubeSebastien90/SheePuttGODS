function get_level_data(_index) {
    static _cache = undefined;
    if (_cache == undefined) {
        _cache = _build_levels([
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
        ]);
    }
    return _cache[_index % array_length(_cache)];
}

function _build_levels(_level_data) {
    var _count = array_length(_level_data);
    var _levels = array_create(_count);

    for (var _idx = 0; _idx < _count; _idx++) {
        var _rows = _level_data[_idx];
        var _lh   = array_length(_rows);
        var _lw   = string_length(_rows[0]);

        var _grid      = array_create(_lh);
        var _tiles_idx = array_create(_lh);
        var _decos_idx = array_create(_lh);

        for (var _j = 0; _j < _lh; _j++) {
            _grid[_j]      = array_create(_lw);
            _tiles_idx[_j] = array_create(_lw);
            _decos_idx[_j] = array_create(_lw);
            
            var _row_str = _rows[_j];
            for (var _i = 0; _i < _lw; _i++) {
                _grid[_j][_i] = _map_character(string_char_at(_row_str, _i + 1));
            }
        }

        for (var _j = 0; _j < _lh; _j++) {
            for (var _i = 0; _i < _lw; _i++) {
                var _val = _grid[_j][_i];
                if (_val == 0) continue;

                var _tile_val = _map_sprite_idx(_val);
                if (_j == 0 || _grid[_j-1][_i] != _val) _tile_val += 2;
                if (_i == 0 || _grid[_j][_i-1] != _val) _tile_val += 1;
                _tiles_idx[_j][_i] = _tile_val;

                if random(1) > 0.95 {
                    _decos_idx[_j][_i] = choose(1, 2, 3) + (_val - 1) * 3;
                }
            }
        }

        _levels[_idx] = {
            grid: _grid,
            tiles_idx: _tiles_idx,
            decos_idx: _decos_idx,
            width: _lw,
            height: _lh
        };
    }

    return _levels;
}

function _map_character(c) {
    switch (c) {
        case ".": return 1;
        case "~": return 2;
        default:  return 0;
    }
}

function _map_sprite_idx(n) {
    return (n - 1) * 4 + 1;
}