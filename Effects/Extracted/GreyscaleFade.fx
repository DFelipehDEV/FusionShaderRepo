
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
sampler2D Texture0;

float fade;

PS_OUTPUT ps_main( in PS_INPUT In )
{
    // Output pixel
    PS_OUTPUT Out;
    Out.Color = tex2D(Texture0,In.Texture.xy);
   // Out.Color.rgb += sin(In.Texture.y*fPeriods-fOffset)*fAmplitude;
//	Out.Color.a = tex2D(Texture0,In.Texture.xy)*fOffset;
	if (Out.Color.r >= fade){
	Out.Color.a = 0;	
	}
	else {
	Out.Color.a = 1;	
	}
	Out.Color.rgb = 0;
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