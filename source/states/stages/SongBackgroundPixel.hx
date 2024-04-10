package states.stages;

import states.stages.objects.*;
import objects.Character;

class SongBackgroundPixel extends BaseStage
{
	var bg:FlxSprite;
	override function createPost()
	{
		boyfriend.visible = false;
		gf.visible = false;
		dad.visible = false;
		//bg = new FlxSprite(-900, 650).loadGraphic(Paths.image('songBackgrounds/pixel/${songName}'));
		bg = new FlxSprite(-900, 650).loadGraphic(Paths.image('songBackgrounds/${songName}-pixel'));
		bg.scrollFactor.set(0.9, 0.9);
		bg.setGraphicSize(Std.int(bg.width * 1.1));
		bg.screenCenter();
		addBehindGF(bg);
	}
}