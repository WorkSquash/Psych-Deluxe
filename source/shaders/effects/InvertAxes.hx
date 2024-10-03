package shaders.effects;

import flixel.system.FlxAssets.FlxShader;

class InvertAxes extends FlxShader
{
	@:glFragmentSource('
		#pragma header
        #define iResolution vec3(openfl_TextureSize, 0.)
        uniform bool flipX;
        uniform bool flipY;
        #define iChannel0 bitmap
        #define texture flixel_texture2D

        void mainImage(out vec4 fragColor, in vec2 fragCoord) {
            vec2 uv = fragCoord.xy / iResolution.xy;
            if (flipX) uv.x = 1.0 - uv.x;
            if (flipY) uv.y = 1.0 - uv.y;
            fragColor = texture(iChannel0, uv);
        }

        void main() {
            mainImage(gl_FragColor, openfl_TextureCoordv * openfl_TextureSize);
        }')
	public function new()
	{
		super();
	}
}

class InvertAxesShader
{
	
	public var shader:InvertAxes = new InvertAxes();
	public function new (invertX:Bool, invertY:Bool){
        shader.flipX.value = [invertX];
        shader.flipY.value = [invertY];
	}
}