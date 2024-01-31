package options;

import states.LoadingState;
import states.LoadingState;
import states.MainMenuState;
import backend.StageData;

class OptionsState extends MusicBeatState
{
	var options:Array<String> = ['Gameplay', 'Graphics', 'Controls', 'Preferences', 'Note Colors'];
	private var grpOptions:FlxTypedGroup<Alphabet>;
	private static var curSelected:Int = 0;
	public static var menuBG:FlxSprite;
	public static var onPlayState:Bool = false;

	function openSelectedSubstate(label:String) {
		switch(label) {
			case 'Gameplay':
				openSubState(new options.GameplaySettingsSubState());
			case 'Graphics':
				openSubState(new options.GraphicsSettingsSubState());
			case 'Controls':
				openSubState(new options.ControlsSubState());
			case 'Preferences':
				LoadingState.loadAndSwitchState(new options.preferences.MenuSubState());
			case 'Note Colors':
				openSubState(new options.NotesSubState());
		}
	}

	var selectorLeft:Alphabet;
	var selectorRight:Alphabet;

	override function create() {
		#if desktop
		DiscordClient.changePresence("Options Menu", null);
		#end

		
		var infoShit:FlxText = new FlxText(12, FlxG.height - 44, 0, "Press Shift to customize note offset.", 12);
		infoShit.scrollFactor.set();
		infoShit.setFormat("VCR OSD Mono", 16, FlxColor.GREEN, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(infoShit);

		var bg:FlxSprite = new FlxSprite().loadGraphic(Paths.image('menuDesat'));
		bg.antialiasing = ClientPrefs.data.antialiasing;
		//bg.color = 0xFFea71fd;
		bg.color = FlxColor.WHITE;
		bg.updateHitbox();

		bg.screenCenter();
		add(bg);

		grpOptions = new FlxTypedGroup<Alphabet>();
		add(grpOptions);

		for (i in 0...options.length)
		{
			var optionText:Alphabet = new Alphabet(0, 0, options[i], true);
			optionText.screenCenter();
			optionText.y += (100 * (i - (options.length / 2))) + 50;
			grpOptions.add(optionText);
		}

		selectorLeft = new Alphabet(10, 0, '>', true);
		add(selectorLeft);
		selectorRight = new Alphabet(0, 0, ' <', true);
		//add(selectorRight);

		changeSelection();
		ClientPrefs.saveSettings();

		super.create();
	}

	override function closeSubState() {
		super.closeSubState();
		ClientPrefs.saveSettings();
	}

	override function update(elapsed:Float) {
		super.update(elapsed);

		if (controls.UI_UP_P) {
			changeSelection(-1);
		}
		if (controls.UI_DOWN_P) {
			changeSelection(1);
		}

		//if(FlxG.keys.justPressed.P) LoadingState.loadAndSwitchState(new options.OptionsStatePsych());

		if(FlxG.keys.justPressed.SHIFT) LoadingState.loadAndSwitchState(new options.NoteOffsetState());

		if (controls.BACK) {
			FlxG.sound.play(Paths.sound('cancelMenu'));
			if(onPlayState)
			{
				StageData.loadDirectory(PlayState.SONG);
				LoadingState.loadAndSwitchState(new PlayState());
				FlxG.sound.music.volume = 0;
			}
			else MusicBeatState.switchState(new MainMenuState());
		}
		else if (controls.ACCEPT) openSelectedSubstate(options[curSelected]);
	}
	
	function changeSelection(change:Int = 0) {
		curSelected += change;
		if (curSelected < 0)
			curSelected = options.length - 1;
		if (curSelected >= options.length)
			curSelected = 0;

		var bullShit:Int = 0;

		for (item in grpOptions.members) {
			item.targetY = bullShit - curSelected;
			bullShit++;

			item.alpha = 0.6;
			if (item.targetY == 0) {
				item.alpha = 1;
				selectorLeft.x = item.x - 63;
				selectorLeft.y = item.y;
				selectorRight.x = item.x + item.width + 15;
				selectorRight.y = item.y;
			}
		}
		FlxG.sound.play(Paths.sound('scrollMenu'));
	}

	override function destroy()
	{
		ClientPrefs.loadPrefs();
		super.destroy();
	}
}