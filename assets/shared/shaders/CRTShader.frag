#pragma header
vec2 uv = openfl_TextureCoordv.xy;
vec2 fragCoord = openfl_TextureCoordv * openfl_TextureSize;
vec2 iResolution = openfl_TextureSize;
uniform float iTime;
uniform bool effectEnabled;
#define iChannel0 bitmap
#define texture flixel_texture2D
#define fragColor gl_FragColor
#define mainImage main

// Random noise function
float random(vec2 p) {
    return fract(sin(dot(p, vec2(12.9898, 78.233))) * 43758.5453);
}

// Simplified noise function
float noise(vec2 p) {
    return random(p * iTime);
}

void mainImage() {
    vec2 xy = fragCoord.xy / iResolution.xy;
    vec4 texColor = texture(iChannel0, xy);

    if (effectEnabled) {
        // Desaturation using a single grayscale conversion
        float gray = dot(texColor.rgb, vec3(0.299, 0.587, 0.114));
        texColor.rgb = vec3(gray);

        // Chromatic aberration (single texture lookup for R and B channels)
        vec2 offset = vec2(0.003, 0.0);
        float r = texture(iChannel0, xy + offset).r;
        float b = texture(iChannel0, xy - offset).b;
        texColor = vec4(r, gray, b, texColor.a);

        // Horizontal glitch effect (simplified and reduced frequency)
        float glitch = step(0.9, random(vec2(iTime * 10.0, uv.y)));
        texColor.rgb = mix(texColor.rgb, texture(iChannel0, xy + vec2(random(vec2(iTime, uv.y)) * 0.03, 0.0)).rgb, glitch);

        // Scanlines (simple sine wave)
        float scanline = 0.1 * sin(uv.y * iResolution.y * 1.5 + iTime);
        texColor.rgb -= scanline;

        // Adding noise (reduced intensity)
        texColor.rgb += noise(fragCoord.xy) * 0.015;
    }

    fragColor = texColor;
}
