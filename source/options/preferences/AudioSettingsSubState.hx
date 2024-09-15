package options.preferences;

import objects.Alphabet;

class AudioSettingsSubState extends BaseOptionsMenu
{
	public function new()
	{
		title = 'Audio';
		rpcTitle = 'Audio Settings Menu'; //for Discord Rich Presence


		var pauseMusic:Array<String> = Mods.mergeAllTextsNamed('music/pause_menu/tracks.txt', 'shared');
		if(pauseMusic.length > 0)
		{
			if(!pauseMusic.contains(ClientPrefs.data.pauseMusic))
				ClientPrefs.data.pauseMusic = ClientPrefs.defaultData.pauseMusic;

			pauseMusic.insert(0, ClientPrefs.defaultData.pauseMusic);
			pauseMusic.insert(pauseMusic.length + 1, 'None');
			var option:Option = new Option('Pause Screen Song:\n',
				"What song do you prefer for the Pause Screen?",
				'pauseMusic',
				'string',
				pauseMusic);
			option.onChange = onChangePauseMusic;
			addOption(option);
		}
		
		var hitsounds:Array<String> = Mods.mergeAllTextsNamed('hitsounds/list.txt', 'shared');
		if(hitsounds.length > 0)
		{
			if(!hitsounds.contains(ClientPrefs.data.hitsound))
				ClientPrefs.data.hitsound = ClientPrefs.defaultData.hitsound;

			hitsounds.insert(0, ClientPrefs.defaultData.hitsound);
			var option:Option = new Option('Hitsound:\n',
				'What soud should notes make when you hit them?',
				'hitsound',
				'string',
				#if MODS_ALLOWED hitsounds #else ['Osu!Mania', 'Bass Dry', 'Clap', 'Click', 'Dyssodia', 'Remu', 'Simple', 'Flourescent', 'Pop', 'Tick'] #end);
			addOption(option);
            option.onChange = onChangeHitsoundVolume;
		}

		var option:Option = new Option('Hitsound Volume',
			'Funny notes does \"Tick!\" when you hit them.',
			'hitsoundVolume',
			'percent');
		addOption(option);
		option.scrollSpeed = 1.6;
		option.minValue = 0.0;
		option.maxValue = 1;
		option.changeValue = 0.1;
		option.decimals = 1;
		option.onChange = onChangeHitsoundVolume;

		/*var option:Option = new Option('Play miss sounds',
			"If unchecked, the will be no miss sound played when you miss a note.",
			'missSound',
			'bool');
		addOption(option);*/

		var option:Option = new Option('Vocals Volume',
			'Changes the vocals volume.',
			'voiceVolume',
			'percent');
		addOption(option);
		option.scrollSpeed = 1.6;
		option.minValue = 0.0;
		option.maxValue = 1;
		option.changeValue = 0.1;
		option.decimals = 1;

		var option:Option = new Option('Instrumental Volume',
			'Changes the instrumental volume',
			'instVolume',
			'percent');
		addOption(option);
		option.scrollSpeed = 1.6;
		option.minValue = 0.0;
		option.maxValue = 1;
		option.changeValue = 0.1;
		option.decimals = 1;

		var option:Option = new Option('Always Play Hitsounds',
			'Plays the hits sound even when there are no notes.',
			'strumHit',
			'bool');
		addOption(option);
		option.onChange = onChangeHitsoundVolume;

		super();
	}

	var changedMusic:Bool = false;
	var changedHit:Bool = false;

    var changedMenu:Bool = false;
	function onChangePauseMusic()
	{
		if(ClientPrefs.data.pauseMusic == 'None')
			FlxG.sound.music.volume = 0;
		else
			FlxG.sound.playMusic(Paths.music(Paths.formatToSongPath('pause_menu/' + ClientPrefs.data.pauseMusic)));

		changedMusic = true;
	}


	function onChangeHitsoundVolume()
	{
		FlxG.sound.play(Paths.hitsound(ClientPrefs.data.hitsound), ClientPrefs.data.hitsoundVolume);
	}

	override function destroy()
	{
		if(!OptionsState.onPlayState)  FlxG.sound.playMusic(Paths.music('menu/offsetSong'));
		super.destroy();
	}
}
