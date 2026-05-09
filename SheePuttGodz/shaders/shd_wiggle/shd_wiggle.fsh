varying vec2 v_vTexcoord;
varying vec4 v_vColour;

void main() {
    vec4 texColor = v_vColour * texture2D( gm_BaseTexture, v_vTexcoord );
    if (texColor.a < 0.5) {
        discard;
    }
    
    gl_FragColor = v_vColour * texture2D(gm_BaseTexture, v_vTexcoord);
}
