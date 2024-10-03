package psychlua;

import flixel.system.FlxAssets.FlxShader;
//Add Shaders herey

import shaders.effects.InvertAxes;
import shaders.effects.InvertColors;
import shaders.effects.Snowfall;
import shaders.effects.Pixelate;
import shaders.effects.CRT;
import shaders.effects.ChromaticAberration;
import shaders.effects.Scanline;


class EffectFunctions
{
	public static function implement(funk:FunkinLua)
	{
        var lua = funk.lua;
		
		Lua_helper.add_callback(lua, "ChromaticAbberation", function(camera:String,chromeOffset:Float = 0.005) {
			PlayState.instance.addShaderToCamera(camera, new ChromaticAberrationShader(chromeOffset));
		});
		
		Lua_helper.add_callback(lua, "Scanline", function(camera:String, lockAlpha:Bool = false) {
			PlayState.instance.addShaderToCamera(camera, new ScanlineShader(lockAlpha));
		});
		
		Lua_helper.add_callback(lua, "CRT", function(camera:String) {
			PlayState.instance.addShaderToCamera(camera, new CRTShader());
		});
		
		Lua_helper.add_callback(lua, "Pixelate", function(camera:String, pixelSize:Float = 15.0) {
			PlayState.instance.addShaderToCamera(camera, new PixelateShader(pixelSize));
		});
		
		Lua_helper.add_callback(lua, "InvertColors", function(camera:String, lockAlpha = false) {
			PlayState.instance.addShaderToCamera(camera, new InvertColorsShader(lockAlpha));
		});
		
		Lua_helper.add_callback(lua, "InvertAxes", function(camera:String, invertX:Bool = true, invertY:Bool = true) {
			PlayState.instance.addShaderToCamera(camera, new InvertAxesShader(invertX, invertY));
		});
		
		Lua_helper.add_callback(lua, "Snowfall", function(camera:String, isEvil:Bool = false) {
			PlayState.instance.addShaderToCamera(camera, new SnowfallShader(isEvil));
		});

		Lua_helper.add_callback(lua, "InvertX", function(camera:String) {
			PlayState.instance.addShaderToCamera(camera, new InvertAxesShader(true, false));
		});

		Lua_helper.add_callback(lua, "InvertY", function(camera:String) {
			PlayState.instance.addShaderToCamera(camera, new InvertAxesShader(false, true));
		});

		Lua_helper.add_callback(lua, "clearShaders", function(camera:String) {
			PlayState.instance.clearShaderFromCamera(camera);
		});

		Lua_helper.add_callback(lua, "removeShader", function(camera:String, shader:Dynamic) {
			PlayState.instance.removeShaderFromCamera(camera, shader);
		});

	}
}