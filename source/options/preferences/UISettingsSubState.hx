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

		var option:Option = new Option('Vertical Healthbar',
			'Makes the healthbar vertical',
			'verticalUI',
			'bool');
		addOption(option);

		var option:Option = new Option('Judgement Counter',
			'If checked, shows the Judgement Counter.',
			'judgementCounter',
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
			['Disabled', 'Time Left', 'Time Elapsed', 'Song Name']);
		addOption(option);

		var option:Option = new Option('Icon Bop:',
			"Changes how the icons bop to the beat.",
			'iconBop',
			'string',
			['Default', 'Deluxe']);
		addOption(option);

		var option:Option = new Option('Healthbar Position:',
			"Changes the vertical healthbars position.",
			'healthPos',
			'string',
			['Left', 'Right']);
		addOption(option);

		var option:Option = new Option('Judgement Counter Position:',
			"Changes the judgement counters position.",
			'judgementPos',
			'string',
			['Left', 'Right']);
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
