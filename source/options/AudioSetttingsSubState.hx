package options;

class AudioSetttingsSubState extends BaseOptionsMenu
{

	public function new()
	{
		title = 'Audio Settings';
		rpcTitle = 'Audio Settings Menu'; //for Discord Rich Presence

		var option:Option = new Option('Hitsound Volume',
			'Funny notes does \"Tick!\" when you hit them."',
			'hitsoundVolume',
			'percent',
			0);
		addOption(option);
		option.scrollSpeed = 1.6;
		option.minValue = 0.0;
		option.maxValue = 1;
		option.changeValue = 0.1;
		option.decimals = 1;
		option.onChange = onChangeHitsoundVolume;


        var option:Option = new Option('Pause Screen Song:',
        "What song do you prefer for the Pause Screen?",
        'pauseMusic',
        'string',
        'Tea Time',
        ['None', 'Breakfast', 'Tea Time']);
        addOption(option);
        option.onChange = onChangePauseMusic;

		var option:Option = new Option('Title Screen Song:',
        "What song do you prefer for the Title Screen?",
        'titleMusic',
        'string',
        'Freaky Menu',
        ['Freaky Menu', 'Classic', 'Klaskii Loop', 'Give A Lil Bit Back']);
        addOption(option);
        option.onChange = onChangeTitleMusic;
    
        var option:Option = new Option('Flash Event Volume',
        'Change how loud the flashbang sound should be.',
        'flashVolume',
        'percent',
        0);
        addOption(option);
        option.scrollSpeed = 1.6;
        option.minValue = 0.0;
        option.maxValue = 1;
        option.changeValue = 0.01;
        //option.decimals = 1;
         option.onChange = onChangeFlashsoundVolume;

		super();
	}

	var changedHit:Bool = false;
	var changedMusic:Bool = false;
	var changedTitleMusic:Bool = false;
	var changedFlash:Bool = false;

	function onChangeHitsoundVolume()
	{
		FlxG.sound.play(Paths.sound('hitsound'), ClientPrefs.data.hitsoundVolume);
		FlxG.sound.music.volume = 0;
		changedHit = true;
	}
	
    function onChangeTitleMusic()
	{
		FlxG.sound.playMusic(Paths.music(Paths.formatToSongPath(ClientPrefs.data.titleMusic)));
		changedTitleMusic = true;
	}


	function onChangePauseMusic()
		{
			if(ClientPrefs.data.pauseMusic == 'None')
				FlxG.sound.music.volume = 0;
			else
				FlxG.sound.playMusic(Paths.music(Paths.formatToSongPath(ClientPrefs.data.pauseMusic)));
	
			changedMusic = true;
		}
	
    function onChangeFlashsoundVolume()
		{
			FlxG.sound.play(Paths.sound('flash'), ClientPrefs.data.flashVolume);
			FlxG.sound.music.volume = 0;
			changedFlash = true;
		}

	override function destroy()
		{
			if(changedMusic){
				FlxG.sound.playMusic(Paths.music(Paths.formatToSongPath(ClientPrefs.data.titleMusic)));
				super.destroy();
			} 

			if(changedTitleMusic){
				FlxG.sound.playMusic(Paths.music(Paths.formatToSongPath(ClientPrefs.data.titleMusic)));
				super.destroy();
			} 

			if(changedHit){
				FlxG.sound.playMusic(Paths.music(Paths.formatToSongPath(ClientPrefs.data.titleMusic)));
				super.destroy();
			}
			
			if(changedFlash){
				FlxG.sound.playMusic(Paths.music(Paths.formatToSongPath(ClientPrefs.data.titleMusic)));
				super.destroy();
			}
		}
	
}