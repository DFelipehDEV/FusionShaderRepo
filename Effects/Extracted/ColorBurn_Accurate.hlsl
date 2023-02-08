
Texture2D<float4> img : register(t0);
sampler imgSampler : register(s0);

Texture2D<float4> bkd : register(t1);
sampler bkdSampler : register(s1);

// Pixel shader input structure
struct PS_INPUT
{
  float4 Tint : COLOR0;
  float2 texCoord : TEXCOORD0;
  float4 Position : SV_POSITION;
};


float4 Demultiply(float4 _color)
{
	float4 color = _color;
	if ( color.a != 0 )
		color.rgb /= color.a;
	return color;
}

float ColorBurn(float base, float blend)
{
    if (base >= 1.0)
        return 1.0;
    else if (blend <= 0.0)
        return 0.0;
    else    
    	return 1.0 - min(1.0, (1.0-base) / blend);
}


float4 ps_main( in PS_INPUT In ) : SV_TARGET
{
	float4 L = Demultiply(img.Sample(imgSampler,In.texCoord)) * In.Tint;
	float4 B = Demultiply(bkd.Sample(bkdSampler,In.texCoord));
	float4 O = float4(  ColorBurn(B.r, L.r), 
						ColorBurn(B.g, L.g), 
						ColorBurn(B.b, L.b),
									   L.a);

	return O;
}

float4 ps_main_pm( in PS_INPUT In ) : SV_TARGET
{
	float4 L = Demultiply(img.Sample(imgSampler,In.texCoord)) * In.Tint;
	float4 B = Demultiply(bkd.Sample(bkdSampler,In.texCoord));
	float4 O = float4(  ColorBurn(B.r, L.r), 
						ColorBurn(B.g, L.g), 
						ColorBurn(B.b, L.b),
									   L.a);
	O.rgb *= O.a;

	return O;
}
