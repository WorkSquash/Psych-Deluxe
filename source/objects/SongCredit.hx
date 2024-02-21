//Literally 'Borrowed' from  FPS+ Source with little modificstions

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

import backend.Song;

using StringTools;
using flixel.util.FlxSpriteUtil;

class SongCredit extends FlxSpriteGroup
{
    var meta:Array<Array<String>> = [];
    var size:Float = 0;
    var fontSize:Int = 20;
    var meta_exists:Bool = false;

    public function new(_x:Float, _y:Float, _song:String) {

        super(_x, _y);
        var bg:FlxSprite;

        var text = new FlxText(0, 0, 0, '', fontSize);
        //if(PlayState.isPixelStage) text.setFormat(Paths.font('pixel.otf'), 15, FlxColor.WHITE, FlxTextAlign.LEFT, FlxTextBorderStyle.OUTLINE_FAST, FlxColor.BLACK);
        text.setFormat(Paths.font("vcr.tff"), fontSize, FlxColor.WHITE, FlxTextAlign.LEFT, FlxTextBorderStyle.SHADOW, FlxColor.BLACK);
        
        
        //if(CoolUtil.exists(Paths.txt(Paths.formatToSongPath(_song + "/credits"))))
        text.text = CoolUtil.getText(Paths.txt(Paths.formatToSongPath(_song + "/credits")));
        //else 
            //text.text = _song + 'By: Kawaii Sprite'; //Should default to current songname and artist
        size = text.fieldWidth;
        
        text.antialiasing = ClientPrefs.data.antialiasing && !PlayState.isPixelStage;
        
        bg = new FlxSprite(fontSize/-2, fontSize/-2).makeGraphic(Math.floor(size + fontSize), Math.floor(text.height + fontSize), FlxColor.BLACK);
        bg.alpha = 0.75;

        //text.text += "\n";

        add(bg);
        add(text);

        x -= size;
        visible = false;
        
    }



    public function start(){
        visible = true;
        FlxTween.tween(this, {x: x + size + (fontSize/2)}, 1, {ease: FlxEase.quintOut, onComplete: function(twn:FlxTween){
            FlxTween.tween(this, {x: x - size}, 1, {ease: FlxEase.quintIn, startDelay: 2, onComplete: function(twn:FlxTween){ this.destroy(); }});
        }});

    }
}
