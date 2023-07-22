package options;

class VisualSettingsSubState extends BaseOptionsMenu
{

	public function new()
	{
		title = 'Visual Settings';
		rpcTitle = 'Visual Settings Menu'; //for Discord Rich Presence

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

		var option:Option = new Option('Note Splashes Texture',
			"Change the appearence of the note splashes",
			'splashSkin',
			'string',
			'Vanilla',
			['Vanilla', "Psych", 'Forever', 'Impostor', 'Diamond']);
		addOption(option);

		var option:Option = new Option('Note Splashes Framerate',
        'Changes the animation framerate for the notesplash.',
        'splashFramerate',
        'int',
        30);
        addOption(option);
        option.minValue = 1;
        option.maxValue = 75;
		option.displayFormat = '%v FPS';
        //option.changeValue = 1;
        //option.decimals = 1;

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

    	#if html5
		var option:Option = new Option('Random Loading Screens',
			"If checked, the game will display random loading screens.",
			'randomLoading',
			'bool',
			true);
		addOption(option);
		#end
        
		super();
	}
}
