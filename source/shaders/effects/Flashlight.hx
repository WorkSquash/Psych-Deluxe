package shaders.effects;

import flixel.system.FlxAssets.FlxShader;


using StringTools;
// https://www.shadertoy.com/view/3dffzM

class Flashlight extends FlxShader
{
    @:glFragmentSource('
        #pragma header

        #define iResolution vec3(openfl_TextureSize, 0.)
        uniform float iTime;
        #define iChannel0 bitmap
        #define texture flixel_texture2D

        uniform vec4 iMouse;

        const float exposure = 3.;
        const float AOE = 7.5;

        vec2 MouseXY()
        {
            return iMouse.xy / iResolution.xy; 
        }

        void mainImage( out vec4 fragColor, in vec2 fragCoord )
        {
            vec2 uv = fragCoord/iResolution.xy;
            
            vec2 mouse = MouseXY();
            
            float d = distance(uv, mouse);
            d = exp(-(d * AOE)) * exposure;
            
            fragColor = vec4(vec3(0.f) ,texture(iChannel0, uv).a);
            
            fragColor.rgb += texture(iChannel0, uv).rgb * d;
        }

        void main() {
            mainImage(gl_FragColor, openfl_TextureCoordv*openfl_TextureSize);
        }
    ')
    public function new()
    {
        super();
    }
}

class FlashlightShader
{
    public var shader:Flashlight = new Flashlight();
    public function new(){
        shader.iTime.value = [0];
        PlayState.instance.shaderUpdates.push(update);
    }
    
    public function update(elapsed:Float){
        shader.iTime.value[0] += elapsed;
    }
}