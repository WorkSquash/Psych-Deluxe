package states.stages;

import states.stages.objects.*;
import objects.Character;
import openfl.utils.Assets as OpenFlAssets;

#if VIDEOS_ALLOWED
import flixel.FlxSubState;
import hxvlc.flixel.FlxVideoSprite;
#end

class SongBackground extends BaseStage {
    var bg:FlxSprite;
    #if VIDEOS_ALLOWED
        var video:FlxVideoSprite;
        var foundFile:Bool = false;
    #end

    override function createPost() {
        boyfriend.visible = false;
        gf.visible = false;
        dad.visible = false;

        bg = new FlxSprite(0, 0);
        bg.loadGraphic(Paths.image('songBackgrounds/${songName}'));
        bg.scrollFactor.set(0.9, 0.9);
        bg.setGraphicSize(Std.int(bg.width * 1.35), Std.int(bg.height * 1.35));
        bg.updateHitbox();
        bg.screenCenter();
        addBehindGF(bg);

        #if VIDEOS_ALLOWED
            checkForVideo();
        #end
    }

    #if VIDEOS_ALLOWED
    private function checkForVideo() {
        var videoPath = Paths.video('background/${songName}');
        #if sys
            foundFile = FileSystem.exists(videoPath);
        #else
            foundFile = OpenFlAssets.exists(videoPath);
        #end

        if (foundFile && ClientPrefs.data.playVideos) {
            initVideo(videoPath);
        }
    }

    private function initVideo(videoPath:String) {
		video = new FlxVideoSprite(0, 0);
		trace('Loading video from: ' + videoPath);
		video.load(videoPath);
		video.setGraphicSize(bg.width, bg.height);
		video.updateHitbox();
		video.screenCenter();
	
		// Adjusted to return Bool
		video.bitmap.onFormatSetup.add(function():Bool {
			if (video.bitmap != null && video.bitmap.bitmapData != null) {
				video.setGraphicSize(bg.width, bg.height);
				video.updateHitbox();
				video.screenCenter();
				video.bitmap.volume = 0;
				return true;
			}
			return false;
		});
	
		video.cameras = game.camOther;
		addBehindGF(video);
		remove(bg);
	}

    override function countdownTick(count:Countdown, num:Int) {
        if (foundFile && num == 4) video.play();
    }

    override function openSubState(SubState:FlxSubState) {
        if (paused && foundFile) video.pause();
    }

    override function closeSubState() {
        if (paused && foundFile) video.resume();
    }

    function doDeathCheck() {
        if (foundFile) video.destroy();
    }
    #end
}