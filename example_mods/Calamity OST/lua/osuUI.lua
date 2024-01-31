local scriptEnabled = true;
function onCreatePost()
    if scriptEnabled then
        setProperty('healthBar.angle', 90);
        setProperty('healthBar.y', 375);
        if middlescroll then
            setProperty('healthBar.x', 600);
        else
            setProperty('healthBar.x', 925);
        end
        setProperty('iconP2.visible', false);
        setProperty('iconP1.visible', false);
        setProperty('timeBar.visible', false);
        setProperty('timeTxt.visible', false);
        setProperty('scoreTxt.y', 10);
    end
end

function onUpdate(elapsed)
    if not middlescroll and scriptEnabled then
        for i = 0,3 do
            setPropertyFromGroup('strumLineNotes', i, 'alpha', 0);
        end
    
        setPropertyFromGroup('playerStrums', i, 'x', defaultPlayerStrumX0 - 320);
        setPropertyFromGroup('playerStrums', 1, 'x', defaultPlayerStrumX1 - 320);
        setPropertyFromGroup('playerStrums', 2, 'x', defaultPlayerStrumX2 - 320);
        setPropertyFromGroup('playerStrums', 3, 'x', defaultPlayerStrumX3 - 320);
    end
end