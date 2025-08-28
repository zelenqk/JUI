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
	p.y *= ratio;
	b.x *= ratio;
	
	r.xy = (p.x > 0.0) ? r.xy : r.zw;
	r.x  = (p.y > 0.0) ? r.x : r.y;

	vec2 q = abs(p) - b + r.x;
	return min(max(q.x, q.y), 0.0) + length(max(q, 0.0)) - r.x;
}

vec2 dimensions = vec2(0.5);

void main() {
	gl_FragColor = v_vColour * texture2D(gm_BaseTexture, v_vTexcoord);
	
	float ratio = (size.x / size.y);
	float d = sdRoundBox(v_vTexcoord, size, radius, ratio);
	
	float edgeSoftness = 1.5;
	gl_FragColor.a = 1.0 - smoothstep(0.0, edgeSoftness, d);
}