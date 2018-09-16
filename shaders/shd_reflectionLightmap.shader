//
// Simple passthrough vertex shader
//
attribute vec3 in_Position;                  // (x,y,z)
attribute vec3 in_Normal;                  // (x,y,z)     unused in this shader.
attribute vec4 in_Colour;                    // (r,g,b,a)
attribute vec2 in_TextureCoord;              // (u,v)

varying vec2 v_vTexcoord;
varying vec4 v_vColour;
varying vec4 v_vScreenPos;
varying vec3 v_vPosition;
varying vec3 v_vNormal;

uniform vec2 lightmapPos;
uniform vec2 lightmapScale;
uniform vec2 lightmapRepeat;
uniform vec3 playerPos;

uniform sampler2D reflectionTex;
uniform sampler2D lightmap;

void main()
{
    vec4 object_space_pos = vec4( in_Position.x, in_Position.y, in_Position.z, 1.0);
    vec4 screenPos = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * object_space_pos;
    gl_Position = screenPos;
    
    v_vColour = in_Colour;
    v_vTexcoord = in_TextureCoord;
    v_vScreenPos = screenPos;
    v_vPosition = in_Position;
    v_vNormal = in_Normal;
}

//######################_==_YOYO_SHADER_MARKER_==_######################@~//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;
varying vec4 v_vScreenPos;
varying vec3 v_vPosition;
varying vec3 v_vNormal;

uniform vec2 lightmapPos;
uniform vec2 lightmapScale;
uniform vec2 lightmapRepeat;
uniform vec3 playerPos;

uniform sampler2D reflectionTex;
uniform sampler2D lightmap;

void main()
{
    //Getting blood colour and reflectiveness factor. The more shallow an angle, the more reflective the surface is.
    vec4 bloodColour = vec4(0.3, 0.1, 0.1, 1.0);
    vec3 playerVector = normalize(playerPos-v_vPosition);
    float shallowness = 1.0-dot(playerVector, v_vNormal); //If player is shallow it will be 0, -1, if player is not shallow it will be 1
    //To get reflectiveness coefficient it would be 1-shallowness
    
    //Standard Lightmap Code -------------------------------------------
    vec2 distortedTexcoord = vec2( ((v_vTexcoord.x*lightmapScale.x)+lightmapPos.x) / lightmapRepeat.x, ((v_vTexcoord.y*lightmapScale.y)+lightmapPos.y) / lightmapRepeat.y );
    float brightness = texture2D(lightmap, distortedTexcoord).b;
    if (brightness > 1.0) {
        brightness = 1.0;
    }
    vec3 colourRegular = texture2D( gm_BaseTexture, v_vTexcoord ).rgb;
    vec4 colourFinal = vec4(brightness*colourRegular, 1.0);
    
    //This checks if the current area is covered in blood
    float bloodCoefficient = texture2D(lightmap, distortedTexcoord).a;
    //------------------------------------------------------------------
    
    vec2 finalColour = vec2(((v_vScreenPos.x/ v_vScreenPos.w)+1.0)*0.5, ((v_vScreenPos.y/ v_vScreenPos.w)+1.0)*0.5);
    vec4 finalReflectColour = texture2D( reflectionTex, finalColour );
    vec4 finalReflectColourScaled = vec4((finalReflectColour.rgb*bloodCoefficient*shallowness)/3.0, finalReflectColour.a); //
    bloodColour.rgb = mix(vec3(1.0, 1.0, 1.0), bloodColour.rgb, bloodCoefficient);
    gl_FragColor = bloodColour * v_vColour * (finalReflectColourScaled+colourFinal);
    //reflectionTex
}

