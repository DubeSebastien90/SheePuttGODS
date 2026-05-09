varying vec2 v_vTexcoord;
varying vec4 v_vColour;
varying vec2 v_vWorldPos;

uniform float u_time;

void main() {
    vec4 base_col = v_vColour * texture2D(gm_BaseTexture, v_vTexcoord);
    if (base_col.a < 0.1) discard;

    float band_size = 2.0; 
    float iso_y = v_vWorldPos.y + v_vWorldPos.x * 0.5;
    float pixel_y = floor(iso_y / band_size) * band_size;

    float stretch = 0.015; 
    float wave_pos = (v_vWorldPos.x * stretch) + sin(pixel_y * 0.1 + u_time * 1.2) * 2.5;
    float wave = sin(wave_pos);
    
    float breaker_coord = (v_vWorldPos.x + v_vWorldPos.y * 2.0) * 0.04;
    float breaker = sin(breaker_coord - u_time * 1.8) * cos(v_vWorldPos.y * 0.05);
    
    float combined = max(0.0, wave * breaker);
    float highlight = pow(combined, 6.0) * 0.35;

    vec3 water_color = base_col.rgb * vec3(0.8, 0.9, 1.0);
    vec3 final_rgb = water_color + (highlight * vec3(1.0, 1.0, 1.0));

    gl_FragColor = vec4(final_rgb, base_col.a);
}