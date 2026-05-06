varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform float u_time;
uniform float u_speed;
uniform float u_intensity;

void main() {
    vec4 col = v_vColour * texture2D(gm_BaseTexture, v_vTexcoord);
    
    if (col.a < 0.01) discard;
    
    float wave = sin(u_time * u_speed) * 0.5 + 0.5;
    float shimmer = smoothstep(0.0, 1.0, wave) * u_intensity;
    col.rgb += shimmer;
    
    gl_FragColor = col;
}
