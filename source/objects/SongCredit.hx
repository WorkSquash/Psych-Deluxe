package objects;

import haxe.io.Path;

#if sys
import sys.io.File;
import sys.FileSystem;
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

class SongCredit extends FlxSpriteGroup
{
    var size:Float = 0;
    var fontSize:Int = 20;

    public function new(_x:Float, _y:Float, _song:String) {

        super(_x, _y);
        var bg:FlxSprite;

        var text = new FlxText(0, 0, 0, '', fontSize);
        
        text.setFormat(Paths.font("vcr.tff"), fontSize, FlxColor.WHITE, FlxTextAlign.CENTER, FlxTextBorderStyle.SHADOW, FlxColor.BLACK);
        
        var creditsText = CoolUtil.exists(Paths.txt(Paths.formatToSongPath(_song + '/credits-${PlayState.SONG.variation.toLowerCase()}'))) ? 
         CoolUtil.getText(Paths.txt(Paths.formatToSongPath(_song + '/credits-${PlayState.SONG.variation.toLowerCase()}'))) : CoolUtil.getText(Paths.txt(Paths.formatToSongPath(_song + "/credits")));

        creditsText = creditsText.replace("\\n", "\n");
        
        var lines = creditsText.split('\n');
        for (i in 0...lines.length) {
            var line = lines[i].trim();
            if (i > 0) {
                text.text += "\n";
            }
            text.text += line;
        }
        
        size = text.fieldWidth;
        text.antialiasing = ClientPrefs.data.antialiasing;
        
        bg = new FlxSprite(fontSize/-2, fontSize/-2).makeGraphic(Math.floor(size + fontSize), Math.floor(text.height + fontSize), FlxColor.BLACK);
        bg.alpha = 0.75;

        add(bg);
        add(text);

        y -= size;
        visible = false;
        bg.screenCenter(X);
        text.screenCenter(X);
    }

    public function start(){
        visible = true;
        FlxTween.tween(this, {y: y + size + (fontSize/2)}, 1.5, {ease: FlxEase.sineIn, onComplete: function(twn:FlxTween){
            FlxTween.tween(this, {y: y - size - (fontSize/2)}, 1.5, {ease: FlxEase.sineOut, startDelay: 2, onComplete: function(twn:FlxTween){ this.destroy(); }});
        }});
    }
}
