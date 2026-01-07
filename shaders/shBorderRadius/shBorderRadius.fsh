// The MIT License
// Copyright © 2015 Inigo Quilez
// Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions: The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software. THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
// https://www.youtube.com/c/InigoQuilez
// https://iquilezles.org


// Signed distance to a 2D rounded box. Tutorials explaining
// how it works: 
//
// https://www.youtube.com/watch?v=62-pRVZuS5c
// https://www.youtube.com/watch?v=s5NGeUV2EyU
//
// See also generalization to other corner shapes here:
//
// https://www.shadertoy.com/view/4cG3R1
//
//
// List of some other 2D distances:
//    https://www.shadertoy.com/playlist/MXdSRf
// and
//    iquilezles.org/articles/distfunctions2d


// b.x = half width
// b.y = half height
// r.x = roundness top-right  
// r.y = roundness boottom-right
// r.z = roundness top-left
// r.w = roundness bottom-left

varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform vec2 position;
uniform vec2 anchor;
uniform vec4 radius;
uniform vec2 size;

float sdRoundBox( in vec2 p, in vec2 b, in vec4 r ) 
{
    r.xy = (p.x>0.0)?r.xy : r.zw;
    r.x  = (p.y>0.0)?r.x  : r.y;
    vec2 q = abs(p)-b+r.x;
    return min(max(q.x,q.y),0.0) + length(max(q,0.0)) - r.x;
}

void main(){
	gl_FragColor = v_vColour * texture2D(gm_BaseTexture, v_vTexcoord);
	vec2 p = ((gl_FragCoord.xy - position.xy) - size.xy);
	
	vec4 rad = vec4(radius);
	rad.x = min(radius.x, min(size.x, size.y));
	rad.y = min(radius.y, min(size.x, size.y));
	rad.z = min(radius.z, min(size.x, size.y));
	rad.w = min(radius.w, min(size.x, size.y));
	
	float d = sdRoundBox(p, size, rad);
	if (d > 0.0) {
        discard;
    }
}