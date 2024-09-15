package substates;

import objects.AttachedText;
import objects.CheckboxThingie;
import backend.Modifiers;
import backend.StageData;
import flixel.FlxG;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;
import flixel.text.FlxText;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.tweens.FlxTween;
import flixel.math.FlxMath;

class ModifiersSubState extends MusicBeatSubstate
{
    private var modTypes:Array<String> = ["General", "Chart", "Gameplay", "Challenge", "Fun"];
    private var currentModTypeIndex:Int = 0;
    private var modType:String;
    private var curOption:Modifiers = null;
    private var curSelected:Int = 0;
    private var optionsArray:Array<Modifiers> = [];
    private var grpOptions:FlxTypedGroup<Alphabet>;
    private var checkboxGroup:FlxTypedGroup<CheckboxThingie>;
    private var grpTexts:FlxTypedGroup<AttachedText>;
    private var descBox:FlxSprite;
    private var descText:FlxText;
    private var controlTipText:FlxText;
    private var modTypeText:FlxText;
    public static var onPlayState:Bool = false;
    private var nextAccept:Int = 5;
    private var holdTime:Float = 0;
    private var holdThreshold:Float = 0.5;
    private var holdValue:Float = 0;

    public function new()
    {
        super();
        modType = "General";
        initializeUI();
        createModifiers();
        FlxG.mouse.visible = true;
    }

    private function initializeUI():Void
    {
        var bg:FlxSprite = new FlxSprite().loadGraphic(Paths.image('menuDesat'));
        bg.antialiasing = ClientPrefs.data.antialiasing;
        bg.color = 0xFF45CA11;
        bg.updateHitbox();
        bg.screenCenter();
        add(bg);

        var blackBox:FlxSprite = new FlxSprite(0, 0).makeGraphic(FlxG.width, 50, FlxColor.BLACK);
        blackBox.alpha = 0.5;
        add(blackBox);

        descBox = new FlxSprite().makeGraphic(1, 1, FlxColor.BLACK);
        descBox.alpha = 0.6;
        add(descBox);

        grpOptions = new FlxTypedGroup<Alphabet>();
        add(grpOptions);

        grpTexts = new FlxTypedGroup<AttachedText>();
        add(grpTexts);

        checkboxGroup = new FlxTypedGroup<CheckboxThingie>();
        add(checkboxGroup);

        descText = createFlxText(50, 600, 1180, 32, "");
        add(descText);

        addTabs();
    }

