package;

#if android
import android.content.Context;
#end

import debug.FPSCounter;
import flixel.graphics.FlxGraphic;
import flixel.FlxGame;
import flixel.FlxState;
import haxe.io.Path;
import openfl.Assets;
import openfl.Lib;
import openfl.display.Sprite;
import openfl.events.Event;
import openfl.display.StageScaleMode;
import lime.app.Application;
import states.TitleState;

#if linux
import lime.graphics.Image;
#end

// Crash handler stuff
#if CRASH_HANDLER
import openfl.events.UncaughtErrorEvent;
import haxe.CallStack;
import haxe.io.Path;
#end

#if linux
@:cppInclude('./external/gamemode_client.h')
@:cppFileCode('
    #define GAMEMODE_AUTO
')
#end

class Main extends Sprite
{
    var game = {
        width: 1280, // WINDOW width
        height: 720, // WINDOW height
        initialState: TitleState, // initial game state
        zoom: -1.0, // game state bounds
        framerate: 60, // default framerate
        skipSplash: #if debug true, #else false, #end // if the default flixel splash screen should be skipped
        startFullscreen: false // if the game should start in fullscreen mode
    };

    public static var fpsVar:FPSCounter;

    public function new()
    {
        super();

        // Credits to MAJigsaw77 (he's the original author for this code)
        #if android
        Sys.setCwd(Path.addTrailingSlash(Context.getExternalFilesDir()));
        #elseif ios
        Sys.setCwd(lime.system.System.applicationStorageDirectory);
        #end

        if (stage != null)
        {
            init();
        }
        else
        {
            addEventListener(Event.ADDED_TO_STAGE, init);
        }
    }

    private function init(?E:Event):Void
    {
        if (hasEventListener(Event.ADDED_TO_STAGE))
        {
            removeEventListener(Event.ADDED_TO_STAGE, init);
        }
		//Check for windows version
		#if windows checkWindowsVersion();  #end

        setupGame();
    }

    private function setupGame():Void
    {
        var stageWidth:Int = Lib.current.stage.stageWidth;
        var stageHeight:Int = Lib.current.stage.stageHeight;

        if (game.zoom == -1.0)
        {
            var ratioX:Float = stageWidth / game.width;
            var ratioY:Float = stageHeight / game.height;
            game.zoom = Math.min(ratioX, ratioY);
            game.width = Math.ceil(stageWidth / game.zoom);
            game.height = Math.ceil(stageHeight / game.zoom);
        }

        #if LUA_ALLOWED
        Lua.set_callbacks_function(cpp.Callable.fromStaticFunction(psychlua.CallbackHandler.call));
        #end

        Controls.instance = new Controls();
        ClientPrefs.loadDefaultKeys();
        
        #if ACHIEVEMENTS_ALLOWED
        Achievements.load();
        #end
        
        addChild(new FlxGame(game.width, game.height, game.initialState, #if (flixel < "5.0.0") game.zoom, #end game.framerate, game.framerate, game.skipSplash, game.startFullscreen));

        #if !mobile
        fpsVar = new FPSCounter(10, 3, 0xFFFFFF);
        addChild(fpsVar);
        Lib.current.stage.align = "tl";
        Lib.current.stage.scaleMode = StageScaleMode.NO_SCALE;
        if(fpsVar != null) {
            fpsVar.visible = ClientPrefs.data.showFPS;
            if(FlxG.keys.justPressed.TAB) fpsVar.visible = !fpsVar.visible;
        }
        #end

        #if linux
        var icon = Image.fromFile("icon.png");
        Lib.current.stage.window.setIcon(icon);
        #end

        #if html5
        FlxG.autoPause = false;
        FlxG.mouse.visible = false;
        #end
        
        #if CRASH_HANDLER
        Lib.current.loaderInfo.uncaughtErrorEvents.addEventListener(UncaughtErrorEvent.UNCAUGHT_ERROR, onCrash);
        #end

        #if DISCORD_ALLOWED
        DiscordClient.prepare();
        #end

        // Shader coords fix
        FlxG.signals.gameResized.add(function (w, h) {
            if (FlxG.cameras != null) {
                for (cam in FlxG.cameras.list) {
                    if (cam != null && cam.filters != null)
                        resetSpriteCache(cam.flashSprite);
                }
            }

            if (FlxG.game != null)
                resetSpriteCache(FlxG.game);
        });
    }

    static function resetSpriteCache(sprite:Sprite):Void {
        @:privateAccess {
            sprite.__cacheBitmap = null;
            sprite.__cacheBitmapData = null;
        }
    }

    #if CRASH_HANDLER
	function onCrash(e:UncaughtErrorEvent):Void
	{
		var errMsg:String = "";
		var callStack:Array<StackItem> = CallStack.exceptionStack(true);
		var dateNow:String = Date.now().toString();

		dateNow = dateNow.replace(" ", "_");
		dateNow = dateNow.replace(":", "'");

		var errorMessage:String = "Uncaught Error: " + e.error;

		createCrashDump(errorMessage, callStack);

		Application.current.window.alert(errorMessage, "Error!");
		#if DISCORD_ALLOWED
		DiscordClient.shutdown();
		#end
		Sys.exit(1);
	}
    #end

	
	static function checkWindowsVersion():Void
	#if windows 
	{
		var version:String = Sys.getEnv("OS");
		if (version != null && version.indexOf("Windows_NT") != -1)
		{
			var versionInfo = Sys.getEnv("OS_VERSION");
			if (versionInfo != null)
			{
				var majorVersion = Std.parseInt(versionInfo.substring(0, versionInfo.indexOf(".")));
				if (majorVersion < 10)
				{
					createCrashDump("
					Unsupported Windows Version Error\n
					The application has detected an unsupported version of Windows.\n
					This application requires Windows 10 or later to run.");
					Sys.exit(1);
				}
			}
		}
	}
	#else 
	return;
	#end

	static function createCrashDump(errorMessage:String, ?callStack:Array<StackItem>):Void
	{
		var errMsg:String = "";
		var path:String;
		var dateNow:String = Date.now().toString();

		dateNow = dateNow.replace(" ", "_");
		dateNow = dateNow.replace(":", "'");

		path = "./crash/" + "Psych_Deluxe_" + dateNow + ".txt";

		errMsg += errorMessage + "\n";

		for (stackItem in callStack)
		{
			switch (stackItem)
			{
				case FilePos(s, file, line, column):
					errMsg += file + " (line " + line + ")\n";
				default:
					errMsg += stackItem + "\n";
			}
		}

		errMsg += "\nCrash Handler written by: sqirra-rng";

		if (!FileSystem.exists("./crash/"))
			FileSystem.createDirectory("./crash/");

		File.saveContent(path, errMsg + "\n");

		Sys.println(errMsg);
		Sys.println("Crash dump saved in " + Path.normalize(path));
	}
}
