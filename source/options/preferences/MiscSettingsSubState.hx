package options.preferences;

import objects.Alphabet;

class MiscSettingsSubState extends BaseOptionsMenu
{
	public function new()
	{
		title = 'Miscellaneous Settings';
		rpcTitle = 'Miscellaneous Settings Menu'; //for Discord Rich Presence
		
		#if !mobile
		var option:Option = new Option('FPS Counter',
			'If unchecked, hides FPS Counter.',
			'showFPS',
			'bool');
		addOption(option);
		option.onChange = onChangeFPSCounter;
		#end
		#if desktop
		var option:Option = new Option('Show Debug Information',
			"If checked, shows some debug informations like memory usage, current operating system and the processing time.",
			'enableDebug',
			'bool');
		addOption(option);

		var option:Option = new Option('Extend Debug Information',
			"If checked, shows some debug informations like engine version, current mod directory.",
			'extendDebug',
			'bool');
		addOption(option);
		#end

		#if CHECK_FOR_UPDATES
		var option:Option = new Option('Check for Updates',
			'On Release builds, turn this on to check for updates when you start the game.',
			'checkForUpdates',
			'bool');
		addOption(option);
		#end

		#if desktop
		var option:Option = new Option('Discord Rich Presence',
			"Uncheck this to prevent accidental leaks, it will hide the Application from your \"Playing\" box on Discord",
			'discordRPC',
			'bool');
		addOption(option);
		#end

		var option:Option = new Option('Dynamic Flashing',
			"If checked, hitting a  note while having a combo of 25 and above flashes the screen. \nAlso makes the screen flash when you miss a note.",
			'noteFlash',
			'bool');
		addOption(option);

		var option:Option = new Option('Watermarks',
			"If checked, watermarks will be shown",
			'watermarks',
			'bool');
		addOption(option);

		super();
	}
}


#if !mobile
function onChangeFPSCounter()
{
	if(Main.fpsVar != null)
		Main.fpsVar.visible = ClientPrefs.data.showFPS;
	}
#end