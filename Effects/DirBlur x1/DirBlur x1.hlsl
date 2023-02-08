
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

cbuffer PS_VARIABLES : register(b0)
{
	float fCoeff;
	float fAngle;
};

PS_OUTPUT ps_main( in PS_INPUT In )
{
  PS_OUTPUT Out;
  PS_OUTPUT OutA;
  PS_OUTPUT OutB;
	float _fAngle = fAngle*0.0174532925f;
	OutA.Color = Tex0.Sample(Tex0Sampler, float2(In.texCoord.x+cos(_fAngle)*fCoeff,In.texCoord.y+sin(_fAngle)*fCoeff));
	OutB.Color = Tex0.Sample(Tex0Sampler, float2(In.texCoord.x-cos(_fAngle)*fCoeff,In.texCoord.y-sin(_fAngle)*fCoeff));
	Out.Color = Tex0.Sample(Tex0Sampler, In.texCoord.xy);
	Out.Color = (Out.Color+OutA.Color+OutB.Color)/3;
	Out.Color *= In.Tint;
  return Out;
}

float4 GetColorPM(float2 xy)
{
	float4 color = Tex0.Sample(Tex0Sampler, xy);
	if ( color.a != 0 )
		color.rgb /= color.a;
	return color;
}

PS_OUTPUT ps_main_pm( in PS_INPUT In )
{
  PS_OUTPUT Out;
  PS_OUTPUT OutA;
  PS_OUTPUT OutB;
	float _fAngle = fAngle*0.0174532925f;
	OutA.Color = GetColorPM(float2(In.texCoord.x+cos(_fAngle)*fCoeff,In.texCoord.y+sin(_fAngle)*fCoeff));
	OutB.Color = GetColorPM(float2(In.texCoord.x-cos(_fAngle)*fCoeff,In.texCoord.y-sin(_fAngle)*fCoeff));
	Out.Color = GetColorPM(In.texCoord.xy);
	Out.Color = (Out.Color+OutA.Color+OutB.Color)/3;
	Out.Color.rgb *= Out.Color.a;
	Out.Color *= In.Tint;
  return Out;
}
