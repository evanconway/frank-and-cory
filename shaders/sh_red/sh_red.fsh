// Color Overlay Fragment Shader
varying vec2 v_vTexcoord;

uniform float alpha;

void main()
{
    vec4 texColor = texture2D(gm_BaseTexture, v_vTexcoord);
    gl_FragColor = vec4(1, 0, 0, texColor.a * alpha);
}