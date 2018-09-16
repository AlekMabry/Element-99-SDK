//
// Simple passthrough vertex shader
//
attribute vec3 in_Position;                  // (x,y,z)
//attribute vec3 in_Normal;                  // (x,y,z)     unused in this shader.
attribute vec4 in_Colour;                    // (r,g,b,a)
attribute vec2 in_TextureCoord;              // (u,v)

varying vec2 v_vTexcoord;
varying vec4 v_vColour;
varying vec4 v_vScreenPos;

uniform sampler2D reflectionTex;

void main()
{
    vec4 object_space_pos = vec4( in_Position.x, in_Position.y, in_Position.z, 1.0);
    vec4 screenPos = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * object_space_pos;
    gl_Position = screenPos;
    
    v_vColour = in_Colour;
    v_vTexcoord = in_TextureCoord;
    v_vScreenPos = screenPos;
}

//######################_==_YOYO_SHADER_MARKER_==_######################@~//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;
varying vec4 v_vScreenPos;

uniform sampler2D reflectionTex;

void main()
{
    //vec2 finalColour = vec2((v_vScreenPos.x/ v_vScreenPos.w)+1.0, (((v_vScreenPos.y/ v_vScreenPos.w)+1.0)*-1.0)+1.0);
    vec2 finalColour = vec2(((v_vScreenPos.x/ v_vScreenPos.w)+1.0)*0.5, ((v_vScreenPos.y/ v_vScreenPos.w)+1.0)*0.5);
    gl_FragColor = v_vColour * texture2D( reflectionTex, finalColour );
    //reflectionTex
}