    private function createFlxText(x:Int, y:Int, width:Int, size:Int, text:String):FlxText
    {
        var flxText:FlxText = new FlxText(x, y, width, text, size);
        flxText.setFormat(Paths.font("vcr.ttf"), size, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        flxText.scrollFactor.set();
        return flxText;
    }

    private function addTabs():Void
    {
        var tabSpacing:Int = 150;
        var startX:Int = Std.int(FlxG.width / 2 - (modTypes.length - 1) * tabSpacing / 2);
    
        for (i in 0...modTypes.length)
        {
            var tabButton:FlxButton = new FlxButton(startX + i * tabSpacing, 10, modTypes[i], switchModType.bind(i));
            tabButton.label.setFormat(Paths.font("vcr.ttf"), 16, FlxColor.WHITE, CENTER);

            tabButton.makeGraphic(Std.int(tabButton.label.width + 20), Std.int(tabButton.height), FlxColor.BLACK);
            tabButton.label.setPosition(Std.int(tabButton.width / 2 - tabButton.label.width / 2), Std.int(tabButton.height / 2 - tabButton.label.height / 2));

            add(tabButton);
        }
    }

    private function switchModType(index:Int):Void
    {
        currentModTypeIndex = index;
        createModifiers();
        FlxG.sound.play(Paths.sound('scrollMenu'));
    }

    private function createModifiers():Void
    {
        modType = modTypes[currentModTypeIndex];
        optionsArray = getOptions(modType);
        updateMenu();
    }

    private function updateMenu():Void
    {
        grpOptions.clear();
        checkboxGroup.clear();
        grpTexts.clear();

        for (i in 0...optionsArray.length)
        {
            var optionText:Alphabet = new Alphabet(200, 360 + i * 40, optionsArray[i].name, true);
            optionText.isMenuItem = true;
            optionText.setScale(0.8);
            optionText.targetY = i;
            grpOptions.add(optionText);

            if(optionsArray[i].type == 'bool') {
                positionCheckbox(optionText, i);
            } else {
                var valueText = createAttachedText(Std.string(optionsArray[i].getValue()), optionText.width + 40, i);
                grpTexts.add(valueText);
                optionsArray[i].setChild(valueText);
            }
            updateTextFrom(optionsArray[i]);
        }

        changeSelection(0); // Reset selection to first option
        reloadCheckboxes();
    }

    private function positionCheckbox(optionText:Alphabet, i:Int):Void
    {
        optionText.x += 90;
        optionText.startPosition.x += 90;
        optionText.snapToPosition();
        var checkbox:CheckboxThingie = new CheckboxThingie(optionText.x - 105, optionText.y, optionsArray[i].getValue() == true);
        checkbox.sprTracker = optionText;
        checkbox.offsetX -= 20;
        checkbox.offsetY = -52;
        checkbox.ID = i;
        checkboxGroup.add(checkbox);
    }

    private function createAttachedText(value:String, offsetX:Float, ID:Int):AttachedText
    {
        var valueText:AttachedText = new AttachedText(value, offsetX, 0, true, 0.8);
        valueText.sprTracker = grpOptions.members[ID];
        valueText.copyAlpha = true;
        valueText.ID = ID;
        return valueText;
    }

    override function update(elapsed:Float):Void
    {
        handleControls(elapsed);
        super.update(elapsed);
    }

    private function handleControls(elapsed:Float):Void
    {
        if (FlxG.keys.justPressed.Q || FlxG.keys.justPressed.E) {
            var direction:Int = FlxG.keys.justPressed.Q ? -1 : 1;
            switchModType((currentModTypeIndex + direction + modTypes.length) % modTypes.length);
        }

        if (controls.UI_UP_P || controls.UI_DOWN_P) {
            var direction:Int = controls.UI_UP_P ? -1 : 1;
            changeSelection(direction);
        }
        if (nextAccept <= 0 && curOption != null)
        {
            var direction:Int = 0;
            
            if (controls.UI_LEFT) direction = -1;
            if (controls.UI_RIGHT)direction = 1;

            if (direction != 0) {
                holdTime += elapsed;

                if (holdTime > holdThreshold) {
                    updateOptions(direction);
                    holdTime = 0;
                } 
                else if (controls.UI_LEFT_P || controls.UI_RIGHT_P) {
                    updateOptions(direction);
                }
            } 
            else holdTime = 0;

            if (FlxG.keys.justPressed.ENTER && curOption.type == 'bool') toggleCheckbox();
            if(controls.BACK){
                if(onPlayState){
                    StageData.loadDirectory(PlayState.SONG);
                    LoadingState.loadAndSwitchState(new PlayState());
                    FlxG.sound.music.volume = 0;
                    FlxG.mouse.visible = false;
                }
                else close();
                ClientPrefs.saveSettings();
                FlxG.sound.play(Paths.sound('cancelMenu'));
                
            }
        }

        if (nextAccept > 0) {
            nextAccept -= 1;
        }
    }


    private function changeSelection(change:Int = 0):Void
    {
        curSelected = Std.int(MathUtil.clamp(curSelected + change, 0, optionsArray.length - 1));
        curOption = optionsArray[curSelected];
    
        for (i in 0...grpOptions.length) {
            grpOptions.members[i].targetY = i - curSelected;
            grpOptions.members[i].alpha = (i == curSelected) ? 1 : 0.6;
        }
    
        for (text in grpTexts.members) {
            text.alpha = (text.ID == curSelected) ? 1 : 0.6;
        }
    
        FlxG.sound.play(Paths.sound('scrollMenu'));
    
        descText.text = (optionsArray[curSelected] == null) ? "No description found" : optionsArray[curSelected].description;
        descText.screenCenter(Y);
        descText.y += 270;
    
        descBox.setPosition(descText.x - 10, descText.y - 10);
        descBox.setGraphicSize(Std.int(descText.width + 20), Std.int(descText.height + 25));
        descBox.updateHitbox();
    }

    private function updateOptions(direction:Int):Void
    {
        if (curOption != null) {
            if (curOption.type != 'string') {
                holdValue = curOption.getValue() + direction * curOption.changeValue;
                holdValue = Math.max(curOption.minValue, Math.min(curOption.maxValue, holdValue));

                switch (curOption.type)
                {
                    case 'int': curOption.setValue(Math.round(holdValue));
                    case 'float', 'percent': curOption.setValue(FlxMath.roundDecimal(holdValue, curOption.decimals));
                }

                updateTextFrom(curOption);
                curOption.change();
                FlxG.sound.play(Paths.sound('scrollMenu'));
            }
            else if (curOption.type == 'string') {
                var currentIndex:Int = curOption.options.indexOf(curOption.getValue());
                currentIndex = (currentIndex + direction + curOption.options.length) % curOption.options.length;

                curOption.setValue(curOption.options[currentIndex]);

                updateTextFrom(curOption);
                curOption.change();
                FlxG.sound.play(Paths.sound('scrollMenu'));
            }
        }
    }



    private function toggleCheckbox():Void
    {
        if (curSelected < checkboxGroup.length) {
            var checkbox:CheckboxThingie = checkboxGroup.members[curSelected];
            curOption.setValue((curOption.getValue() == true) ? false : true);
            reloadCheckboxes();
            FlxG.sound.play(Paths.sound('checkbox'));
        }
    }

    private function reloadCheckboxes():Void
    {
        for (checkbox in checkboxGroup.members)
        {
            checkbox.daValue = (optionsArray[checkbox.ID]?.getValue() == true);
        }
    }

    private function updateTextFrom(option:Modifiers):Void
    {
        var text:String = option.displayFormat;
        var val:Dynamic = option.getValue();
        if(option.type == 'percent') val *= 100;
        var def:Dynamic = option.defaultValue;
        option.text = text.replace('%v', val).replace('%d', def);

        descText.text = option.description;
        descBox.makeGraphic(Std.int(descText.width + 20), Std.int(descText.height + 20));
        descBox.screenCenter(X);
        descText.screenCenter(X);
    }

    private function getOptions(modType:String):Array<Modifiers>
    {
        var options:Array<Modifiers> = [];

        switch (modType.toLowerCase()) 
        {
            case "general":
                options.push(new Modifiers('Practice Mode', 'Enjoy a penalty-free experience.', 'practice', 'bool'));
                options.push(new Modifiers('Botplay', 'Automatically plays the game.', 'botplay', 'bool'));
                
                var scrollTypes:Modifiers = new Modifiers('Scroll Type', 'Changes how the scroll speed is calculated.', 'scrolltype', 'string', 'multiplicative', ["multiplicative", "constant"]);
                options.push(scrollTypes);

                var scroll_speed:Modifiers = new Modifiers(
                    'Scroll Speed',
                    'Adjust the speed at which notes move.',
                    'scrollspeed', 
                    'float', 
                    1);
                scroll_speed.scrollSpeed = 2.0;
                scroll_speed.minValue = 0.25;
                scroll_speed.changeValue = 0.05;
                scroll_speed.decimals = 2;
                switch(scrollTypes.getValue().toLowerCase()){
                    case 'constant':
                        scroll_speed.displayFormat = "%v";
                        scroll_speed.maxValue = 6;                
                    default:
                        scroll_speed.displayFormat = '%vX';
                        scroll_speed.maxValue = 3;
                }
                options.push(scroll_speed);

                var playbackRate:Modifiers = new Modifiers(
                    'Playback Rate', 
                    'Adjusts the speed of the game.',
                    'songspeed', 
                    'float', 
                    1);
                playbackRate.scrollSpeed = 1;
                playbackRate.minValue = 0.25;
                playbackRate.maxValue = 3.0;
                playbackRate.changeValue = 0.05;
                playbackRate.displayFormat = '%vX';
                playbackRate.decimals = 2;
                #if FLX_PITCH
                options.push(playbackRate);
                #end

            case "chart":
                options.push(new Modifiers('Flip Notes', 'Notes flip their positions.', 'flipChart', 'bool'));
                options.push(new Modifiers('Randomize Notes', 'Notes appear in randomized patterns.', 'randomizeChart', 'bool'));
                options.push(new Modifiers('Mirror Chart', 'Sections switch places.', 'mirrorChart', 'bool'));
                options.push(new Modifiers('Remove Mine Notes', 'Removes mine notes from the chart.', 'noMines', 'bool'));

            case "gameplay":
                options.push(new Modifiers('Fair Play', 'Opponents gain health when hitting notes.', 'fairplay', 'bool'));

                var healthGain:Modifiers = new Modifiers(
                    'Health Gain Multiplier\n', 
                    'Amplifies the rate at which players recover health.',
                    'healthgain', 
                    'float', 
                    1);
                healthGain.scrollSpeed = 2.5;
                healthGain.minValue = 0;
                healthGain.maxValue = 5;
                healthGain.changeValue = 0.1;
                healthGain.displayFormat = '%vX';
                options.push(healthGain);
        
                var healthLoss:Modifiers = new Modifiers(
                    'Health Loss Multiplier\n',
                    'Amplifies the rate at which players lose health.',
                    'healthloss', 
                    'float', 
                    1);
                healthLoss.scrollSpeed = 2.5;
                healthLoss.minValue = 0;
                healthLoss.maxValue = 5;
                healthLoss.changeValue = 0.1;
                healthLoss.displayFormat = '%vX';
                options.push(healthLoss);

            case "challenge":
                options.push(new Modifiers('Three-Quarters', 'Keep your accuracy above 75%.', 'accuracyChallenge', 'bool'));
                options.push(new Modifiers('Death Mode', "Miss a note and it's over.", 'instakill', 'bool'));
                options.push(new Modifiers('Perfect Combo', "Hitting anything other than 'Sick' will result in an instant loss.", 'perfectcombo', 'bool'));
                #if FLX_PITCH options.push(new Modifiers('Nightcore', 'Feel the energetic and upbeat vibe.', 'nightcore', 'bool')); #end

            case "fun":
                #if FLX_PITCH options.push(new Modifiers('Daycore', 'Feel the relaxed and mellow vibe.', 'daycore', 'bool')); #end
                #if web options.push(new Modifiers('Dummy', "Nothin' to see her bud.", 'dummy', 'bool')); #end
        }
        return options;
    }

    override function close():Void
    {
        FlxG.mouse.visible = false;
        super.close();
    }
}
