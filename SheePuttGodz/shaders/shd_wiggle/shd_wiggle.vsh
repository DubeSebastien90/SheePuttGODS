attribute vec3 in_Position;
attribute vec4 in_Colour;
attribute vec2 in_TextureCoord;

varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform float u_time;
uniform float u_amplitude;
uniform float u_frequency;
uniform float u_speed;

void main() {
    vec4 pos = vec4(in_Position, 1.0);
    pos.x += sin(pos.y * u_frequency + u_time * u_speed) * u_amplitude;
    gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * pos;
    v_vTexcoord = in_TextureCoord;
    v_vColour = in_Colour;
}
