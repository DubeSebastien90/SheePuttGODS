walkspd = 0.02
gx = gx0
gy = gy0
gz = 0

vx = 0
vy = 0
vz = 0

jumpForce = 1
grav = 0.05

on_land = false
on_water = false
in_air = false

canControl = true

COL_RADIUS = 0.2

TILE_VOID  = 0
TILE_GRASS = 1
TILE_WATER = 2

function _tile(tx, ty) {
    var _w = global.current_level.width;
    var _h = global.current_level.height;
    if (tx < 0 || ty < 0 || tx >= _w || ty >= _h) return TILE_VOID;
    return global.current_level.grid[ty][tx];
}

function _is_walkable(tx, ty) { return _tile(tx, ty) == TILE_GRASS; }
function _is_swimable(tx, ty) { return _tile(tx, ty) == TILE_WATER; }

function _can_enter(tx, ty) {
    if (on_land  && _is_walkable(tx, ty)) return true;
    if (on_water && _is_swimable(tx, ty)) return true;
    return false;
}

function _try_move(_mvx, _mvy, _mvz) {
    var r      = COL_RADIUS;
    var out_vx = 0;
    var out_vy = 0;

    if (in_air) {
        out_vx = _mvx;
        out_vy = _mvy;
    } else {
        if (_mvx != 0) {
            var edge_x = (gx + _mvx) + sign(_mvx) * r;
            if (_can_enter(floor(edge_x), floor(gy - r))
             && _can_enter(floor(edge_x), floor(gy + r))) {
                out_vx = _mvx;
            }
        }
        if (_mvy != 0) {
            var edge_y = (gy + _mvy) + sign(_mvy) * r;
            if (_can_enter(floor(gx - r), floor(edge_y))
             && _can_enter(floor(gx + r), floor(edge_y))) {
                out_vy = _mvy;
            }
        }
    }

    var out_vz = _mvz;
    var landed = false;

    if (gz + _mvz <= 0) {
        out_vz = -gz;
        landed = true;
    }

    return { vx: out_vx, vy: out_vy, vz: out_vz, landed: landed };
}