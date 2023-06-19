package options;

class CustomizationSubState extends BaseOptionsMenu
{
	public function new()
	{
		title = 'Customizations';
		rpcTitle = 'Customizations Menu'; //for Discord Rich Presence
		
		/*var option:Option = new Option('Visuals',
			"It does nothing.",
			'visualSettings',
			'bool',
			false);
		addOption(option);*/

		var option:Option = new Option('Note Splashes',
			"If unchecked, hitting \"Sick!\" notes won't show particles.",
			'noteSplashes',
			'bool',
			true);
		addOption(option);

		var option:Option = new Option('Pixel Note Splashes',
			"If checked, shows the pixel notesplahes in pixel stages.",
			'pixelSplash',
			'bool',
			false);
		addOption(option);

		var option:Option = new Option('Note Splash Texture:',
			"Change the appearence of the notesplash",
			'splashSkin',
			'string',
			'Default',
			['Default', 'Funkin', 'Forever', 'Impostor']);
		addOption(option);

		/*var option:Option = new Option('Forever Splash',
			"If checked, changes the notesplash texture for the forever engine one.",
			'foreverSplash',
			'bool',
			false);
		addOption(option);*/

		/*var option:Option = new Option('Funkin Splash',
			"If checked, changes the notesplash texture for the base game one.",
			'funkinSplash',
			'bool',
			false);
		addOption(option);*/

		var option:Option = new Option('Flashing Lights',
			"Uncheck this if you're sensitive to flashing lights!",
			'flashing',
			'bool',
			true);
		addOption(option);


		var option:Option = new Option('Camera Zooms',
			"If unchecked, the camera won't zoom in on a beat hit.",
			'camZooms',
			'bool',
			true);
		addOption(option);

		var option:Option = new Option('Score Text Zoom on Hit',
			"If unchecked, disables the Score text zooming\neverytime you hit a note.",
			'scoreZoom',
			'bool',
			true);
		addOption(option);

		var option:Option = new Option('Combo Stacking',
			"If unchecked, Ratings and Combo won't stack, saving on System Memory and making them easier to read",
			'comboStacking',
			'bool',
			true);
		addOption(option);


		/*var option:Option = new Option('User Interface',
			"It does nothing.",
			'uiSettings',
			'bool',
			false);
		addOption(option);*/

		var option:Option = new Option('Hide HUD',
			'If checked, hides most HUD elements.',
			'hideHud',
			'bool',
			false);
		addOption(option);

		var option:Option = new Option('Winning Icons',
			'If checked, shows the winning icons for the player and the opponent.',
			'winningIcons',
			'bool',
			false);
		addOption(option);

		var option:Option = new Option('Health Bar Colors',
			'If checked, display the player and the opponent healthbar colors.',
			'healthbarColors',
			'bool',
			false);
		addOption(option);

		var option:Option = new Option('Display Icons',
			'If unchecked, the does not display the player and the opponent health icons.',
			'displayIcons',
			'bool',
			true);
		addOption(option);
		
		var option:Option = new Option('Time Bar:',
			"What should the Time Bar display?",
			'timeBarType',
			'string',
			'Time Left',
			['Time Left', 'Time Elapsed', 'Song Name', 'Disabled']);
		addOption(option);

		var option:Option = new Option('Health Bar Transparency',
			'How much transparent should the health bar and icons be.',
			'healthBarAlpha',
			'percent',
			1);
		option.scrollSpeed = 1.6;
		option.minValue = 0.0;
		option.maxValue = 1;
		option.changeValue = 0.1;
		option.decimals = 1;
		addOption(option);
		
		#if !mobile
		var option:Option = new Option('FPS Counter',
			'If unchecked, hides FPS Counter.',
			'showFPS',
			'bool',
			true);
		addOption(option);
		option.onChange = onChangeFPSCounter;
		#end
		
		/*var option:Option = new Option('Audio',
			"It does nothing.",
			'audioSettings',
			'bool',
			false);
		addOption(option);*/
		
		
		var option:Option = new Option('Pause Screen Song:',
			"What song do you prefer for the Pause Screen?",
			'pauseMusic',
			'string',
			'Tea Time',
			['None', 'Breakfast', 'Tea Time']);
		addOption(option);
		option.onChange = onChangePauseMusic;
		

		
		super();
	}

	var changedMusic:Bool = false;
	function onChangePauseMusic()
	{
		if(ClientPrefs.data.pauseMusic == 'None')
			FlxG.sound.music.volume = 0;
		else
			FlxG.sound.playMusic(Paths.music(Paths.formatToSongPath(ClientPrefs.data.pauseMusic)));

		changedMusic = true;
	}

	override function destroy()
	{
		if(changedMusic) FlxG.sound.playMusic(Paths.music('freakyMenu'));
		super.destroy();
	}

	#if !mobile
	function onChangeFPSCounter()
	{
		if(Main.fpsVar != null)
			Main.fpsVar.visible = ClientPrefs.data.showFPS;
	}
	#end
}
