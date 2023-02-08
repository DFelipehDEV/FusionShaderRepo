
// Pixel shader input structure
struct PS_INPUT
{
    float4 Position   : POSITION;
    float2 Texture    : TEXCOORD0;
};

// Pixel shader output structure
struct PS_OUTPUT
{
    float4 Color   : COLOR0;
};

// Global variables
sampler2D Tex0 = sampler_state {
AddressU = border;
AddressV = border;
BorderColor = float4(1.0,1.0,1.0,0.0);
};
float fTimer;
float fPowerX;
float fPowerY;

PS_OUTPUT ps_main( in PS_INPUT In )
{
    // Output pixel
    PS_OUTPUT Out;
	
    In.Texture.y = In.Texture.y + (sin(fTimer)*fPowerY);
    In.Texture.x = In.Texture.x + (cos(fTimer)*fPowerX);
   	Out.Color = tex2D(Tex0, In.Texture.xy);
	
    return Out;
}

// Effect technique
technique tech_main
{
    pass P0
    {
        // shaders
        VertexShader = NULL;
        PixelShader  = compile ps_2_0 ps_main();
    }  
}