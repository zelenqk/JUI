uniform vec4 radius;
uniform vec2 size;

varying vec2 v_vTexcoord;
varying vec4 v_vColour;

// b.x = half width
// b.y = half height
// r.x = roundness top-right  
// r.y = roundness boottom-right
// r.z = roundness top-left
// r.w = roundness bottom-left
float sdRoundBox(vec2 p, vec2 b, vec4 r, float ratio){
    p.x *= ratio;
    b.x *= ratio;
    
    r.xy = (p.x > 0.0) ? r.xy : r.zw;
    r.x  = (p.y > 0.0) ? r.x : r.y;
    
    vec2 q = abs(p) - b + r.x;
    return min(max(q.x, q.y), 0.0) + length(max(q, 0.0)) - r.x;
}

vec2 dimensions = vec2(0.5);

void main() {
    gl_FragColor = texture2D(gm_BaseTexture, v_vTexcoord);

    float ratio = (size.x / size.y);
    
    vec2 uv = v_vTexcoord - dimensions;
    float d = sdRoundBox(uv, dimensions, radius, ratio);

    // smooth cutoff for anti-aliasing (feather edges)
    float aa = fwidth(d); // automatic pixel-size AA
    float mask = smoothstep(0.0, -aa, d);

    // apply mask only to alpha
    gl_FragColor = tex * v_vColour;
    gl_FragColor.a *= mask;
}