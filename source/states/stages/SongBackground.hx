package states.stages;

import states.stages.objects.*;
import objects.Character;
import backend.CoolUtil;

class SongBackground extends BaseStage
{
	var bg:FlxSprite;
	override function createPost()
	{
		boyfriend.visible = false;
		gf.visible = false;
		dad.visible = false;
		defaultCamZoom = 0.495;
		//if(CoolUtil.exists(Paths.image(Paths.formatToSongPath('songBackgrounds/'+ songName)))) 
		bg = new FlxSprite(-900, 650).loadGraphic(Paths.image('songBackgrounds/' + songName));
		//else bg = new FlxSprite(-900, 650).loadGraphic(Paths.image('songBackgrounds/missing'));
		bg.scrollFactor.set(0.9, 0.9);
		bg.scale.set(1.1, 1.1);
		bg.screenCenter();
		addBehindGF(bg);
	}
}