package shaders.effects;

import flixel.system.FlxAssets.FlxShader;
/*import openfl.display.Shader;
import openfl.display.ShaderInput;
import openfl.utils.Assets as OpenFlAssets;
import flixel.FlxG;
import openfl.Lib;*/


using StringTools;

class CRT extends FlxShader
{
    @:glFragmentSource('
        #pragma header
        vec2 uv = openfl_TextureCoordv.xy;
        vec2 fragCoord = openfl_TextureCoordv * openfl_TextureSize;
        vec2 iResolution = openfl_TextureSize;
        uniform float iTime;
        #define iChannel0 bitmap
        #define texture flixel_texture2D
        #define fragColor gl_FragColor

        float random(vec2 p) {
            return fract(sin(dot(p, vec2(12.9898, 78.233))) * 43758.5453);
        }

        float noise(vec2 p) {
            return random(p * iTime);
        }

        void main() {
            vec2 xy = fragCoord.xy / iResolution.xy;
            vec4 texColor = texture(iChannel0, xy);

            float gray = dot(texColor.rgb, vec3(0.299, 0.587, 0.114));
            texColor.rgb = vec3(gray);

            vec2 offset = vec2(0.003, 0.0);
            float r = texture(iChannel0, xy + offset).r;
            float b = texture(iChannel0, xy - offset).b;
            texColor = vec4(r, gray, b, texColor.a);

            float glitch = step(0.9, random(vec2(iTime * 10.0, uv.y)));
            texColor.rgb = mix(texColor.rgb, texture(iChannel0, xy + vec2(random(vec2(iTime, uv.y)) * 0.03, 0.0)).rgb, glitch);

            float scanline = 0.1 * sin(uv.y * iResolution.y * 1.5 + iTime);
            texColor.rgb -= scanline;

            texColor.rgb += noise(fragCoord.xy) * 0.015;
        
            fragColor = texColor;
        }
    ')
    public function new()
    {
        super();
    }
}

class CRTShader
{
    public var shader:CRT = new CRT();
    public function new(){
        shader.iTime.value = [0];
        PlayState.instance.shaderUpdates.push(update);
    }
    
    public function update(elapsed:Float){
        shader.iTime.value[0] += elapsed;
    }
}