package objects;

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
    var mainText:FlxText;
    var subText:FlxText;
    var bg:FlxSprite;
    var fontSize:Int = 20;

    /*var text:FlxText;
    var bg:FlxSprite;
    var fontSize:Int = 20;*/

    public function new(downscroll:Bool = false) {
        super();

        mainText = new FlxText(0, !downscroll ? 540 : 140, 0, "", fontSize);
        mainText.setFormat(Paths.font("vcr.ttf"), fontSize, FlxColor.WHITE, FlxTextAlign.CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        mainText.antialiasing = ClientPrefs.data.antialiasing && !PlayState.isPixelStage;

        subText = new FlxText(0, mainText.y + fontSize + 5, 0, "", fontSize - 4);
        subText.setFormat(Paths.font("vcr.ttf"), fontSize - 4, FlxColor.GRAY, FlxTextAlign.CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        subText.antialiasing = ClientPrefs.data.antialiasing && !PlayState.isPixelStage;

        bg = new FlxSprite(0, 0).makeGraphic(1, 1, FlxColor.BLACK);
        bg.alpha = 0.5;

        add(bg);
        add(mainText);
        add(subText);
    }

    /*public function new(downscroll:Bool = false) {
        super();

        text = new FlxText(0, !downscroll ? 540 : 140, 0, "", fontSize);
        text.setFormat(Paths.font("vcr.ttf"), fontSize, FlxColor.WHITE, FlxTextAlign.CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        text.antialiasing = ClientPrefs.data.antialiasing && !PlayState.isPixelStage;

        bg = new FlxSprite(0, 0).makeGraphic(1, 1, FlxColor.BLACK);
        bg.alpha = 0.5;

        add(bg);
        add(text);
    }*/

    public function hide() {
        visible = false;
    }

    /*public function display(_text:String) {
        visible = true;

        if (_text == "" || _text.length < 1) {
            hide();
            return;
        }

        var processedText:String = _text.replace("^", "\n");

        text.text = processedText;
        text.screenCenter(X);
    
        var lines:Array<String> = processedText.split("\n");
        var textHeight:Int = Std.int(lines.length * (fontSize + text.borderSize * 2));
    
        bg.setGraphicSize(Math.floor(text.width + fontSize), Math.floor(textHeight + fontSize));
        bg.updateHitbox();
        bg.y = text.y - (fontSize / 2);
        bg.screenCenter(X);
    }*/
    
    public function display(_text:String) {
        if (_text == "" || _text.length < 1) {
            hide();
            return;
        }

        visible = true;

        var splitText:Array<String> = _text.split("^");
        var main:String = splitText[0];
        var sub:String = splitText.length > 1 ? splitText[1] : "";

        mainText.text = main;
        mainText.screenCenter(X);

        subText.text = sub;
        subText.y = mainText.y + fontSize + 5;
        subText.screenCenter(X);

        var textHeight:Int = Std.int(fontSize + (sub != "" ? fontSize - 4 + 10 : 0));

        bg.setGraphicSize(Math.floor(Math.max(mainText.width, subText.width) + fontSize), Math.floor(textHeight + fontSize));
        bg.updateHitbox();
        bg.y = mainText.y - (fontSize / 2);
        bg.screenCenter(X);
    }
}
