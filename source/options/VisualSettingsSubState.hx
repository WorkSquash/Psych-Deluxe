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

		var option:Option = new Option('Note Splash Texture:',
			"Change the appearence of the notesplash",
			'splashSkin',
			'string',
			'Default',
			['Default', "Funkin'", 'Forever', 'Impostor', 'Diamond']);
		addOption(option);

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


        var option:Option = new Option('Philly Stage Colors:',
        "Change the appearence of the philly stage colors",
        'phillyColors',
        'string',
        'Deafult',
        ['Default', 'Deluxe', 'White']);
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
