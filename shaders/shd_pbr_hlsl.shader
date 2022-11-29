struct VS_INPUT
{
    float4 vPos   : POSITION;
    float4 vNormal : NORMAL;
    float2 vTexCoord : TEXCOORD0;
};

struct PS_INPUT
{
    float4 Position : POSITION;
    float4 Normal : NORMAL;
    float2 TexCoord : TEXCOORD0;
};

PS_INPUT main(VS_INPUT input)
{
    PS_INPUT Output;

    Output.Position = mul(gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION], input.vPos);
    Output.Normal = input.vNormal;
    Output.TexCoord = input.vTexCoord;
 
    return Output;
}
//######################_==_YOYO_SHADER_MARKER_==_######################@~struct PS_INPUT
{
    float4 Normal : NORMAL;
    float2 TexCoord : TEXCOORD0;
};

struct PS_OUTPUT {
    float4 Color : COLOR;
};

PS_OUTPUT main(PS_INPUT In)
{
    PS_OUTPUT Output;

    Output.Color = Normal; //tex2D(gm_BaseTexture, In.TexCoord);

    return Output;
}
