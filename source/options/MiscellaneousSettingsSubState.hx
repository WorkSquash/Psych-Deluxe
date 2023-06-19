package options;

class MiscellaneousSettingsSubState extends BaseOptionsMenu
{
	public function new()
	{
		title = 'Miscellaneous';
		rpcTitle = 'Miscellaneous Settings Menu'; //for Discord Rich Presence
		
		#if CHECK_FOR_UPDATES
		var option:Option = new Option('Check for Updates',
			'On Release builds, turn this on to check for updates when you start the game.',
			'checkForUpdates',
			'bool',
			true);
		addOption(option);
		#end

		#if desktop
		var option:Option = new Option('Discord Rich Presence',
			"Uncheck this to prevent accidental leaks, it will hide the Application from your \"Playing\" box on Discord",
			'discordRPC',
			'bool',
			true);
		addOption(option);
		#end

		var option:Option = new Option('Freeplay Losing Icons',
			"If checked, the game will display the characters losing icon when selecting it in freeplay.",
			'losingIcons',
			'bool',
			false);
		addOption(option);

		#if html5
		var option:Option = new Option('Random Loading Screens',
			"If checked, the game will display random loading screens.",
			'randomLoading',
			'bool',
			true);
		addOption(option);
		#end

		var option:Option = new Option('Engine Watermarks',
			"Uncheck this to hide the watermarks",
			'watermarksEnabled',
			'bool',
			true);
		addOption(option);
		
		super();
	}

}
