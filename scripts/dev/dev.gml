//Change settings based on selected config
#macro CONFIG os_get_config()
#macro BUILD "Build"

//Current game version
#macro VERSION 0.1
#macro SETTINGS_VERSION 0.1

function updateSaveToCurrentVersion()
{
	//This is what we run if an older save file is detected on a newer build
	//Updates the save file structure to match the global level array
	if (file_exists(SAVE_FILE))
	{
		var save = loadJSON(SAVE_FILE);
		
		//Load this baby in to help with versioning
		//Practically immune to version changes, it's so stupid simple
		global.completedLevels = save.completedLevelsArray;
		
		//This is fine for now
		//At least the unlocked level set amount won't overflow
		var oldUnlockedLevelSets = save.unlockedLevelSets;
		global.unlockedLevelSets = min(oldUnlockedLevelSets, levelSetSize - 1);
		
		//Init save file normally
		var levelSetSize = array_length(levelArray);
		for (var i = 0; i < levelSetSize; i++)
		{
			var length = array_length(levelArray[i]);
			for (var j = 0; j < length; j++)
			{
				global.levelProgressionArray[i][j] = false;
			}
		}
		
		//Find all completed levels and mark them as such
		var length = array_length(global.completedLevels);
		for (var i = 0; i < length; ++i)
		{
		    var coord = findLevelFromArray(global.completedLevels[i]);
			
			global.levelProgressionArray[coord[0]][coord[1]] = true;
		}
		
		saveProgression();
		saveSettings();
	} else
	{
		initSaveFile();
	}
}