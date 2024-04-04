package objects; //Copied from FPS+ ...

#if sys
import sys.io.File;
#end

import lime.utils.Assets;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import flixel.text.FlxText;
import flixel.util.FlxColor;

using StringTools;
using flixel.util.FlxSpriteUtil;

class SongCaptions extends FlxSpriteGroup
{

    var text:FlxText;
    var bg:FlxSprite;

    var meta:Array<Array<String>> = [];
    var size:Float = 0;
    var fontSize:Int = 20;

    public function new(downscroll:Bool = false) {
        super();

        text = new FlxText(0, !downscroll ? 540 : 140, 0, "", fontSize);
        text.setFormat(Paths.font("notosans.ttf"), fontSize, FlxColor.WHITE, FlxTextAlign.CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        text.antialiasing = ClientPrefs.data.antialiasing && !PlayState.isPixelStage;

        bg = new FlxSprite(0, 0).makeGraphic(1, 1, FlxColor.BLACK);
        bg.alpha = 0.5;

        add(bg);
        add(text);
    }

    public function hide() visible = false;

    public function display(_text:String){
        visible = true;

        text.text = _text;
        text.screenCenter(X);

        bg.setGraphicSize(Math.floor(text.width + fontSize), Math.floor(text.height + fontSize));
        bg.updateHitbox();
        bg.y = text.y - (fontSize / 2);
        bg.screenCenter(X);

        text.text += "\n";
    }
}
