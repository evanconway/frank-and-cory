//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;
varying vec2 v_vRoomcoord;

uniform vec2 centre; // in room coordinates
uniform float radius; // in room pixels
uniform float feather; // factor of radius >= 0 && <= 1

void main()
{
	vec4 base_col = v_vColour * texture2D( gm_BaseTexture, v_vTexcoord );
	float dist = length(v_vRoomcoord - centre);
	//base_col = base_col * step(radius, dist); // hard line
	base_col.a = base_col.a * smoothstep(radius * feather, radius, dist); // smooth line
	
	gl_FragColor	= base_col;// * vec4(1.5, 0.5, 0.5, 1.0);
	
	// original line in template
    //gl_FragColor = v_vColour * texture2D( gm_BaseTexture, v_vTexcoord );
}
