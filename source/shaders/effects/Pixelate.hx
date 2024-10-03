package shaders.effects;

import flixel.system.FlxAssets.FlxShader;

class Pixelate extends FlxShader
{
	@:glFragmentSource('
		#pragma header
        #define iResolution vec3(openfl_TextureSize, 0.)
        #define iChannel0 bitmap
        #define texture flixel_texture2D

        uniform float pixelSize; 

        void mainImage(out vec4 fragColor, in vec2 fragCoord) {
            vec2 uv = fragCoord.xy / iResolution.xy;
            vec2 pixelatedUV = floor(uv * pixelSize) / pixelSize;
            fragColor = texture(iChannel0, pixelatedUV);
        }

        void main() {
            mainImage(gl_FragColor, openfl_TextureCoordv * openfl_TextureSize);
        }')
	public function new()
	{
		super();
	}
}

class PixelateShader
{
	
	public var shader:Pixelate = new Pixelate();
	public function new (size:Float){
        shader.pixelSize.value = [size];
	}
}