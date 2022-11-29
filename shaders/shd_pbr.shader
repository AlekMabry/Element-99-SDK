attribute vec3 in_Position;
attribute vec2 in_TextureCoord;
attribute vec3 in_Normal;
attribute vec3 in_Colour0;  // Bitangent
attribute vec3 in_Colour1;  // Tangent

varying vec2 v_vTexcoord;
varying vec3 v_vViewSpacePos;
varying vec3 v_vWorldSpacePos;
varying mat3 v_vTBN;
varying float v_vFogFactor;

uniform vec3 u_LightCol[4];
uniform vec3 u_LightPos[4];
uniform vec3 u_LightAttr[4];
uniform vec3 u_CameraPos;
uniform sampler2D tex_Albedo;
uniform sampler2D tex_Normal;
uniform sampler2D tex_Material;

mat4 transpose(mat4 m) {
    return mat4(
        m[0][0], m[1][0], m[2][0], m[3][0],
        m[0][1], m[1][1], m[2][1], m[3][1],
        m[0][2], m[1][2], m[2][2], m[3][2],
        m[0][3], m[1][3], m[2][3], m[3][3]);
}

void main()
{
    vec4 object_space_pos = vec4(in_Position.x, in_Position.y, in_Position.z, 1.0);
    vec4 view_space_pos = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * object_space_pos;
    vec4 world_space_pos = gm_Matrices[MATRIX_WORLD] * object_space_pos;
    
    gl_Position = view_space_pos;
    v_vTexcoord = in_TextureCoord;
    v_vViewSpacePos = vec3(view_space_pos.x, view_space_pos.y, view_space_pos.z);
    v_vWorldSpacePos = vec3(world_space_pos.x, world_space_pos.y, world_space_pos.z);
    
    mat4 rotationMatrix = gm_Matrices[MATRIX_WORLD];
    rotationMatrix[3] = vec4(0.0, 0.0, 0.0, 1.0);
    
    vec3 T = normalize(vec3(rotationMatrix * vec4(in_Colour1, 0.0)));
    vec3 B = normalize(vec3(rotationMatrix * vec4(in_Colour0, 0.0)));
    vec3 N = normalize(vec3(rotationMatrix * vec4(in_Normal, 0.0)));
    v_vTBN = mat3(T, B, N);
    
    /* Fog */
    vec4 viewPos = gm_Matrices[MATRIX_WORLD_VIEW] * object_space_pos;
    v_vFogFactor = min((max(viewPos.z - 1280.0, 0.0) / 2048.0), 1.0);
}

//######################_==_YOYO_SHADER_MARKER_==_######################@~varying vec2 v_vTexcoord;
varying vec3 v_vViewSpacePos;
varying vec3 v_vWorldSpacePos;
varying mat3 v_vTBN;
varying float v_vFogFactor;

uniform vec3 u_LightCol[6];
uniform vec3 u_LightPos[6];
uniform vec3 u_LightAttr[6];
uniform vec3 u_CameraPos;
uniform sampler2D tex_Albedo;
uniform sampler2D tex_Normal;
uniform sampler2D tex_Material;
uniform sampler2D tex_Cubemap;

const float PI = 3.14159265359;

float DistributionGGX(vec3 N, vec3 H, float roughness)
{
    float a      = roughness*roughness;
    float a2     = a*a;
    float NdotH  = max(dot(N, H), 0.0);
    float NdotH2 = NdotH*NdotH;

    float num   = a2;
    float denom = (NdotH2 * (a2 - 1.0) + 1.0);
    denom = PI * denom * denom;

    return num / denom;
}

float GeometrySchlickGGX(float NdotV, float roughness)
{
    float r = (roughness + 1.0);
    float k = (r*r) / 8.0;

    float num   = NdotV;
    float denom = NdotV * (1.0 - k) + k;

    return num / denom;
}

float GeometrySmith(vec3 N, vec3 V, vec3 L, float roughness)
{
    float NdotV = max(dot(N, V), 0.0);
    float NdotL = max(dot(N, L), 0.0);
    float ggx2  = GeometrySchlickGGX(NdotV, roughness);
    float ggx1  = GeometrySchlickGGX(NdotL, roughness);

    return ggx1 * ggx2;
}

vec3 fresnelSchlick(float cosTheta, vec3 F0)
{
    return F0 + (1.0 - F0) * pow(max(1.0 - cosTheta, 0.0), 5.0);
}

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
    /* Normal and View Vectors */
    vec3 N = normalize(v_vTBN * ((texture2D(tex_Normal, v_vTexcoord).rgb * 2.0) - 1.0));
    vec3 V = normalize(u_CameraPos - v_vWorldSpacePos);
    
    /* Material Parameters */
    vec3 albedo = texture2D(tex_Albedo, v_vTexcoord).rgb;
    float ao = texture2D(tex_Material, v_vTexcoord).r;
    float roughness = min(texture2D(tex_Material, v_vTexcoord).g + 0.1, 1.0);
    float metallic = texture2D(tex_Material, v_vTexcoord).b;
    
    vec3 F0 = vec3(0.04);
    F0 = mix(F0, albedo, metallic);
    
    /* Cubemap Radiance */
    vec3 reflectV = reflect(V, N);
    vec4 cubemap_radiance = texture2D(tex_Cubemap, getCubeUV(reflectV));
    
    /* Reflectance Equation */
    vec3 Lo = vec3(0.0);
    for (int i = 0; i < 6; i++)
    {
        /* Per-light Radiance */
        vec3 L = normalize(u_LightPos[i] - v_vWorldSpacePos);
        vec3 H = normalize(V + L);
        float dist = length(u_LightPos[i] - v_vWorldSpacePos);
        float attenuation = 1.0 / (u_LightAttr[i].x + u_LightAttr[i].y * dist + 
                                    u_LightAttr[i].z * (dist * dist));
        vec3 radiance = u_LightCol[i] * attenuation;
        
        /* Cook-torrance BRDF */
        float NDF = DistributionGGX(N, H, roughness);
        float G = GeometrySmith(N, V, L, roughness);
        vec3 F = fresnelSchlick(max(dot(H, V), 0.0), F0);
        
        vec3 kS = F;
        vec3 kD = vec3(1.0) - kS;
        kD *= 1.0 - metallic;
        
        vec3 numerator = NDF * G * F;
        float denominator = 4.0 * max(dot(N, V), 0.0) * max(dot(N, L), 0.0);
        vec3 specular = numerator / max(denominator, 0.001);
        
        /* Add to outgoing radiance Lo */
        float NdotL = max(dot(N, L), 0.0);
        Lo += (kD * albedo / PI + specular) * radiance * NdotL;
        Lo += cubemap_radiance.rgb * (1.0 - roughness) * 0.05;
    }
    
    vec3 ambient = vec3(0.03) * albedo * ao;
    vec3 color = ambient + Lo;
    
    vec3 fogColor = vec3(0.196, 0.274, 0.313);
    // vec3 normal = (N + 1.0) * 0.5;
    gl_FragColor = vec4(color, 1.0); //vec4(mix(color, fogColor, v_vFogFactor), 1.0);
}

