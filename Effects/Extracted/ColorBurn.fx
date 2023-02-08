sampler2D img;
sampler2D bkd : register(s1);

float4 ps_main(in float2 In : TEXCOORD0) : COLOR0	{
	float4 L = tex2D(img,In);
	float4 B = tex2D(bkd,In);
	float4 O = L==0.0?0.0:saturate((1.0-((1.0-B)/L)));
	O.a = 1.0; // Apparently
	return O;
}

technique tech_main	{ pass P0 { PixelShader = compile ps_2_0 ps_main(); }  }