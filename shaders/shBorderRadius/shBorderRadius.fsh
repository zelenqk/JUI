uniform vec4 radius;   // normalized 0–1 per corner (TL, TR, BR, BL)
uniform vec2 size;     // rect size in pixels

varying vec2 v_vTexcoord;
varying vec4 v_vColour;

// iquilez SDF for rounded box (single radius)
float roundedBoxSDF(vec2 p, vec2 halfSize, float r) {
    return length(max(abs(p) - halfSize + r, 0.0)) - r;
}

void main() {
    vec4 tex = texture2D(gm_BaseTexture, v_vTexcoord);

    // center coords around rect center
    vec2 uv = v_vTexcoord * size;        // convert 0–1 to pixel space
    vec2 p  = uv - (size * 0.5);         // center at (0,0)
    vec2 hs = size * 0.5;                // half-size of rect

    // use the smallest corner radius for now (iQ’s SDF only supports one radius)
    // you can extend to per-corner but let’s start here
    float maxNorm = max(max(radius.x, radius.y), max(radius.z, radius.w));
    float r = maxNorm * min(size.x, size.y);

    // signed distance from edge
    float d = roundedBoxSDF(p, hs, r);

    // smooth antialiasing, automatically pixel-sized
    float edgeSoftness = fwidth(d); 
    float mask = 1.0 - smoothstep(0.0, edgeSoftness * 2.0, d);

    // apply mask to alpha
    gl_FragColor = tex * v_vColour;
    gl_FragColor.a *= mask;
}
