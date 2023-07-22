package objects;

import shaders.ColorSwap;
import flixel.system.FlxAssets.FlxShader;
import states.PlayState;
import objects.Note;

class NoteSplash extends FlxSprite
{
	public var colorSwap:ColorSwap = null;
	private var idleAnim:String;
	private var textureLoaded:String = null;
	var skin:String;
	var splashFPS:Int = ClientPrefs.data.splashFramerate;
	public function new(x:Float = 0, y:Float = 0, ?note:Int = 0) {
		super(x, y);
		skin = '';	
		if(PlayState.SONG.splashSkin != null && PlayState.SONG.splashSkin.length > 0) skin = PlayState.SONG.splashSkin;

		loadAnims(skin);
		
		colorSwap = new ColorSwap();
		shader = colorSwap.shader;

		setupNoteSplash(x, y, note);
	}

	public function setupNoteSplash(x:Float, y:Float, note:Int = 0, texture:String = null, hueColor:Float = 0, satColor:Float = 0, brtColor:Float = 0) {
		setPosition(x - Note.swagWidth * 0.95, y - Note.swagWidth);
		alpha = FlxG.random.float(0.55,0.75);

		if(texture == null && ClientPrefs.data.splashSkin == 'Psych') {
			texture = 'note_splashes/psych';
			if(PlayState.SONG.splashSkin != null && PlayState.SONG.splashSkin.length > 0) texture = PlayState.SONG.splashSkin;
			if(PlayState.isPixelStage && ClientPrefs.data.pixelSplash) texture = 'pixelUI/note_splashes/psych';
		}

		if(ClientPrefs.data.splashSkin == "Vanilla") {
			texture = 'note_splashes/vanilla';
			if(PlayState.SONG.splashSkin != null && PlayState.SONG.splashSkin.length > 0) texture = PlayState.SONG.splashSkin;
			if(PlayState.isPixelStage && ClientPrefs.data.pixelSplash) texture = 'pixelUI/note_splashes/vanilla';
		}


		if(ClientPrefs.data.splashSkin == 'Forever') {
			texture = 'note_splashes/forever';
			if(PlayState.SONG.splashSkin != null && PlayState.SONG.splashSkin.length > 0) texture = PlayState.SONG.splashSkin;
			if(PlayState.isPixelStage && ClientPrefs.data.pixelSplash) texture = 'pixelUI/note_splashes/forever';
		}

		if(ClientPrefs.data.splashSkin == 'Impostor') {
			texture = 'note_splashes/impostor';
			if(PlayState.SONG.splashSkin != null && PlayState.SONG.splashSkin.length > 0) texture = PlayState.SONG.splashSkin;
			if(PlayState.isPixelStage && ClientPrefs.data.pixelSplash) texture = 'pixelUI/note_splashes/impostor';
		}

		if(ClientPrefs.data.splashSkin == 'Diamond') {
			texture = 'note_splashes/diamond';
			if(PlayState.SONG.splashSkin != null && PlayState.SONG.splashSkin.length > 0) texture = PlayState.SONG.splashSkin;
			if(PlayState.isPixelStage && ClientPrefs.data.pixelSplash) texture = 'pixelUI/note_splashes/diamond';
		}
		

		if(textureLoaded != texture) {
			loadAnims(texture);
		}
		colorSwap.hue = hueColor;
		colorSwap.saturation = satColor;
		colorSwap.brightness = brtColor;
		offset.set(10, PlayState.STRUM_X -15);

		if(ClientPrefs.data.splashSkin == "Vanilla") {
			offset.set(-10.75, PlayState.STRUM_X - y);
			if(ClientPrefs.data.downScroll) {
				offset.set(-10.75, PlayState.STRUM_X - 50);
			}
		}

		if(ClientPrefs.data.splashSkin == 'Diamond') {
			offset.set(10, PlayState.STRUM_X - y);
			if(ClientPrefs.data.downScroll) {
				offset.set(10, PlayState.STRUM_X - 55);
			}
		}

		//if(ClientPrefs.data.splashSkin == 'Diamond')offset.set(width * 0.3, height);

		var animNum:Int = FlxG.random.int(1, 2);
		animation.play('note' + note + '-' + animNum, true);
		if(animation.curAnim != null)animation.curAnim.frameRate = splashFPS; //+ FlxG.random.int(-2, 2);
		//if (ClientPrefs.data.splashSkin == 'Forever' || PlayState.isPixelStage)animation.curAnim.frameRate = 15;
	}

	function loadAnims(skin:String) {
		frames = Paths.getSparrowAtlas(skin);
	
		for (i in 1...3) {
			animation.addByPrefix("note1-" + i, "note splash blue " + i, 30, false);
			animation.addByPrefix("note2-" + i, "note splash green " + i, 30, false);
			animation.addByPrefix("note0-" + i, "note splash purple " + i, 30, false);
			animation.addByPrefix("note3-" + i, "note splash red " + i, 30, false);
		}	
	}

	override function update(elapsed:Float) {
		if(animation.curAnim != null)if(animation.curAnim.finished) kill();

		super.update(elapsed);
	}
}
