
// Pixel shader input structure
struct PS_INPUT
{
  float4 Tint : COLOR0;
  float2 texCoord : TEXCOORD0;
  float4 Position : SV_POSITION;
};

// Pixel shader output structure
struct PS_OUTPUT
{
    float4 Color   : SV_TARGET;
};

// Global variables
Texture2D<float4> Tex0 : register(t0);
sampler Tex0Sampler : register(s0);

PS_OUTPUT ps_main( in PS_INPUT In )
{
    // Output pixel
    PS_OUTPUT Out;

    Out.Color = Tex0.Sample(Tex0Sampler, In.texCoord) * In.Tint;
	Out.Color.rgb = (Out.Color.r+Out.Color.g+Out.Color.b)/3;

	float4 f4 = Out.Color * float4(1.5f, 1.1f, 0.6f, 1.0f);
	//float f = f4.r + f4.g + f4.b;
	Out.Color.rgb = f4.rgb;

    return Out;
}

float4 GetColorPM(float2 xy, float4 tint)
{
	float4 color = Tex0.Sample(Tex0Sampler, xy) * tint;
	if ( color.a != 0 )
		color.rgb /= color.a;
	return color;
}

PS_OUTPUT ps_main_pm( in PS_INPUT In )
{
    // Output pixel
    PS_OUTPUT Out;

    Out.Color = GetColorPM(In.texCoord, In.Tint);
	Out.Color.rgb = (Out.Color.r+Out.Color.g+Out.Color.b)/3;

	float4 f4 = Out.Color * float4(1.5f, 1.1f, 0.6f, 1.0f);
	//float f = f4.r + f4.g + f4.b;
	Out.Color.rgb = f4.rgb;
	Out.Color.rgb *= Out.Color.a;

    return Out;
}
