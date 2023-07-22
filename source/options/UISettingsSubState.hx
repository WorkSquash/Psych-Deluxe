package options;

class UISettingsSubState extends BaseOptionsMenu
{

	public function new()
	{
		title = 'UI Settings';
		rpcTitle = 'UI Settings Menu'; //for Discord Rich Presence

		var option:Option = new Option('Display Icons',
		'If unchecked, the does not display the player and the opponent health icons.',
		'displayIcons',
		'bool',
		true);
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
		
		
		var option:Option = new Option('Time Bar:',
			"What should the Time Bar display?",
			'timeBarType',
			'string',
			'Time Left',
			['Time Left', 'Time Elapsed', 'Song Name', 'Disabled']);
		addOption(option);

		var option:Option = new Option('Time Bar Color:',
			"How should the timebar colors look like?",
			'timeBarColor',
			'string',
			'White',
			['White', 'Rainbow', 'Random', 'Healthicon']);
		addOption(option);

		var option:Option = new Option('Hide HUD',
			'If checked, hides most HUD elements.',
			'hideHud',
			'bool',
			false);
		addOption(option);

		var option:Option = new Option('Song Information',
			'If checked, displays the current songs information.\nDisplayname, Artist, etc.',
			'songInfo',
			'bool',
			false);
		addOption(option);

		var option:Option = new Option('Judgement Counter',
			'If checked, show how much sicks, goods, bads and shits you hit',
			'judgementCounter',
			'bool',
			false);
		addOption(option);

		var option:Option = new Option('Judgement Counter Position:',
			"Changes the score text",
			'judgementPosition',
			'string',
			'Left',
			['Left', 'Right']);
		addOption(option);

		var option:Option = new Option('Score Text:',
			"Changes the score text",
			'scoreText',
			'string',
			'Psych',
			['Vanilla', 'Psych', 'Disabled']);
		addOption(option);
		
		
		var option:Option = new Option('Botplay Text:',
			"Changes the botplay text",
			'botText',
			'string',
			'Deafult',
			['Default', 'Auto Play']);
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

		super();
	}

	#if !mobile
	function onChangeFPSCounter()
	{
		if(Main.fpsVar != null)
			Main.fpsVar.visible = ClientPrefs.data.showFPS;
	}
	#end

}
