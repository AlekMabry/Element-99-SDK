//
// Simple passthrough vertex shader
//
attribute vec3 in_Position;                  // (x,y,z)
//attribute vec3 in_Normal;                  // (x,y,z)     unused in this shader.
attribute vec4 in_Colour;                    // (r,g,b,a)
attribute vec2 in_TextureCoord;              // (u,v)

varying vec2 v_vTexcoord;
varying vec4 v_vColour;
varying vec3 v_vPosition;

uniform vec2 lightmapPos;
uniform vec2 lightmapScale;
uniform vec2 lightmapRepeat;
uniform float clipHeight;

uniform sampler2D lightmap;

void main()
{
    vec4 object_space_pos = vec4( in_Position.x, in_Position.y, in_Position.z, 1.0);
    gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * object_space_pos;
    
    v_vColour = in_Colour;
    v_vTexcoord = in_TextureCoord;
    v_vPosition = in_Position;
}

//######################_==_YOYO_SHADER_MARKER_==_######################@~//
// Simple lightmapped fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;
varying vec3 v_vPosition;

uniform sampler2D lightmap;
uniform vec2 lightmapPos;
uniform vec2 lightmapScale;
uniform vec2 lightmapRepeat;
uniform float clipHeight;

void main()
{
    //Lightmaps are taken from a main texturesheet. This texture sheet is 256 in length
    //however lightmap is 192 in length. This is 0.75 the length of it.
    vec2 distortedTexcoord = vec2( ((v_vTexcoord.x*lightmapScale.x)+lightmapPos.x) / lightmapRepeat.x, ((v_vTexcoord.y*lightmapScale.y)+lightmapPos.y) / lightmapRepeat.y );
    float brightness = texture2D(lightmap, distortedTexcoord).b;
    if (brightness > 1.0) {
        brightness = 1.0;
    }
    vec3 colourRegular = texture2D( gm_BaseTexture, v_vTexcoord ).rgb;
    vec4 colourFinal = vec4(brightness*colourRegular, 1.0);
    if (v_vPosition.z < clipHeight) {
        gl_FragColor = vec4(0.0, 0.0, 0.0, 0.0);
    } else {
        gl_FragColor = v_vColour * colourFinal;
    }
}
