varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform vec2 size;
uniform float radius;

void main() {
    vec2 texel = 1.0 / size;
    
    vec4 total_color = vec4(0);
    
    for (float i = -radius; i <= radius; i += 1.0) {
        total_color += texture2D(gm_BaseTexture, v_vTexcoord + vec2(0, i) * texel);
    }
    
    total_color /= 2.0 * radius + 1.0;
    
    gl_FragColor = v_vColour * total_color;
}