varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform vec4 color;

void main()
{
    vec4 base = v_vColour * texture2D(gm_BaseTexture, v_vTexcoord);

    if (color == vec4(1.0))
    {
        gl_FragColor = base;
    }
    else
    {
        gl_FragColor = base * color;
    }
}
