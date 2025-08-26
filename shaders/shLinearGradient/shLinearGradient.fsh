varying vec2 v_vTexcoord;
uniform float uDirection;
uniform int uColorCount;
uniform float factor[10];
uniform vec4 color[10];

void main() {
    vec2 dir = normalize(vec2(cos(uDirection), sin(uDirection)));
    float t = clamp(dot(v_vTexcoord, dir), 0.0, 1.0);

    float pos[10];
    pos[0] = factor[0];
    for(int i = 1; i < uColorCount; i++) pos[i] = pos[i-1] + factor[i];
    pos[uColorCount-1] = 1.0;

    vec4 gradCol = color[0];
    for(int i = 1; i < uColorCount; i++){
        float f = smoothstep(pos[i-1], pos[i], t);
        gradCol = mix(gradCol, color[i], f);
    }

    gl_FragColor = gradCol; // do not multiply by gm_BaseTexture
}
