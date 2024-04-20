// Color Overlay Fragment Shader
varying vec2 v_vTexcoord;

void main()
{
    vec4 texColor = texture2D(gm_BaseTexture, v_vTexcoord);
    gl_FragColor = vec4(1, 1, 1, texColor.a * 0.5);
}