function onUpdate()
    if middlescroll or difficultyName == 'Death' then
        for i = 0,3 do
            setPropertyFromGroup('strumLineNotes', i, 'alpha', 0)
        end
        setPropertyFromGroup('playerStrums', 0, 'x', defaultPlayerStrumX0 - 320);
        setPropertyFromGroup('playerStrums', 1, 'x', defaultPlayerStrumX1 - 320);
        setPropertyFromGroup('playerStrums', 2, 'x', defaultPlayerStrumX2 - 320);
        setPropertyFromGroup('playerStrums', 3, 'x', defaultPlayerStrumX3 - 320);
    end
end