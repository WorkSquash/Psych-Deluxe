local noteTypeColors = {
  ['Hurt Note'] = {{'ff0000','440000','000000'}},
  [''] = {{'ffffff', 'ffffff', '000000'}}
}
function onSpawnNote(i,d,nt,s)
  if noteTypeColors[nt] then
    local e = #noteTypeColors[nt]
    local a = (d%e)+1
    setPropertyFromGroup('notes',i,'rgbShader.r',getColorFromHex(noteTypeColors[nt][a][1]))
    setPropertyFromGroup('notes',i,'rgbShader.g',getColorFromHex(noteTypeColors[nt][a][2]))
    setPropertyFromGroup('notes',i,'rgbShader.b',getColorFromHex(noteTypeColors[nt][a][3]))
  end
end
function goodNoteHit(i,d)
  local colors = {}
  colors[1] = getPropertyFromGroup('notes',i,'rgbShader.r')
  colors[2] = getPropertyFromGroup('notes',i,'rgbShader.g')
  colors[3] = getPropertyFromGroup('notes',i,'rgbShader.b')
  setColors(d+4,colors)
end
function opponentNoteHit(i,d)
  local colors = {}
  colors[1] = getPropertyFromGroup('notes',i,'rgbShader.r')
  colors[2] = getPropertyFromGroup('notes',i,'rgbShader.g')
  colors[3] = getPropertyFromGroup('notes',i,'rgbShader.b')
  setColors(d,colors)
end
function noteMiss(i,d)
  if getPropertyFromGroup('notes',i,'hitCausesMiss') then
    local colors = {}
    colors[1] = getPropertyFromGroup('notes',i,'rgbShader.r')
    colors[2] = getPropertyFromGroup('notes',i,'rgbShader.g')
    colors[3] = getPropertyFromGroup('notes',i,'rgbShader.b')
    setColors(d+4,colors)
  end
end
function setColors(d,colors)
  setPropertyFromGroup('strumLineNotes',d,'rgbShader.r', colors[1])
  setPropertyFromGroup('strumLineNotes',d,'rgbShader.g', colors[2])
  setPropertyFromGroup('strumLineNotes',d,'rgbShader.b', colors[3])
end
function addNoteColors(t, colors)
  noteTypeColors[t] = colors
end