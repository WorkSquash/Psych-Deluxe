
//Dynamic song background according to the song...
import backend.CoolUtil;
import substates.GameOverSubstate;

var _song = PlayState.SONG;
var dir:String = '/songBackgrounds/';
var bg:FlxSprite;

function onCreate(){
	/*if(!CoolUtil.exists(Paths.image(Paths.formatToSongPath(dir +  _song.song)))){
		bg = new FlxSprite(-900, -650).loadGraphic(Paths.image(Paths.formatToSongPath(dir + 'missing')));
	}*/
	//else 
	bg = new FlxSprite(-900, -650).loadGraphic(Paths.image(Paths.formatToSongPath(dir +  _song.song)));
	
	bg.scrollFactor.set(0.9, 0.9);
	bg.scale.set(1.2, 1.2);
	bg.screenCenter();
	game.addBehindGF(bg);
}

function onCreatePost(){
	//if(_song.gameOverSound == null || _song.gameOverSound.trim().length < 1) 
	GameOverSubstate.deathSoundName = 'scream-1';
}