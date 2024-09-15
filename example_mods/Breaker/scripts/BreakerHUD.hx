//imports no touchie
import haxe.ds.StringMap;
import flixel.util.FlxStringUtil;
import flixel.text.FlxText;
import flixel.text.FlxTextBorderStyle;
import openfl.text.TextFormat;
import flixel.text.FlxTextFormatMarkerPair;
import flixel.text.FlxTextFormat;
import backend.CoolUtil;
import objects.Bar;
import states.MainMenuState;
import StringTools;

//Settings
var settings:Map<String,Dynamic> = [
	"vertical-healthBar" => true,
	"classic-healthBar" => true,
	"show-timeBar" => true,
	"show-watermark" => true,
	"show-engineText" => true,
	"timeTxt-style" => 'breaker-extended', //Options are default, breaker ore breaker-extended
];

//Variables
var _song = PlayState.SONG;
var breakerTxt:FlxText = null;
var breakerVer:String = CoolUtil.getText(Paths.txt('modVersion'));
var engineFormat:FlxTextFormat = new FlxTextFormat(0xFFFF0000, true);

//Functions
function onCreatePost(){
	breakerTxt = new FlxText(10, FlxG.height - 45, FlxG.width, "", 18);
	breakerTxt.setFormat(Paths.font("vcr.ttf"), 18, 0xFFFFFFFF, 'left');
	breakerTxt.setBorderStyle(game.scoreTxt.borderStyle, 0xFF000000, 2);
	breakerTxt.borderSize = 1.25;
	breakerTxt.text = "Project Breaker: " + breakerVer;
	if(settings["show-engineText"])breakerTxt.text += "\nRunning on $Psych Deluxe$: " + MainMenuState.deluxeVer;
	breakerTxt.applyMarkup(breakerTxt.text, [new FlxTextFormatMarkerPair(engineFormat, "$")]);
	breakerTxt.camera = game.camHUD;
	if(settings["show-watermark"])game.add(breakerTxt);
	if(settings["vertical-healthBar"]){
		game.healthBar.angle = -90;
		game.healthBar.x = 630;
		game.healthBar.y = 355;
	}
	if(settings["classic-heatlhBar"]) game.healthBar.setColors(0xFFFF0000, 0xFF00FF00);
    game.iconP1.visible = false;
    game.iconP2.visible = false;
    game.timeTxt.visible = true;
	game.timeTxt.size = 16.35;
	game.timeTxt.y = FlxG.height - 25;
    game.timeBar.visible = settings['show-timeBar'];
	game.timeBar.y = timeTxt.y + 3;
	game.scoreTxt.y = 20;
}

function onUpdatePost(elapsed:Float) {
    if(!game.paused && game.updateTime)
	{
		var curTime:Float = Math.max(0, Conductor.songPosition - ClientPrefs.data.noteOffset);
		var songPercent = (curTime / songLength);
		var songCalc:Float = (songLength - curTime) / playbackRate;
		var secondsTotal:Int = Math.floor(songCalc / 1000);
		if(secondsTotal < 0) secondsTotal = 0;
		switch(settings['timeTxt-style'].toLowerCase())
		{
			case 'breaker':
				timeTxt.text = _song.song 
				+ ' - ' 
				+ FlxStringUtil.formatTime(secondsTotal, false);
			case 'breaker-extended':
				timeTxt.text = _song.song 
				+ ' - ' 
				+ FlxStringUtil.formatTime(secondsTotal, false) 
				+ ' / ' 
				+ FlxStringUtil.formatTime((songLength / 1000 / playbackRate));
			default:
				return;
		}
	}
}