varying vec2 v_vTexcoord;
varying vec4 v_vColour;
varying vec3 v_vPosition;

uniform vec4 radius;
uniform vec2 size;
uniform vec2 pos;
uniform float alpha;

float sdRoundBox( in vec2 p, in vec2 b, in vec4 r) {
	r.xy = (p.x > 0.0) ? r.xy : r.zw;
	r.x  = (p.y > 0.0) ? r.x  : r.y;
	vec2 q = abs(p) - b + r.x;
	return min(max(q.x, q.y), 0.0) + length(max(q, 0.0)) - r.x;
}

void main() {
	gl_FragColor = v_vColour * texture2D(gm_BaseTexture, v_vTexcoord);
	
	vec2 p = v_vPosition.xy - pos;

	float d = sdRoundBox(p, size, radius);

	float aa = 0.01;
	gl_FragColor.a = (gl_FragColor.a * alpha) - smoothstep(0.0, aa, d);
}
