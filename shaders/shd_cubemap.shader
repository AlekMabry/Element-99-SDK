attribute vec3 in_Position;                  // (x,y,z)
//attribute vec3 in_Normal;                  // (x,y,z)     unused in this shader.
attribute vec4 in_Colour;                    // (r,g,b,a)
attribute vec2 in_TextureCoord;              // (u,v)

varying vec2 v_vTexcoord;
varying vec4 v_vColour;
varying vec3 v_vPosition;

void main()
{
    vec4 object_space_pos = vec4( in_Position.x, in_Position.y, in_Position.z, 1.0);
    gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * object_space_pos;
    
    v_vColour = in_Colour;
    v_vTexcoord = in_TextureCoord;
    vec4 world_space_pos = gm_Matrices[MATRIX_WORLD] * object_space_pos;
    v_vPosition = world_space_pos.xyz;
    
}

//######################_==_YOYO_SHADER_MARKER_==_######################@~varying vec2 v_vTexcoord;
varying vec4 v_vColour;
varying vec3 v_vPosition;

uniform vec3 u_CameraPos;
uniform sampler2D tex_Cubemap;

vec2 getCubeUV(vec3 view)
{
    vec2 uv;
    vec3 viewAbs = abs(view);
    
    // -X, +X
    if (viewAbs.x >= viewAbs.y && viewAbs.x >= viewAbs.z)
    {
        // -X
        if (view.x > 0.0)
        {
            uv.x = 0.125;
            uv.y = 0.125;
            uv.x += view.y / view.x * 0.125;
            uv.y += view.z / view.x * 0.125;
        }
        else
        // +X
        {
            uv.x = 0.375;
            uv.y = 0.125;
            uv.x += view.y / view.x * 0.125;
            uv.y += view.z / view.x * -0.125;
        }
    }
    // -Y, +Y
    if (viewAbs.y > viewAbs.x && viewAbs.y >= viewAbs.z)
    {
        // -Y
        if (view.y > 0.0)
        {
            uv.x = 0.125;
            uv.y = 0.375;
            uv.x += view.x / view.y * -0.125;
            uv.y += view.z / view.y * 0.125;
        }
        else
        // +Y
        {
            uv.x = 0.375;
            uv.y = 0.375;
            uv.x += view.x / view.y * -0.125;
            uv.y += view.z / view.y * -0.125;
        }
    }
    // -Z, +Z
    if (viewAbs.z > viewAbs.x && viewAbs.z > viewAbs.y)
    {
        // +Z
        if (view.z > 0.0)
        {
            uv.x = 0.125;
            uv.y = 0.625;
            uv.x += view.x / view.z * 0.125;
            uv.y += view.y / view.z * 0.125;
        }
        else
        // -Z
        {
            uv.x = 0.375;
            uv.y = 0.625;
            uv.x += view.x / view.z * 0.125;
            uv.y += view.y / view.z * -0.125;
        }
    }
    return uv;
}

void main()
{
    vec3 view = normalize(u_CameraPos - v_vPosition);
    vec2 cubeUV = getCubeUV(view);
    
    gl_FragColor = texture2D(tex_Cubemap, cubeUV);
}

