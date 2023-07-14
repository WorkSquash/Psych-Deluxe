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

		var option:Option = new Option('Engine Watermarks',
			"Uncheck this to hide the watermarks",
			'watermark',
			'bool',
			true);
		addOption(option);	

		var option:Option = new Option('Botplay Text:',
			"Change the botplay text",
			'botText',
			'string',
			'Deafult',
			['Default', 'Auto Play']);
		addOption(option);
		
		super();
	}

}
