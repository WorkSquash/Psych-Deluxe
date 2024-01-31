import objects.Bar;

var timeCol:Array<FlxColor> = [0xFF0000, 0x00FF00, 0x0000FF, 0xFFFF00,  0xFF00FF,  0x00FFFF, 0xAA00FF, 0xFFFFFF];
var healthCol:Array<FlxColor> = [0xFF0000, 0x00FF00, 0x0000FF, 0xFFFF00,  0xFF00FF,  0x00FFFF, 0xAA00FF, 0xFFFFFF];

function onCreatePost(){
    if(ClientPrefs.data.timeBarType != 'Disabled'){
        game.timeBar.visible = true;
        game.timeTxt.visible = true;
        if(getModSetting(timebarScheme))game.timeBar.setColors(timeCol[FlxG.random.int(0,7)],FlxColor.fromInt(0x00000000));
    }
    if(!ClientPrefs.data.hideHud){
        game.healthBar.angle = 90;
        game.healthBar.x = 600;
        game.healthBar.y = 375;
        if(getModSetting(healtbarScheme == 'Classic'))game.healthBar.setColors(FlxColor.fromInt(0xFFFF0000),FlxColor.fromInt(0xFF66FF33));
        else game.healthBar.setColors(healthCol[FlxG.random.int(0,3)], healthCol[FlxG.random.int(4,7)]);
    }
    
    if(ClientPrefs.data.hideHud) game.healthBar.visible = true;
    game.iconP1.visible = false;
    game.iconP2.visible = false;
    game.oppUnderlay.visible = false;
    game.playerUnderlay.visible = false;
}
