
--Dynamic stage changes the background depending on the song...
function onCreate()
	if songName == "Infestation" then
		makeLuaSprite('bg', 'songBackgrounds/Infestation', -900, -650);
	elseif songName == "The Filthy Mind" then
		makeLuaSprite('bg', 'songBackgrounds/TheFilthyMind', -900, -650);
	elseif songName == "Return To Slime" then
		makeLuaSprite('bg', 'songBackgrounds/ReturnToSlime', -900, -650);
	elseif songName == "Inferior Fabrications" then
		makeLuaSprite('bg', 'songBackgrounds/InferiorFabrications', -900, -650);
	--elseif songName == "Raw, Unfiltered Calamity" then --Already made it dynamic with the calamity stage
		--makeLuaSprite('bg', 'songBackgrounds/RawUnfilteredCalamity', -900, -650);
	elseif songName == "Left Alone" then
		makeLuaSprite('bg', 'songBackgrounds/LeftAlone', -900, -650);
	elseif songName == "wasteland" then
		makeLuaSprite('bg', 'songBackgrounds/wasteland', -900, -650);
	elseif songName == "Open Frenzy" then
		makeLuaSprite('bg', 'songBackgrounds/OpenFrenzy', -900, -650);
	elseif songName == "Threats of the Ocean Floor" then
		makeLuaSprite('bg', 'songBackgrounds/ThreatsOfTheOceanFloor', -900, -650);
	elseif songName == "Hadopelagic Pressure" then
		makeLuaSprite('bg', 'songBackgrounds/HadopelagicPressure', -900, -650);
	elseif songName == "Murderswarm" then
		makeLuaSprite('bg', 'songBackgrounds/Murderswarm', -900, -650);
	elseif songName == "Fly of Beelzebub" then
		makeLuaSprite('bg', 'songBackgrounds/FlyOfBeelzebub', -900, -650);
	--elseif songName == "Stained, Brtutal Calamity" then --Already made it dynamic with the calamity stage
		--makeLuaSprite('bg', 'songBackgrounds/StainedBrutalCalamity', -900, -650);
	elseif songName == "sanctuary" then
		makeLuaSprite('bg', 'songBackgrounds/sanctuary', -900, -650);
	elseif songName == "Unholy Insurgency" or songName == "Unholy Ambush" then
		makeLuaSprite('bg', 'songBackgrounds/UnholyInsurgency', -900, -650);
	elseif songName == "Interstellar Stomper" then
		makeLuaSprite('bg', 'songBackgrounds/InterstellarStomper', -900, -650);
	elseif songName == "The Leviathan Trilogy" then
		makeLuaSprite('bg', 'songBackgrounds/TheLeviathanTrilogy', -900, -650);
	elseif songName == "Guardian of The Former Seas" then
		makeLuaSprite('bg', 'songBackgrounds/GuardianOfTheFormerSeas', -900, -650);
	else -- Default background
		makeLuaSprite('bg', 'songBackgrounds/missing', -900, -650);
		addCamGlitch('hud', 0.15, 1.5, 3.46, 7.75);
		addCamGlitch('game', 0.5, 1.5, 3.46, 10.5);
	end
	setScrollFactor('bg', 0.9, 0.9);
	scaleObject('bg', 1.2, 1.15);
	addLuaSprite('bg', false);
end