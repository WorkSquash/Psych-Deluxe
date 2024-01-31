package options.preferences;

import objects.Alphabet;

class AudioSettingsSubState extends BaseOptionsMenu
{
	public function new()
	{
		title = 'Audio';
		rpcTitle = 'Audio Settings Menu'; //for Discord Rich Presence

		
		var option:Option = new Option('Pause Screen Song:',
			"What song do you prefer for the Pause Screen?",
			'pauseMusic',
			'string',
			['None', 'Breakfast', 'Tea Time', 'Local Forecast', 'Sovereign']);
		addOption(option);
		option.onChange = onChangePauseMusic;


		//Not implementented
		/*var option:Option = new Option('Menu Screen Song:',
			"What song do you prefer for the menu Screen?",
			'menuMusic',
			'string',
			['Default', 'Deluxe', 'Festive']
			);
		addOption(option);
		option.onChange = onChangeMenuMusic;*/

		
		//Unused for now
        /*var songs:Array<String> = Mods.mergeAllTextsNamed('music/tracks.txt', 'assets');
		if(songs.length > 0)
		{
			if(!songs.contains(ClientPrefs.data.menuMusic)) ClientPrefs.data.menuMusic = ClientPrefs.defaultData.menuMusic; //Reset to default if saved menu music couldnt be found

			songs.insert(0, ClientPrefs.defaultData.menuMusic); //Default track always comes first
			var option:Option = new Option('Menu Screen Song:',
				"What song do you prefer for the menu Screen?",
				'menuMusic',
				'string',
				#if MODS_ALLOWED songs #else ['Default', 'Deluxe'] #end);
			addOption(option);
            option.onChange = onChangeMenuMusic;
		}*/
		
		var hitsounds:Array<String> = Mods.mergeAllTextsNamed('sounds/hitsounds.txt', 'shared');
		/*if(hitsounds.length > 0)
		{
			if(!hitsounds.contains(ClientPrefs.data.hitsound))
				ClientPrefs.data.hitsound = ClientPrefs.defaultData.hitsound; //Reset to default if saved hitsound couldn't be found

			hitsounds.insert(0, ClientPrefs.defaultData.hitsound); //Default skin always comes first
			var option:Option = new Option('Hitsound:',
				'What soud should notes make when you hit them?',
				'hitsound',
				'string',
				#if MODS_ALLOWED hitsounds #else ['Osu!Mania', 'Bass Dry', 'Clap', 'Click', 'Dyssodia', 'Remu', 'Simple', 'Flourescent', 'Pop', 'Tick'] #end);
			addOption(option);
            option.onChange = onChangeHitsoundVolume;
		}*/

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

		/*var option:Option = new Option('Vocals Volume',
			'Changes the vocals volume.',
			'vocalVolume',
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
		option.decimals = 1;*/

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
			FlxG.sound.playMusic(Paths.music(Paths.formatToSongPath(ClientPrefs.data.pauseMusic)));

		changedMusic = true;
	}

   /* function onChangeMenuMusic()
    {
        FlxG.sound.playMusic(Paths.music(Paths.formatToSongPath('/menu/'+ClientPrefs.data.menuMusic)));
        changedMenu = true;
    }*/

	function onChangeHitsoundVolume()
	{
		//FlxG.sound.play(Paths.sound(Paths.formatToSongPath('/hitsounds/' + ClientPrefs.data.hitsound)), ClientPrefs.data.hitsoundVolume);
		FlxG.sound.play(Paths.sound(('hitsound')), ClientPrefs.data.hitsoundVolume);
	}

	override function destroy()
	{
		if(!OptionsState.onPlayState) FlxG.sound.playMusic(Paths.music('freakyMenu')); //FlxG.sound.playMusic(Paths.music(Paths.formatToSongPath('/menu/'+ClientPrefs.data.menuMusic)));
		super.destroy();
	}
}
