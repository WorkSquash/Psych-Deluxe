package states.stages;

import states.stages.objects.*;
import objects.Character;
import openfl.utils.Assets;

class SongBackgroundPixel extends BaseStage
{
	var bg:FlxSprite;
	override function createPost()
	{
		boyfriend.visible = false;
		gf.visible = false;
		dad.visible = false;
			
		bg = new FlxSprite(0, 0).loadGraphic(Paths.image('songBackgrounds/${songName}-pixel'));
		bg.scrollFactor.set(0.9, 0.9);
		bg.setGraphicSize(Std.int(bg.width * 1.35), Std.int(bg.height * 1.35));
		bg.screenCenter();
		addBehindGF(bg);
	}
}