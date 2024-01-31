package options.preferences;

import objects.Alphabet;

class UISettingsSubState extends BaseOptionsMenu
{
	public function new()
	{
		title = 'UI';
		rpcTitle = 'UI Settings Menu'; //for Discord Rich Presence


		var option:Option = new Option('Hide HUD',
			'If checked, hides most HUD elements.',
			'hideHud',
			'bool');
		addOption(option);

		var option:Option = new Option('Vertical UI',
			'Changes the UI to be vertical',
			'verticalUI',
			'bool');
		addOption(option);

		var option:Option = new Option('Statistics',
			'If checked, shows the statistics text.\nDisables the score text!',
			'showStatistics',
			'bool');
		addOption(option);

		/*var option:Option = new Option('System Information',
			"If checked, shows the system's current time and operating system",
			'systemInfo',
			'bool');
		addOption(option);*/
		
		var option:Option = new Option('Time Bar:',
			"What should the Time Bar display?",
			'timeBarType',
			'string',
			['Time Left', 'Time Elapsed', 'Song Name', 'Disabled']);
		addOption(option);

		var option:Option = new Option('Health Bar Opacity',
			'How much transparent should the health bar and icons be.',
			'healthBarAlpha',
			'percent');
		option.scrollSpeed = 1.6;
		option.minValue = 0.0;
		option.maxValue = 1;
		option.changeValue = 0.1;
		option.decimals = 1;
		addOption(option);

		super();
	}
}
