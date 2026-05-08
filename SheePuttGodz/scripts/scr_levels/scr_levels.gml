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
    var levels = [];

    for (var idx = 0; idx < array_length(_level_data); idx++) {
        var rows = _level_data[idx];
        var lh   = array_length(rows);
        var lw   = string_length(rows[0]);

        var _grid      = array_create(lh);
        var _tiles_idx = array_create(lh);
        var _decos_idx = array_create(lh);

        for (var j = 0; j < lh; j++) {
            _grid[j]      = array_create(lw, 0);
            _tiles_idx[j] = array_create(lw, 0);
            _decos_idx[j] = array_create(lw, 0);
        }

        // pass 1: parse
        for (var j = 0; j < lh; j++) {
            var row = rows[j];
            for (var i = 0; i < lw; i++) {
                _grid[j][i] = _map_character(string_char_at(row, i + 1));
            }
        }

        // pass 2: edges + decos
        for (var j = lh - 1; j >= 0; j--) {
            for (var i = lw - 1; i >= 0; i--) {
                var value = _grid[j][i];
                if (value == 0) continue;

                if (random(1) > 0.96) {
                    _decos_idx[j][i] = choose(1, 2, 3) + (value - 1) * 3;
                }

                var tile_val = _map_sprite_idx(value);
                if (j == 0 || _grid[j-1][i] != value) tile_val += 2;
                if (i == 0 || _grid[j][i-1] != value) tile_val += 1;
                _tiles_idx[j][i] = tile_val;
            }
        }

        levels[idx] = {
            grid:      _grid,
            tiles_idx: _tiles_idx,
            decos_idx: _decos_idx,
            width:     lw,
            height:    lh,
        };
    }

    return levels;
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