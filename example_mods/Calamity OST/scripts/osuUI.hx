import objects.Bar;

import StringTools;

function onCreatePost(){
    if(ClientPrefs.data.timeBarType != 'Disabled'){
        game.timeBar.visible = false;
        game.timeTxt.visible = true;
    }
    if(!ClientPrefs.data.hideHud){
        game.healthBar.angle = 90;
        game.healthBar.x = 600;
        game.healthBar.y = 375;
        game.healthBar.setColors(FlxColor.fromInt(0xFFFF0000),FlxColor.fromInt(0xFF66FF33));
    }
    
    if(ClientPrefs.data.hideHud) game.healthBar.visible = true;
    game.iconP1.visible = false;
    game.iconP2.visible = false;
}
