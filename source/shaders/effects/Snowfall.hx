package shaders.effects;

import flixel.system.FlxAssets.FlxShader;
/*import openfl.display.Shader;
import openfl.display.ShaderInput;
import openfl.utils.Assets as OpenFlAssets;
import flixel.FlxG;
import openfl.Lib;*/


using StringTools;

class Snowfall extends FlxShader
{
    // Automatically converted with https://github.com/TheLeerName/ShadertoyToFlixel
    // https://www.shadertoy.com/view/lftGDl
    @:glFragmentSource('
    #pragma header

    #define iResolution vec3(openfl_TextureSize, 0.)
    uniform float iTime;
    uniform bool isEvil;
    #define iChannel0 bitmap
    #define texture flixel_texture2D

    // Random noise function
    float random(vec2 uv) {
        return fract(sin(dot(uv, vec2(135.0, 263.0))) * 10000.0);
    }

    // Function to draw snowflakes
    vec4 drawSnow(vec2 curid, vec2 uv, vec4 fragColor, float r, float layer) {
        float maxoff = 2.0 / 20.0;
        float windStrength = sin(iTime * 0.5 + layer * 2.0) * 0.05 * layer;
        vec3 snowColor = isEvil ? vec3(0.75, 0.25, 0.25) : vec3(1.0);

        for (int x = -2; x <= 1; x++) {
            for (int y = -2; y <= 0; y++) {
                vec2 id = curid + vec2(x, y);
                vec2 pos = id / 20.0;
                pos += vec2(mod(random(pos), maxoff), mod(random(pos + vec2(4.0, 3.0)), maxoff));
                float rad = r * mod(random(pos), 1.0) / (20.0 * 5.0);
                pos.x += windStrength + 0.5 * (maxoff - mod(random(pos), maxoff)) * sin(iTime * r + random(pos) * 100.0);
                float v = smoothstep(0.0, 1.0, (rad - length(uv - pos)) / rad * 0.75);
                fragColor = mix(fragColor, vec4(snowColor * (0.9 + 0.1 * sin(layer * pos.y * 100.0)), 1.0), v);
            }
        }
        return fragColor;
    }

    void mainImage(out vec4 fragColor, in vec2 fragCoord) {
        vec2 uv = fragCoord.xy / iResolution.xy;
        vec2 uvog = fragCoord.xy / iResolution.y;
        fragColor = texture(iChannel0, uv);

        // Invert the y-coordinate for the snowflakes
        uvog.y = 1.0 - uvog.y;

        for (float layer = 1.0; layer <= 3.0; layer += 1.0) {
            vec2 offset = 0.1 * layer * vec2(sin(iTime * 0.1 * layer), iTime);
            vec2 curid = floor((uvog + offset) * 20.0) + vec2(0.5);
            fragColor += drawSnow(curid, uvog + offset, vec4(0), 1.0 / layer, layer);
        }
    }

    void main() {
        mainImage(gl_FragColor, openfl_TextureCoordv * openfl_TextureSize);
    }')

    public function new()
    {
        super();
    }
}

class SnowfallShader
{
    public var shader:Snowfall = new Snowfall();
    public function new(isEvil:Bool){
        shader.iTime.value = [0];
        shader.isEvil.value = [isEvil];
        PlayState.instance.shaderUpdates.push(update);
    }
    
    public function update(elapsed:Float){
        shader.iTime.value[0] += elapsed;
    }
}
